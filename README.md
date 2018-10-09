### Introduction

The code in this repository creates a basic html page that lists several estimates about Vietnam Veterans. My inspiration for the page comes from the [CIA World Factbook](https://www.cia.gov/library/publications/the-world-factbook/) which provides a simple and efficient way to lookup basic facts about a country. This page attempts to do the same for the Vietnam Veteran cohort. The data source is the 2016 American Community Survey (ACS) Public Use Microdata Sample (PUMS) Person file. The ACS person file covers 50 states, District of Columbia and Puerto Rico. My intent is to build out the page by adding more ACS variables gradually.

### Required packages

The following R packages are required: survey, statebins and ggplot2. 

### Step 1 - Setup the R project and from the GitHub repository

The first step in reproducing this profile is to create a R project from the GitHub repository. You will need to have R, R Studio, and Git installed on your machine. The tutorials from the [RStudio Support Site](https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN) and the [Data Surg blog](http://www.datasurg.net/2015/07/13/rstudio-and-github/) will help you get setup with these tools. 

### Step 2 - Getting and preparing the data
        
The script *[Code_Get_Prep_Data.R](https://github.com/mihiriyer/vietvet-per-facts-2016/blob/master/Code_Get_Prep_Data.R)* will download the ACS PUMS person zip files (US and Puerto Rico) for 2011 and 2016 from the Census website. The script will unpack the csv files from the zip folder and consolidate the usa, usb and pr files. The PUMS csv files will be saved to the *Raw_Data* folder and have been added to the *.gitignore* file so that they don't get added to repository. If the files are not ignored pushes to repository will fail because of their large size. After consolidating the csv files, the script will create survey objects and subset the survey objects for Vietnam Veterans using the Military Service (MIL) and Veteran Period of Service (VPS) variables. The Vietnam Veteran survey objects are saved as Rds files (*Data_per11_viet_design.Rds* and *Data_per16_viet_design.Rds*). 

### Step 3 - Create population distribution US map with statebins package

I created a script to create a statebins map showing the distribution of Vietnam Veterans across the 50 states, District of Columbia and Puerto Rico. Running the script will result in a svg file named *viet_vet_statebin.svg* which called by the Rmd document. My thinking was that I could the reduced the time to knit the Rmd document because I usually end up knitting my Rmd many times to fix errors, typos and such. 

### Step 4 - Creating the html page with RMarkdown 

I created the html page with a RMarkdown document named *index.Rmd*. I created a css file *style.css* to modify the style of the *h2* level header. It gives the dark blue background with white color font. Otherwise the page is fairly simple, it uses the flatly theme and has a floating table of contents. 

Enjoy! 



