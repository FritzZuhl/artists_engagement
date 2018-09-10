#!/usr/bin/Rscript
# Eng-571, get spotify analytics data
# written Aug 30
library(bigrquery, warn.conflicts = FALSE, quietly = TRUE)

set_service_token("/opt/etc/google_creds.json")

home_dir <- "/home/push"
# home_dir <- "/home/fritz_zuhl"

load(paste(home_dir, "/data/out_am.RData", sep=""))
res.df_am <- res.df
load(paste(home_dir, "/data/out_spotify.RData", sep=""))

res.df_spotify <- res.df
rm(res.df)

res.df <- rbind(res.df_am, res.df_spotify)

target_file <- "tommy-boy.FritzZuhl.engagement"

if (bq_table_exists(target_file)) {
  bq_table_delete(target_file)
}
bq_table_upload(target_file, res.df, quiet=TRUE)

