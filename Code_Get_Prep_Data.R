start_time <- Sys.time()
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
usabpr16 <- rbind(usa, usb, ppr)

usabpr16 <- svydesign(id = ~1,
                    weights = usabpr16$PWGTP,
                    data = usabpr16,
                    repweights = "pwgtp[0-9]+",
                    type = "JKn",
                    scale = 4/80,
                    rscales = rep(1,80),
                    combined.weights = TRUE
)

#subset for Vietnam War Veterans (MIL and VPS variables)
usabpr_viet <- subset(usabpr16, MIL %in% c(2:3) & VPS %in% c(6:8))
#save svy obj as RDS file
saveRDS(usabpr_viet, "Data_per16_viet_design-test.Rds")
#Clear the workspace
rm(usabpr_viet, usabpr16, usa, usb, ppr, us2016, pr2016)

end_time <- Sys.time()


# 2011 PUMS Files ---------------------------------------------------------
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
usabpr11 <- rbind(usa, usb, ppr)

#Create survey object
usabpr11 <- svydesign(id = ~1,
                    weights = usabpr11$PWGTP,
                    data = usabpr11,
                    repweights = "pwgtp[0-9]+",
                    type = "JKn",
                    scale = 4/80,
                    rscales = rep(1,80),
                    combined.weights = TRUE
)

#subset for Vietnam War Veterans (MIL and VPS variables)
usabpr_viet <- subset(usabpr11, MIL %in% c(2:3) & VPS %in% c(6:8))
#save svy obj as RDS file
saveRDS(usabpr_viet, "Data_per11_viet_design-test.Rds")
#Clear the workspace
rm(usabpr_viet, usabpr11, usa, usb, ppr, us2011, pr2011)


