#!/usr/bin/Rscript

# this script loads all necessary R libraries and launches th Shiny
# server

library("renv")
renv::restore()
shiny::runApp(host = "0.0.0.0", port = 5557, launch.browser = FALSE)
