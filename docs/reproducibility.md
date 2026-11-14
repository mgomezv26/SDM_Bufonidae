# Reproducibility and known dependencies

[Project overview](../README.md) · [Data availability](data-sources.md) · [Manual QGIS workflow](methodology.md#manual-qgis-operations)

**Status: not reproducible from the tracked files alone.** No notebooks, model fits or end-to-end scientific pipeline were executed for this presentation refresh. Stored outputs are historical evidence and may reflect notebook states preceding edits to source cells.

## Historical environment evidence

| Tool | Documented version | Evidence |
|---|---|---|
| Python | 3.12.4 | Notebook metadata, notebook 01 output and thesis p. 13 |
| R | 4.3.3 | Thesis p. 13 |
| QGIS | 3.32.3-Lima | Thesis p. 13 |
| RStudio | 2023.12.1+402 | Thesis p. 13 |
| VS Code | 1.92.2 | Thesis p. 13 |

The thesis refers to `Bufonidae.yml`, but that environment file is absent from the audited repository. Kernel display names include `anura` and `Bufonidae`; they are not dependency specifications. Bibliographic software citations are not substitutes for an environment lockfile.

Python imports identify pandas, NumPy, openpyxl, pygbif, GeoPandas, Rasterio, Shapely, Contextily, Matplotlib, Seaborn, SciPy, scikit-learn and joblib. Jupyter/IPython and compatible geospatial native dependencies (GDAL/PROJ/GEOS and an I/O backend) are also relevant. Exact package versions and a tested installation combination are unknown.

The R script calls `rgbif` and `usethis`, uses `%>%` and data.table-style selection. The original package/export configuration should be recovered before asserting that a fresh R session can run it. `setwd("")` requires configuration; installation and interactive `.Renviron` editing are mixed into the acquisition script.

No speculative pinned environment is supplied in this phase.

## Dependency order and interruptions

| Stage | Requires |
|---|---|
| R acquisition → 01 | GBIF snapshot, European QGIS selection, taxonomy spreadsheets |
| 01 → 02 | CSV-to-shapefile conversion and study grid |
| 02 → 07/08/09 | Manual QGIS pseudoabsence and labelled-grid preparation |
| CHELSA + GLOBIO → 03/04/05 | Downloaded rasters and QGIS zonal means |
| 03 → 06 | QGIS centroid attributes and Excel export |
| 06 → 07/08/09 | Selected baseline predictors and species labels |
| 04/05 → 07/08/09 | Future predictor layers |
| 07/08/09 → 10/11/12 | Saved scenario prediction shapefiles |

Running notebooks in numeric order does not supply the missing manual steps.

## Concrete execution blockers

- There is no `Data/` directory or trained `.pkl` model in the checkout.
- Notebook 01 writes to `01_PREPROCESADO/`, while 02 reads a vector file under `Data/01_PREPROCESADO/`.
- Several notebook 02 export statements are commented out.
- Notebook 03 mixes `Data/Grid50/` and `Grid50/`.
- Notebook 06 writes selected predictors to `Data/Variables/`, while the model notebooks read `Data/Variables/Current/`.
- Some spreadsheets are read from the working directory without a `Data/` prefix.
- Notebook 12 mixes `Data/` and `data/`, which matters on case-sensitive filesystems.
- Some sp6 CSV output names contain `..csv`.
- Shapefile field truncation is visible in stored warnings and affects downstream column names.
- Output directory creation is not consistently automated.
- Absolute personal paths occur in stored outputs; this refresh does not remove them from the original notebooks.

## Publication validation versus scientific validation

The presentation changes can be checked without running scientific code: verify relative Markdown targets and anchors, compare exported PNG bytes against notebook outputs, validate PNG structure, compare source-file hashes, inspect new files and run `git diff --check`.

Those checks do **not** establish data completeness, package compatibility, model reproducibility, spatial generalisation or scientific validity. Any later reproduction should preserve the original results as a separate historical reference and report new results independently.
