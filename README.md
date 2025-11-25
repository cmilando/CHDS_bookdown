# CHDS_bookdown
A bookdown for data at the CHDS

sites:
* staging site: https://chadmilando.com/CHDS_bookdown/
* production site: https://sites.bu.edu/chds-data-hub/
* google analytics: [link](https://analytics.google.com/analytics/web/?authuser=1&utm_campaign=SuiteHeader&utm_source=UniversalPicker&utm_medium=getStarted#/a345740868p512530820/reports/intelligenthome?params=_u..nav%3Dmaui&collectionId=business-objectives)

# Quarto rendering refresher

see the overall file structure in `_quarto.yml`

the home page is index.qmd

# making a change and pushing

1) make a change and save your file

2) do
```
quarto render
```
*this may require installing the quarto cli

3) commit and push

see here for more details: https://quarto.org/docs/publishing/github-pages.html



.htaccess

```
AuthType shibboleth
 
< 2.4>
ShibCompatWith24 on
ShibRequestSetting requireSession true
 
require shib-user ~ ^.+@bu.edu
```

