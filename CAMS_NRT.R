

library("httr")
library(RCurl)
library(stringr)
library(plyr)
library(curl)

setwd("C:/CAMS_NRT")
url = "ftp://federico.karagulian:GI0cdFUW@dissemination.ecmwf.int/DATA/CAMS_NREALTIME/2016102300/"

filenames = getURL(url, ftp.use.epsv = FALSE, ftplistonly = TRUE, crlf = TRUE, ssl.verifypeer = FALSE) 
# filenames = getURL(url, ftp.use.epsv = FALSE, ftplistonly = TRUE, crlf = TRUE) 
filenames = paste(url, strsplit(filenames, "\r*\n")[[1]], sep = "") 
filenames_nc <- unlist(str_extract_all(filenames, ".+(.nc$)"))
filenames_pm25 <- unlist(str_extract_all(filenames, ".+(_pm2p5.nc$)"))


# start downloading data in the main directory
mapply(download.file, filenames_pm25,basename(filenames_pm25), method = 'curl') 
# mapply(download.file, filenames_pm25,basename(filenames_pm25)) 