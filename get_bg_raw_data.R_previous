#!/usr/bin/Rscript
# Eng-571, get spotify analytics data
# written Aug 30

#library(httpuv)
library(bigrquery, warn.conflicts = FALSE, quietly = TRUE)
# library(googleAuthR)
set_service_token("/opt/etc/google_creds.json")

# home_dir <- "/home/fritz_zuhl"
home_dir <- "/home/push"

setwd(paste(home_dir, "/engagement_scripts", sep=""))

# proj <- 'tommy-boy'
# ds_spot <- "spotify_analytics"
# ds_spot <- "FritzZuhl"

# spotify
analytic_dataset_spot_Past30d <- bq_table_download("tommy-boy.FritzZuhl.analytic_dataset_spot_Past30d")
analytic_dataset_spot_Past30d$upload_timestamp <- Sys.time()
save(analytic_dataset_spot_Past30d, file=paste(home_dir, "/data/analytic_dataset_spot_Past30d.RData", sep=""))

# apple music
analytic_dataset_am_Past30d  <- bq_table_download("tommy-boy.FritzZuhl.analytic_dataset_am_Past30d")
analytic_dataset_am_Past30d$upload_timestamp <- Sys.time()
save(analytic_dataset_am_Past30d, file=paste(home_dir, "/data/analytic_dataset_am_Past30d.RData", sep=""))
