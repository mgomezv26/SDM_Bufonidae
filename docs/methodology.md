# Original methodology and processing flow

[Project overview](../README.md) · [Reproducibility](reproducibility.md) · [Limitations](limitations.md)

This describes the September 2024 workflow from the original notebooks and thesis. Documentation added during the later presentation refresh is not a new experiment. Cell references count all cells, including Markdown, starting at 1. Thesis page references use printed page numbers, not PDF viewer indices.

## Acquisition and occurrence cleaning

`00_Download_GBIF.R` requests PRESENT records for Bufonidae (taxon key 6727), imports the GBIF download, retains selected fields and removes zero coordinates and records where latitude equals longitude. A manual QGIS selection restricts the data to Europe.

`01_Bufonidae.ipynb` filters record types and taxonomic ranks, consults the GBIF backbone, applies manual taxonomic corrections using the referenced Speybroeck et al. (2020) species list, and selects European taxa. It filters coordinate decimal counts, requires year/month information, restricts years to 1981–2010, and deduplicates a composite key containing species, event date, recorder and coordinates rounded to four decimals.

| Stage | Remaining records | Evidence |
|---|---:|---|
| Initial GBIF download | 1,544,071 | R comments and thesis pp. 14–16 |
| After initial R filters | 1,543,831 | R comments; not a new execution |
| After European selection | 701,265 | Notebook 01, cell 11 |
| Record-type filter | 692,915 | Notebook 01, cell 18 |
| Taxonomic selection completed | 678,937 | Notebook 01, cell 85 |
| Coordinate filter | 585,190 | Notebook 01, cell 93 |
| Non-missing year/month | 497,804 | Notebook 01, cell 99 |
| Period 1981–2010 | 119,268 | Notebook 01, cell 111 |
| Deduplication | 86,832 | Notebook 01, cell 118 |

These values describe different stages, not independent samples. The notebook counts 45,486 rows belonging to duplicate groups but removes 32,436 excess rows.

## Spatial aggregation and labels

QGIS converts the cleaned CSV to a point shapefile. Notebook 02 performs point-in-polygon joins against a 50 × 50 km grid, represented in EPSG:4326, and plots six species. The original grid is described as based on EEA ETRS89-LAEA reference grids. The environmental domain contains 3,106 cells.

Notebook 02 defines presence as **more than five records per cell**. This differs from the thesis wording of at least five. It produces presence counts of 674/99/292 for sp1/sp2/sp6; the later model input outputs contain 682/100/292. The intervening QGIS processing cannot be reconstructed from code alone.

## Manual QGIS operations

The thesis (pp. 15 and 26–33) describes these operations:

1. Select European GBIF records with a polygon selection and export `Bufonidae_EU_v0.csv`.
2. Import the cleaned CSV as coordinates and export `Data_Bufonidae_EU_processed.shp`.
3. Prepare the study grid and species-specific spatial layers.
4. Create grid centroids, calculate `$x` and `$y`, and join the coordinates to grid attributes.
5. For each modelled species, generate 1,000 random points within layer bounds.
6. Buffer presence points by 0.45 degrees, described as approximately 50 km; select and remove random points intersecting the exclusion region.
7. Join remaining pseudoabsence points to grid cells; assemble presence (1), pseudoabsence (0) and unlabelled (NA) cells through attribute joins and duplicate removal.
8. Export both complete-domain and labelled-only layers for each species.
9. Calculate mean CHELSA values per grid cell with zonal statistics, for each variable and scenario; export shapefiles.
10. Add centroid coordinates to the combined baseline predictor layer and export `Variables_coordenadas.xlsx`.

The exact selection geometry, random seed, processing history, parameter files and conflict-resolution rules are not tracked. This is a description of the manual workflow, not an executable reproduction recipe.

## Predictor integration and selection

Notebooks 03–05 mask GLOBIO rasters per grid cell, aggregate land-use codes into four habitat groups and calculate habitat percentages. They merge these with CHELSA zonal means using `ET_ID`, remove duplicate identifiers and export scenario tables/layers.

Notebook 06 examines 19 climatic variables and four habitat proportions. Pearson correlation filtering at absolute correlation ≥ 0.8 retains BIO1, BIO2, BIO3, BIO4, BIO5, BIO8, BIO12, BIO15 and all four habitat proportions. The procedure is column-order dependent. Ward linkage is applied to correlation profiles for the dendrogram.

The habitat labels are aquatic, evergreen-tree, deciduous-tree and shrub/grassland. The last group also includes selected agricultural classes; consult the actual code lists before interpreting it as exclusively natural habitat.

## Model fitting and evaluation

Notebooks 07–09 select the 12 predictors, excluding identifiers, coordinates and geometry. They standardise the complete labelled feature table using pandas means and sample standard deviations, then make an 80/20 random split with `random_state=0`, without explicit stratification.

`RandomForestClassifier()` has no fixed random seed. `GridSearchCV` uses three folds, `n_jobs=-1` and no explicit scoring argument. Its search metric is default classifier accuracy.

| Parameter | Search values |
|---|---|
| `n_estimators` | 10, 50, 100, 200 |
| `max_depth` | 5, 7, 9 |
| `max_features` | 10, `sqrt` |

| Species | Best depth | Best features | Best estimators | Stored output cell |
|---|---:|---|---:|---|
| sp1 | 9 | `sqrt` | 100 | 07:53 |
| sp2 | 9 | `sqrt` | 200 | 08:52 |
| sp6 | 7 | `sqrt` | 50 | 09:52 |

The selected model is evaluated with default-decision accuracy, probability-based ROC-AUC and confusion-matrix metrics at probability **> 0.60**. Models are serialised with joblib; model files are not tracked. See [historical discrepancies](discrepancies.md) for the different sp6 setting reported in the thesis.

## Scenario inference

For the full baseline grid and each future scenario, the notebooks recompute means and standard deviations on that inference dataset and then call `predict_proba`. This differs from the training transformation and is a material unresolved issue.

Maps are also thresholded at probability **≥ 0.60**. Notebooks 10–12 join by `ET_ID` and subtract baseline model scores from future scores. They preserve automatic map colour ranges. Neither inference nor these differences constitute validation against future observations.
