# Thesis, code and stored-output discrepancies

[Project overview](../README.md) · [Limitations](limitations.md)

This is a later technical review of the September 2024 work. It preserves the thesis and scientific files unchanged. Page numbers refer to printed thesis pages; cells count all notebook cells from 1. A discrepancy does not, by itself, establish which earlier execution or manual operation produced a result.

## Documentary and numerical discrepancies

| Topic | Thesis or narrative | Code/stored evidence | Assessment |
|---|---|---|---|
| Record-type filtering, p. 21 | 2,875 records removed; two categories described | 01:17–19 also excludes preserved specimens; 8,350 removed | Text is inconsistent; thesis table 7 agrees with code |
| Table 3, p. 21 | A second preserved-specimen row has 2,872 records | 01:15 assigns 2,872 to `MATERIAL_CITATION` | Category-label error |
| Taxonomic ranks, table 4, p. 21 | `SPECIES` 669,243; `SUBSPECIES` 15,777 | 01:23 reports 664,477 and 15,160 | Different recorded counts; execution provenance unresolved |
| End of taxonomy, p. 23 | 679,637 final records and 13,978 removed | 01:85 ends at 678,937; 679,637 is an earlier stage | Narrative mixes stages; table 7 is consistent |
| Genus filtering in notebook prose | 01:37 says 148 removed | 01:36 reports 82; thesis p. 22 also says 82 | Notebook narrative error |
| Duplicate counts, p. 25 | 45,486 duplicates | 01:116 counts all rows in duplicate groups; 01:118 removes 32,436 | Distinguish group membership from excess rows removed |
| Grid presence, p. 26 | At least five records | 02:23 uses `value > 5` | Implemented threshold differs |
| Presence counts between stages | 02:33/37/45: 674/99/292 | Model inputs 07:26, 08:27, 09:27: 682/100/292 | Unresolved transition across manual processing |
| sp1 pseudoabsences, table 9, p. 36 | 489 | 07:26 reports 488; 1,170 labelled cells | One-cell discrepancy |
| sp6 hyperparameter, table 11, p. 41 | `max_features=10` | 09:52 reports `sqrt` | Historical output differs from thesis |
| Search-score graphs | Original graph/prose calls the score ROC AUC | GridSearchCV has no `scoring`; plotted `mean_test_score` is accuracy | Incorrect metric label |
| Confusion matrices, pp. 42–44 | TP and TN labels are reversed | Output matrices follow `[[TN, FP], [FN, TP]]` | Correct interpretation shown below; matrices unchanged |
| Figure 16, p. 44 | Caption refers to sp2 | Section and corresponding ROC are for sp6 | Caption error |
| Environment/data availability, pp. 13, 20, 31 | Environment YAML and data described as available in repository | Neither exists in audited checkout | Current availability differs from thesis statement |
| Scenario description in notebook 07:105 | RCP8.5 described as low emissions | README and thesis identify it as the higher-emissions scenario | Copy/edit error in notebook text |

## Historical evaluation evidence

| Species | Best model: depth / features / trees | Train accuracy | Default test accuracy | Test AUC |
|---|---|---:|---:|---:|
| sp1 | 9 / sqrt / 100 | 0.9893162393162394 | 0.91 | 0.9674329501915708 |
| sp2 | 9 / sqrt / 200 | 1.0 | 0.97 | 0.9875776397515528 |
| sp6 | 7 / sqrt / 50 | 0.9911054637865311 | 0.94 | 0.9856486796785305 |

Sources: 07:53/61, 08:52/60 and 09:52/60. Train accuracies are stored outputs, not cross-validation means. Default test accuracies are stored rounded values.

Correct interpretation of the stored matrices at probability **> 0.60**:

| Species | TN | FP | FN | TP | Accuracy | Recall | Precision | Source |
|---|---:|---:|---:|---:|---:|---:|---:|---|
| sp1 | 80 | 7 | 12 | 135 | 0.92 | 0.92 | 0.95 | 07:68 |
| sp2 | 160 | 1 | 5 | 9 | 0.97 | 0.64 | 0.90 | 08:67 |
| sp6 | 127 | 3 | 10 | 57 | 0.93 | 0.85 | 0.95 | 09:67 |

Accuracy changes between default classification and thresholded classification are not necessarily inconsistencies. The threshold changes the decision rule. Some original prose also contains percentages that do not match its adjacent metric values; the refresh uses the stored numeric outputs.

## Scenario output counts

| Species | Baseline cells ≥ 0.60 | RCP2.6 cells ≥ 0.60 | RCP8.5 cells ≥ 0.60 |
|---|---:|---:|---:|
| sp1 | 1,403 | 1,391 | 1,466 |
| sp2 | 139 | 108 | 70 |
| sp6 | 572 | 545 | 408 |

Sources: model notebooks 07–09, cells 87/103/117; difference notebooks 10–12, cells 15–17. These are counts over the 3,106-cell model domain, not confirmed occupancy or validated physical-area changes.

## Agreements and limits of the comparison

The main cleaning totals in thesis table 7 agree with the notebook outputs. The final eight climatic predictors and four habitat predictors also agree. The thesis reports AUC rounded to 0.97/0.99/0.99, consistent with the stored values.

Visual inspection during the audit found the thesis correlation figure and the sp6 scenario panel compatible with the corresponding stored figures. This is not a claim of pixel identity for every thesis map. The thesis interpretations of future changes remain subject to the unresolved scaling and validation issues documented separately.
