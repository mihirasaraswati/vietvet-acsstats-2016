# measure run time if you wish
# start_time <- Sys.time()

library(survey)

# 2016 PUMS Files ---------------------------------------------------------
#URLs for 2016 files
us2016 <- "https://www2.census.gov/programs-surveys/acs/data/pums/2016/1-Year/csv_pus.zip"
pr2016 <- "https://www2.census.gov/programs-surveys/acs/data/pums/2016/1-Year/csv_ppr.zip"

# Create temp file to store downloaded zip file
temp <- tempfile()

## 2016 US/National - Download Person file
download.file(url = us2016, destfile = temp)

# unzip and read 2016 US files a & b
usa <- read.csv(unzip(zipfile = temp, files = "ss16pusa.csv",  exdir = "./Raw_Data"))
usb <- read.csv(unzip(zipfile = temp, files = "ss16pusb.csv",  exdir = "./Raw_Data"))

## 2016 Puerto Rico - Download Person file
download.file(url = pr2016, destfile = temp)

#unzip and read 2016 ppr file
ppr <- read.csv(unzip(zipfile = temp, files = "ss16ppr.csv",  exdir = "./Raw_Data"))

#combine all 2016 files
pums <- rbind(usa, usb, ppr)

#Alternate PUMS data read method 
# If you already have a PUMS csv file. You can put it in the Raw_Data folder you can uncomment and add the file name in line the line below
# pums <- read.csv(file = "Raw_Data/ADD NAME OF YOUR PUMS CSV FILE HERE")

pums <- svydesign(id = ~1,
                    weights = pums$PWGTP,
                    data = pums,
                    repweights = "pwgtp[0-9]+",
                    type = "JKn",
                    scale = 4/80,
                    rscales = rep(1,80),
                    combined.weights = TRUE
)

#subset for Vietnam War Veterans (MIL and VPS variables)
pums_viet <- subset(pums, MIL %in% c(2:3) & VPS %in% c(6:8))
#save svy obj as RDS file
saveRDS(pums_viet, "Data_per16_viet_design-test.Rds")
#Clear the workspace
rm(pums_viet, pums, usa, usb, ppr, us2016, pr2016)




# 2011 PUMS Files ---------------------------------------------------------
# The 2011 data are used to make one comparison - the population change of Vietnam Veterans using the VPS variable. This is a bit of work for one stat...

#URLs for 2011 PUMS files
us2011 <- "http://www2.census.gov/acs2011_1yr/pums/csv_pus.zip"
pr2011 <- "http://www2.census.gov/acs2011_1yr/pums/csv_ppr.zip"

## 2011 US/National - Download Person file
download.file(url = us2011, destfile = temp)

# unzip and read 2011 US files a & b
usa <- read.csv(unzip(zipfile = temp, files = "ss11pusa.csv",  exdir = "./Raw_Data"))
usb <- read.csv(unzip(zipfile = temp, files = "ss11pusb.csv",  exdir = "./Raw_Data"))

## 2011 Puerto Rico - Download Person file
download.file(url = pr2011, destfile = temp)

#unzip and read 2011 ppr file
ppr <- read.csv(unzip(zipfile = temp, files = "ss11ppr.csv",  exdir = "./Raw_Data"))

## Consolidate, create survey object, subset for Vietnam Veterans and save svy object as a Rds file.

#consolidate files
pums <- rbind(usa, usb, ppr)

#Alternate PUMS data read method 
# If you already have a PUMS csv file. You can put it in the Raw_Data folder you can uncomment and add the file name in line the line below
# pums <- read.csv(file = "Raw_Data/ADD NAME OF YOUR PUMS CSV FILE HERE")

#Create survey object
pums <- svydesign(id = ~1,
                    weights = pums$PWGTP,
                    data = pums,
                    repweights = "pwgtp[0-9]+",
                    type = "JKn",
                    scale = 4/80,
                    rscales = rep(1,80),
                    combined.weights = TRUE
)

#subset for Vietnam War Veterans (MIL and VPS variables)
pums_viet <- subset(pums, MIL %in% c(2:3) & VPS %in% c(6:8))
#save svy obj as RDS file
saveRDS(pums_viet, "Data_per11_viet_design
        .Rds")
#Clear the workspace
rm(pums_viet, pums, usa, usb, ppr, us2011, pr2011)

# measure run time if you wish
# end_time <- Sys.time() 
