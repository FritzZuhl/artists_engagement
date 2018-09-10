#!/usr/bin/Rscript
# Eng-571, get spotify analytics data
# written Aug 30


library(bigrquery, warn.conflicts = FALSE, quietly = TRUE)
library(lubridate, warn.conflicts = FALSE, quietly = TRUE)
# library(googleAuthR)
set_service_token("/opt/etc/google_creds.json")

# home_dir <- "/home/fritz_zuhl"
home_dir <- "/home/push"

setwd(paste(home_dir, "/artists_engagement", sep=""))

# proj <- 'tommy-boy'
# ds_spot <- "spotify_analytics"
# ds_spot <- "FritzZuhl"

# spotify
d <- bq_table_download("tommy-boy.FritzZuhl.analytic_dataset_spot_Past30d")
d$upload_timestamp <- Sys.time()
# dedup by listener_id and timestamp

# d$timestamp_rounded <- round_date(d$timestamp, unit="minute")
# tmp <- d[c("listener_id", "timestamp_rounded")]
# d2 <- d[!duplicated(tmp),]


save(d, file=paste(home_dir, "/data/analytic_dataset_spot_Past30d.RData", sep=""))

# apple music
d <- bq_table_download("tommy-boy.FritzZuhl.analytic_dataset_am_Past30d")
d$upload_timestamp <- Sys.time()

# d$timestamp_rounded <- round_date(d$timestamp, unit="minute")
# tmp <- d[c("listener_id", "timestamp_rounded")]
# d2 <- d[!duplicated(tmp),]


save(d, file=paste(home_dir, "/data/analytic_dataset_am_Past30d.RData", sep=""))
