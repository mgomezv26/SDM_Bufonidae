# Licensing recommendation — author decision pending

[Project overview](../README.md) · [Data provenance](data-sources.md) · [Figure catalogue](figures.md)

**No licence file or licence declaration is added by this presentation refresh.** This document proposes a choice for author review; it does not grant permissions or establish rights over third-party content.

## Recommendation for original code

For a portfolio whose intended use includes straightforward reuse of the author's original code, **MIT is the recommended starting point**: a short permissive licence with retention of its notice. Consider **Apache-2.0** instead if an explicit patent grant and its associated terms are a priority. The final choice should follow confirmation of ownership and any applicable academic or contributor requirements.

Official licence texts and practical selection references:

- [MIT licence](https://choosealicense.com/licenses/mit/)
- [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- [GitHub guidance on repository licensing](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository)

These are options for the author's original code, not blanket licences for the whole scientific dataset or every image component.

## Separate scopes to document

| Material | Proposed treatment before any licence is added |
|---|---|
| Original R/Python code | Confirm rights and choose a code licence |
| Original explanatory documentation | Decide whether it shares the code licence or uses separate terms |
| GBIF occurrences | Retain the download citation and inspect constituent dataset licences |
| CHELSA/GLOBIO rasters and EEA grid | Recover product-specific licence and attribution metadata |
| Exported plots with basemaps | Retain embedded credits and check provider terms; do not imply ownership of map tiles |
| Thesis PDF | Keep outside the repository as requested; no redistribution decision is made |

The extracted maps visibly retain OpenStreetMap/CARTO or Esri/source credits. Existing attribution does not by itself establish that every reuse condition has been satisfied. No new datasets are published, and no code licence should be applied automatically to third-party inputs.
