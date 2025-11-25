library(readxl)
library(tidyverse)

data_sources <- read_xlsx("data_sources.xlsx")
data_sources <- data_sources %>% arrange(Resource)

header <-
'---
title: "Data Sources"
title-block-banner: banner2.png
---

<!-- NOTE: DO NOT EDIT THIS PAGE MANUALLY !!!! SEE 00_create_data_sources.R -->

This table summarizes commonly used data sources for population health, health services, and social science research at BU. It includes administrative claims, EHR, survey, and public health datasets.

Some of the resources are publicly available (<span style="
  display: inline-block;
  background:#e7f1ff;   /* very light blue */
  color:#0d6efd;        /* bootstrap blue */
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 0.75em;
">
  public
</span>),
while others require special credentials (<span style="
  display: inline-block;
  background:#fde7e9;   /* very light red/pink */
  color:#d63333;        /* strong red */
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 0.75em;
">
  private
</span>).


| Resource                          | Category        | Description                 |
|-----------------------------------|---------------|--------------------------------|'

create_row <- function(i) {

  title <- paste0("[**",data_sources$Resource[i], "**]")
  qmd <- paste0("(",data_sources$QMD[i], ")")
  ispublic <- data_sources$`public/private`[i]

  if (ispublic  == 'private') {
    tag <- '<span style="display: inline-block;background:#fde7e9;   /* very light red/pink */color:#d63333;        /* strong red */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">private</span>'
  } else {
    tag <- '<span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">public</span>'
  }

  xcat <- data_sources$Category[i]
  xdesc <- data_sources$Description[i]

  full_row <- paste0("| ", title, qmd, " ",tag, " | ", xcat, " | ", xdesc, " |" )
  return(full_row)
}

all_rows_l <- lapply(1:nrow(data_sources), create_row)
all_rows <- do.call(c, all_rows_l)


xtail <-
  '<br>
<br>

## Additional resources:

While not housed at BU, these additional resources may be useful in answering specific resource questions, and DataHub team members can provide assistance in working with these data.

| Data Source    | Description                                                                 | Population/Coverage                          | Access & Restrictions              | Notes/Links                                                                 |
|-----------------|-----------------------------------------------------------------------------|----------------------------------------------|-----------------------------------|------------------------------------------------------------------------------|
| **NHANES**   <span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;"> public</span>    | National Health and Nutrition Examination Survey                            | National, representative sample               | Public + restricted access tiers  | [NHANES](https://www.cdc.gov/nchs/nhanes/index.htm)                          |
| **NSDUH**    <span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">public</span>    | National Survey on Drug Use and Health                                      | US residents aged ≥12                         | Public microdata via SAMHDA       | [NSDUH](https://www.samhsa.gov/data/data-we-collect/nsduh-national-survey-drug-use-and-health) |
| **HRS**         | Health and Retirement Study                                                 | US adults ≥50, longitudinal panel             | Public + restricted files         | [HRS](https://hrs.isr.umich.edu/data-products)                              |
| **BRFSS**   <span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">public</span>   | Behavioral Risk Factor Surveillance System                                  | National; state-level behavioral data         | Public                             | [BRFSS](https://www.cdc.gov/brfss/)                                         |
| **MEPS**     <span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">public</span>   | Medical Expenditure Panel Survey                                            | US households and medical providers           | Public                             | [MEPS](https://meps.ahrq.gov/mepsweb/)                                      |
| **Vital Statistics (NCHS)** <span style="display: inline-block;background:#fde7e9;   /* very light red/pink */color:#d63333;        /* strong red */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">private</span>| Birth, death, fetal death, marriage, and divorce data               | National and state-level                      | Public (some restricted use)       | [CDC Vital Stats](https://www.cdc.gov/nchs/nvss/)                            |
| **SEER-Medicare** <span style="display: inline-block; background:#fde7e9;   /* very light red/pink */color:#d63333;        /* strong red */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">private</span>| Linked cancer registry and Medicare claims data                           | Cancer patients ≥65                           | Application through NCI/ResDAC     | [SEER-Medicare](https://healthcaredelivery.cancer.gov/seermedicare/)        |
| **HCUP**   <span style="display: inline-block; background:#fde7e9;   /* very light red/pink */color:#d63333;        /* strong red */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">private</span>     | Healthcare Cost and Utilization Project                                     | Inpatient, ED, ambulatory visits              | State-specific, requires purchase | [HCUP](https://www.hcup-us.ahrq.gov/)                                        |'

writeLines(c(header, all_rows, xtail), con = 'data_sources.qmd')


# <br>
#   <br>
#   ## Additional resources:
#
#   While not housed at BU, these additional resources may be useful in answering specific resource questions, and DataHub team members can provide assistance in working with these data.
#
# | Data Source    | Description                                                                 | Population/Coverage                          | Access & Restrictions              | Notes/Links                                                                 |
#   |-----------------|-----------------------------------------------------------------------------|----------------------------------------------|-----------------------------------|------------------------------------------------------------------------------|
#   | **NHANES**   <span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;"> public</span>    | National Health and Nutrition Examination Survey                            | National, representative sample               | Public + restricted access tiers  | [NHANES](https://www.cdc.gov/nchs/nhanes/index.htm)                          |
#   | **NSDUH**    <span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">public</span>    | National Survey on Drug Use and Health                                      | US residents aged ≥12                         | Public microdata via SAMHDA       | [NSDUH](https://www.samhsa.gov/data/data-we-collect/nsduh-national-survey-drug-use-and-health) |
#   | **HRS**         | Health and Retirement Study                                                 | US adults ≥50, longitudinal panel             | Public + restricted files         | [HRS](https://hrs.isr.umich.edu/data-products)                              |
#   | **BRFSS**   <span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">public</span>   | Behavioral Risk Factor Surveillance System                                  | National; state-level behavioral data         | Public                             | [BRFSS](https://www.cdc.gov/brfss/)                                         |
#   | **MEPS**     <span style="display: inline-block;background:#e7f1ff;   /* very light blue */color:#0d6efd;        /* bootstrap blue */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">public</span>   | Medical Expenditure Panel Survey                                            | US households and medical providers           | Public                             | [MEPS](https://meps.ahrq.gov/mepsweb/)                                      |
#   | **Vital Statistics (NCHS)** <span style="display: inline-block;background:#fde7e9;   /* very light red/pink */color:#d63333;        /* strong red */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">private</span>| Birth, death, fetal death, marriage, and divorce data               | National and state-level                      | Public (some restricted use)       | [CDC Vital Stats](https://www.cdc.gov/nchs/nvss/)                            |
#   | **SEER-Medicare** <span style="display: inline-block; background:#fde7e9;   /* very light red/pink */color:#d63333;        /* strong red */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">private</span>| Linked cancer registry and Medicare claims data                           | Cancer patients ≥65                           | Application through NCI/ResDAC     | [SEER-Medicare](https://healthcaredelivery.cancer.gov/seermedicare/)        |
#   | **HCUP**   <span style="display: inline-block; background:#fde7e9;   /* very light red/pink */color:#d63333;        /* strong red */padding: 2px 6px;border-radius: 3px;font-size: 0.75em;">private</span>     | Healthcare Cost and Utilization Project                                     | Inpatient, ED, ambulatory visits              | State-specific, requires purchase | [HCUP](https://www.hcup-us.ahrq.gov/)                                        |
#
#
#
#
#
#
#
#



