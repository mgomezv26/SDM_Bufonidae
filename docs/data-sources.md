# Data sources and availability

[Project overview](../README.md) · [Workflow](methodology.md)

No datasets are added by this presentation refresh. The thesis remains outside the repository. A public source or download link does not establish permission to redistribute every constituent asset.

| Source | Historical evidence | What is missing from the checkout |
|---|---|---|
| GBIF | [Occurrence download DOI](https://doi.org/10.15468/dl.rjd4ty), dated 5 July 2024 in notebook 01; 1,544,071 initial records | Original archive, metadata/licences and intermediate CSV files |
| CHELSA | [Source portal](https://chelsa-climate.org/); thesis p. 17 identifies 1981–2010 baseline and GFDL-ESM4 SSP126/SSP585 | Raster filenames, product versions, checksums, future averaging window and zonal layers |
| GLOBIO | [Download portal](https://www.globio.info/globio-data-downloads); 2010 and 2050 land-use scenarios | Rasters, accompanying legends, metadata and licence terms |
| EEA grid | [Reference grids](https://www.eea.europa.eu/data-and-maps/data/eea-reference-grids-2), cited on thesis p. 26 | Exact grid derivative, selection geometry and transformation history |
| Taxonomic reference | Speybroeck et al. (2020), [DOI](https://doi.org/10.1163/15685381-bja10010) | `List_Speybroeck_2020.xlsx` and `Species_matches_Bufonidae.xlsx` |

## Original data-sharing link

The previous README directed readers to a [Google Drive archive](https://drive.google.com/file/d/1zJ1mmGZGsKcD-xp0wV1YUJ524g06T2Aj/view?usp=drive_link), instructing them to download and decompress a `Data` folder. This link is retained for provenance. Its access permissions, contents, integrity and completeness have not been verified in this refresh; no archive was downloaded.

## Inputs referenced by the notebooks

- `Data/Bufonidae_EU_v0.csv`: European GBIF selection.
- `Data/01_PREPROCESADO/Data_Bufonidae_EU_processed.shp`: cleaned occurrences after CSV-to-vector conversion.
- `Data/Grid50/Grid_50Km_Europe_WGS84.shp`: study grid.
- `Data/GLOBIO/2010/Globio4_GBW_LU_2010_10sec.tif`: baseline land use.
- `Data/GLOBIO/RCP2_6/Globio4_landuse_10sec_2050_SSP1RCP26_cropint_pasint.tif`: lower-emissions land-use scenario.
- `Data/GLOBIO/RCP8_5/Globio4_landuse_10sec_2050_SSP5RCP85_cropint_pasint.tif`: higher-emissions land-use scenario.
- `Data/CHELSA/Estadistica_Zona/` and future-scenario `Estadistica_Zona/` directories: externally prepared zonal means.
- `Data/Variables/Variables_coordenadas.xlsx` and selected-variable tables: intermediate predictors.
- `Data/Species/`: QGIS-generated complete-domain and labelled-only layers for sp1, sp2 and sp6.
- `Data/Results/Model/` and scenario result shapefiles: saved models and prediction layers consumed by later stages.

Shapefiles require their companion files, including coordinate-system information. The paths above describe expectations; they are not existing local datasets or verified download targets.

## Provenance gaps to resolve before reproduction

Record exact versions, URLs/DOIs, filenames, licences, checksums, CRS, units, nodata values and temporal coverage for each input. Preserve the original GBIF snapshot rather than substituting a new API query and assuming identical counts. Record the GLOBIO code mapping separately for baseline and future products: notebook 03 uses 10/13/14 for part of habitat 4, while 04–05 use 2/3/4.

CHELSA scenario identifiers SSP126/SSP585 and the repository labels RCP2.6/RCP8.5 should remain explicitly mapped, not treated as interchangeable product metadata. Baseline climate is a 1981–2010 climatology, not a single-year 2010 measurement.
