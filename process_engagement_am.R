#!/usr/bin/Rscript
# Engagement
# ENG-571, 730

home_dir <- "/home/push"

platform <- "apple_music" # ENG-730
# platform <- "spotify" # ENG-571

# setwd("~/engagement_scripts")

library(bigrquery, quietly = TRUE, verbose = FALSE, warn.conflicts = FALSE)
library(plyr)
library(dplyr, quietly = TRUE, verbose = FALSE, warn.conflicts = FALSE)
# library(FFNutilities, quietly = TRUE, verbose = FALSE, warn.conflicts = FALSE)
# library(tidyr, quietly = TRUE, verbose = FALSE, warn.conflicts = FALSE)
# library(plyr, quietly = TRUE, verbose = FALSE, warn.conflicts = FALSE)
library(lubridate, quietly = TRUE, verbose = FALSE, warn.conflicts = FALSE)

if (platform == "apple_music") {
  # setwd("~/ENG_730")
  load(paste(home_dir, "/data/analytic_dataset_am_Past30d.RData", sep=""))
  
  d <- dplyr::tbl_df(analytic_dataset_am_Past30d)
  renames <- c("anonymized_person_id" = "listener_id")
}

if (platform == "spotify") {
  # setwd("~/ENG_571")
  load(paste(home_dir, "/data/analytic_dataset_spot_Past30d.RData", sep=""))

  d <- dplyr::tbl_df(analytic_dataset_spot_Past30d)
  renames <- c("streams_user_id" = "listener_id", "streams_timestamp" = "timestamp") # for spot
}

d1 <- plyr::rename(d, renames)
d2 <- d1[complete.cases(d1),]

source(paste(home_dir, "/engagement_scripts/engagement.R", sep=""))

 
this_data <- d2
a <- unique(this_data$artist_id)
res <- vector(mode="list", length=length(a))
for (i in 1:length(a)) {
#  i <- 1
  artist1 <- subset(this_data, artist_id == a[i])
  res[[i]] <- engagement(artist1)
  res[[i]] <- c("artist_id" = a[i], res[[i]])
}
res.df <- do.call("rbind.data.frame", res)
res.df$platform <- platform
res.df$analytics_timestamp <- Sys.time()
res.df <- res.df[order(res.df$trend28days, decreasing = TRUE),]

# rankings
res.df$mau_percentile <- rank(res.df$mau)/nrow(res.df)

# 1 - ranking the improving engagement by trend28days (absolute)
tmp <- (rank(res.df$trend28days))/nrow(res.df)
res.df$engagement_change_percentile1 <- ifelse(is.na(res.df$trend28days),0,tmp)
rm(tmp)

# 2 - ranking the improving engagement by trend28days_adj (relative to their size)
tmp <- (rank(res.df$trend28days_adj))/nrow(res.df)
res.df$engagement_change_percentile2 <- ifelse(is.na(res.df$trend28days_adj),0,tmp)
rm(tmp)

if (platform == "spotify")
  save(res.df, file = paste(home_dir, "/data/out_spotify.RData", sep=""))

if (platform == "apple_music")
  save(res.df, file = paste(home_dir, "/data/out_am.RData", sep=""))

# 
# 
# ggplot(data = agg2, mapping = aes(x = doyN, y = streams)) + 
#   geom_point() + 
#   geom_smooth()
# 
# ggplot(data = x, aes(x = isrc_num, y = proportion)) + 
#   geom_point() + 
#   geom_smooth()
# 
