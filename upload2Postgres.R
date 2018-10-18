#!/usr/bin/Rscript
# Load Engagement Analytic Data to Postgres
# ENG-571, 730


# Tables to Create/Refresh
am_table   <- "am_engagement_analytic"
spot_table <- "spot_engagement_analytic"


setwd('/home/push/data')
library(RPostgreSQL, quietly=TRUE, verbose = FALSE, warn.conflicts = FALSE)
con <- dbConnect(dbDriver("PostgreSQL"), dbname = "insights",
                 host = "insights02-cluster.cluster-cvfqek32sm3s.us-west-2.rds.amazonaws.com", port = 5432,
                 user = "root", password = "bates-lory-cracker")


load("/home/push/data/analytic_dataset_am_Past30d.RData")
am_data <- as.data.frame(d)
RPostgreSQL::dbWriteTable(con, am_table, am_data, overwrite=TRUE, row.names=FALSE, append=FALSE)

load("/home/push/data/analytic_dataset_spot_Past30d.RData")
spot_data <- as.data.frame(d)
RPostgreSQL::dbWriteTable(con, spot_table, spot_data, overwrite=TRUE, row.names=FALSE, append=FALSE)
