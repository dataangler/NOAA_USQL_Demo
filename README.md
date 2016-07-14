# NOAA USQL Demo
## Overview
This repository contains code samples to accompany my live demonstration of NOAA weather data processing with ADLA as presented at Tampa Code Camp 2016.

## Source Data
The data used in the demo can be obtained from the following location: [http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/](http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/)

## About working with the data:
The original files are too large for Notepad and Notepad++. To read the first few lines of the file, e.g. to preview the format and contents, try the following PowerShell commands:

Get-Content 2012.csv -Head 10 #reads the first 10 lines

Select-String 2013.csv -Pattern "US1FLS0019" #searches csv file for specified pattern, in this case a particular station
