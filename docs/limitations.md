# Methodological limitations and unresolved risks

[Project overview](../README.md) · [Original methodology](methodology.md) · [Discrepancies](discrepancies.md)

These findings come from static review of the original code, outputs and thesis. They have not been quantified by rerunning models. No scientific correction is implemented in the presentation refresh.

## Inconsistent normalisation between training and inference

The model notebooks standardise the full labelled table with `(X - X.mean()) / X.std()` before the train/test split. For the full baseline domain and each future scenario they independently compute `(X_new - X_new.mean()) / X_new.std()`.

The latter changes the mapping from environmental values to the tree thresholds learned during fitting. Recentring each future scenario may also remove part of the environmental shift under study. This can affect baseline maps, future maps and their differences; its magnitude is unknown without a separate scientific investigation. The saved joblib model does not encapsulate the preprocessing statistics.

Pre-split standardisation also includes test-set information. Random Forest generally does not require feature scaling, and a consistent linear transformation need not materially change tree decisions, so this procedural leakage alone does not establish that the reported AUC is inflated. The separate transformation at inference is a distinct issue.

## Spatial validation and sampling

The holdout split is random, without explicit class stratification. GridSearchCV uses three non-spatial folds. No spatial blocking, independent regional evaluation, residual autocorrelation assessment or temporal validation is implemented.

Nearby cells may share environmental conditions and sampling structure. Therefore, the recorded metrics do not demonstrate geographic transferability or performance in 2050. A future validation design should explicitly match the intended interpolation or transfer task.

GBIF observation density is uneven. Requiring multiple records per cell can reflect observation effort as well as occurrence. Removing duplicate observations does not remove spatial autocorrelation between grid cells.

## Pseudoabsences

Pseudoabsences were generated manually in QGIS from 1,000 random points per species, filtered using a 0.45-degree buffer around observed presences. No random seed or repeated sampling assessment is recorded. An angular buffer does not yield a constant 50 km exclusion distance across Europe.

The exact accessible region, point-to-grid aggregation, presence/pseudoabsence conflicts and join deduplication need verification. Pseudoabsences are not observed biological absences, and unlabelled cells should not be conflated with either class. These choices affect class balance and the interpretation of model scores.

## Geographic areas and joins

Notebooks 03–05 calculate `geometry.area` in a geographic CRS; stored outputs include the corresponding warning. Raster class area is calculated as a pixel count multiplied by `raster_transform[0] ** 2`, although comments describe square metres. In an angular CRS these are angular areas, not physical square metres. Ratios may approximate local proportions, but do not establish correct physical areas or remove masking/discretisation concerns.

The baseline predictor merge expands 3,106 rows to 25,708 before `drop_duplicates(subset=['ET_ID'])`. Keeping a first row is not a substitute for investigating duplicate keys and conflicting values. Join cardinality and unique cell identifiers are not asserted. Point joins using `within` also need treatment of boundary points.

The GLOBIO class mappings differ across historical/future inputs and need verification against the corresponding product legends. Habitat 4 includes agricultural categories beyond its short shrub/grassland label.

## Feature selection and data quality

- Correlation selection uses the complete environmental domain before evaluation; it is not fitted within training folds. This is unsupervised global preprocessing, not demonstrated target leakage.
- Removal at absolute correlation ≥ 0.8 depends on column order.
- Ward linkage is applied to correlation profiles; dendrogram height is not itself a correlation coefficient.
- Notebook 06 duplicates identifier/coordinate columns during concatenation. Model notebooks later select features explicitly and exclude these fields.
- Decimal counts of floating-point coordinates are not measurements of positional uncertainty.
- Zero-coordinate and equal-latitude/longitude filters are heuristics, not comprehensive georeferencing checks.
- Taxonomic lookup depends on a live API. Exception handling can break alignment between names and returned values before concatenation by index.
- A duplicate key containing recorder names can retain equivalent observations expressed differently.

## Metrics, uncertainty and interpretation

The random forest has no fixed seed, although the train/test split does. GridSearch optimises default accuracy, despite an original graph labelling its score as ROC AUC. Class imbalance is material, especially for sp2, whose held-out set has 14 presences.

The 0.60 threshold has no documented optimisation procedure. Evaluation uses `> 0.60`, while maps use `>= 0.60`. No uncertainty intervals, repeated-split assessment, calibrated occupancy probabilities or independent future validation are provided.

Future outputs use one climate model identified in the thesis. There is no implemented multi-model climate uncertainty analysis, environmental novelty assessment or dispersal/accessibility constraint. Distribution breadth alone does not establish generalism or mobility. Interpretations of the hypotheses should remain exploratory rather than causal confirmations.

## Visual interpretation

Original maps retain automatically selected colour ranges. Difference maps do not explicitly centre the diverging colour map on zero. A change in model score is not equivalent to a measured change in occupied area. Existing captions, labels and attributions are preserved in the exported PNGs; explanatory documentation supplies context without editing the images.
