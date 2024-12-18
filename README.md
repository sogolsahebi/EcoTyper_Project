# Ecotyper

### **Immune Deconvolution and Meta-Analysis**
This repository contains scripts and outputs for immune cell deconvolution and meta-analysis of immunotherapy datasets. It aims to identify immune cell types and features associated with clinical outcomes, such as **Overall Survival (OS)**, **Progression-Free Survival (PFS)**, and **Response (R vs NR)** across various cancer types and treatments.

#### **Project Workflow**
1. **Data Processing**:
   - Script: `Data_processing.Rmd`
   - Processes raw datasets and applies exclusion criteria.

2. **Deconvolution Analysis**:
   - Script: `Deconvolution_Jung_Processing_Associations.Rmd`
   - Focuses on the Jung dataset.
   - Deconvolution performed using various algorithms (e.g., CIBERSORT).

3. **CIBERSORT Analysis**:
   - Script: `CIBERSORT_AllDatasets_Processing_Associations.Rmd`
   - Performs immune deconvolution across all datasets using CIBERSORT.

4. **Meta-Analysis**:
   - Script: `CIBERSORT_MetaAnalysis_Response_Associations.Rmd`
   - Aggregates results across datasets.
   - Provides:
     - Pan-Cancer analysis.
     - Cancer-specific insights.
     - Treatment-specific associations.

#### **Repository Structure**
```plaintext
.
├── scripts/                      # Contains all RMarkdown analysis scripts
├── outputs/                      # Directory for generated outputs
│   ├── Cibersort_Alldatasets_outputs/
│   │   └── (Per-dataset results from CIBERSORT)
│   ├── Dataprocessing_outputs/   # Processed data and plots
│   ├── Deconvolution_Jung_outputs/
│   │   └── (Deconvolution plots for Jung dataset)
│   └── MetaAnalysis_outputs/     # Meta-analysis results
└── README.md                     # Project overview
```

#### **Key Datasets**
| Dataset         | Cancer Type     | Sample Size | Clinical Endpoints      | Molecular Data                     | PMID                                               |
|-----------------|-----------------|-----------------|-----------------|-----------------|-----------------|
| ICB_Auslander   | Melanoma        | 37          | Response (R vs NR)       | CTLA4, PD-1/PD-L1, IO+combo        | [30127394](https://pubmed.ncbi.nlm.nih.gov/30127394/) |
| ICB_Cloughesy   | Brain           | 28          | PFS/OS                   | PD-1/PD-L1                         | [30742122](https://pubmed.ncbi.nlm.nih.gov/30742122/) |
| ICB_Damrauer    | Bladder         | 90          | PFS/OS                   | PD-1/PD-L1                         | [36333289](https://pubmed.ncbi.nlm.nih.gov/36333289/) |
| ICB_Fehrenbacher| Lung            | 192         | PFS/OS                   | PD-1/PD-L1, chemo                  | [26970723](https://pubmed.ncbi.nlm.nih.gov/26970723/) |
| ICB_Gide        | Melanoma        | 41          | PFS/OS                   | PD-1/PD-L1                         | [30753825](https://pubmed.ncbi.nlm.nih.gov/30753825/) |
| ICB_Hugo        | Melanoma        | 27          | OS                       | PD-1/PD-L1                         | [26997480](https://pubmed.ncbi.nlm.nih.gov/26997480/) |
| ICB_IMmotion150 | Kidney          | 326         | Response (R vs NR)       | Targeted, IO+targeted, PD-1/PD-L1  | [29867230](https://pubmed.ncbi.nlm.nih.gov/29867230/) |
| ICB_Jerby_Arnon | Melanoma        | 112         | PFS                      | PD-1/PD-L1                         | [30388455](https://pubmed.ncbi.nlm.nih.gov/30388455/) |
| ICB_Jung        | Lung            | 60          | PFS                      | PD-1/PD-L1                         | [31537801](https://pubmed.ncbi.nlm.nih.gov/31537801/) |
| ICB_Kim         | Gastric         | 45          | Response (R vs NR)       | PD-1/PD-L1                         | [30013197](https://pubmed.ncbi.nlm.nih.gov/30013197/) |
| ICB_Limagne1    | Lung            | 70          | Response                 | Anti-PD-1                          | [35051357](https://pubmed.ncbi.nlm.nih.gov/35051357/) |
| ICB_Limagne2    | Lung            | 26          | Response                 | Anti-PD-1/Anti-PD-L1               | [35051357](https://pubmed.ncbi.nlm.nih.gov/35051357/) |
| ICB_Liu         | Melanoma        | 144         | PFS/OS                   | Combo, PD-1/PD-L1                  | [31792460](https://pubmed.ncbi.nlm.nih.gov/31792460/) |
| ICB_Mariathasan | Various         | 348         | OS                       | PD-1/PD-L1                         | [29443960](https://pubmed.ncbi.nlm.nih.gov/29443960/) |
| ICB_Miao1       | Kidney          | 52          | PFS/OS                   | PD-1/PD-L1                         | [29301960](https://pubmed.ncbi.nlm.nih.gov/29301960/) |
| ICB_Padron      | Pancreas        | 45          | PFS/OS                   | PD-1/PD-L1                         | [35662283](https://pubmed.ncbi.nlm.nih.gov/35662283/) |
| ICB_Powles      | Bladder         | 148         | Response (R vs NR)       | PD-1/PD-L1                         | [31686036](https://pubmed.ncbi.nlm.nih.gov/31686036/) |
| ICB_Puch        | Melanoma        | 55          | Response (R vs NR)       | PD-1/PD-L1                         | [33542239](https://pubmed.ncbi.nlm.nih.gov/33542239/) |
| ICB_Ravi        | Lung            | 148         | PFS/OS                   | PD-1/PD-L1, IO+chemo, IO+combo     | [37024582](https://pubmed.ncbi.nlm.nih.gov/37024582/) |
| ICB_Rittmeyer   | Lung            | 699         | PFS/OS                   | PD-1/PD-L1, chemo                  | [27979383](https://pubmed.ncbi.nlm.nih.gov/27979383/) |
| ICB_Snyder      | Ureteral        | 25          | PFS/OS                   | PD-1/PD-L1                         | [28552987](https://pubmed.ncbi.nlm.nih.gov/28552987/) |
| ICB_Van_Allen   | Melanoma        | 42          | PFS/OS                   | CTLA4                              | [26359337](https://pubmed.ncbi.nlm.nih.gov/26359337/) |
| ICB_VanDenEnde  | Esophageal      | 35          | PFS/OS                   | PD-L1                              | [33504550](https://pubmed.ncbi.nlm.nih.gov/33504550/) |
