#!/bin/bash
## 
# WWLLN Lightning Processor
# Copyright 2017 Christopher Zenzel
##

##
# Get to the Data Directory
##
cd input

##
# Remove all input data
##
rm lightning_src.kml lightning_src.kmz red.png square.png

##
# Download the Latest Lightning Data from Google Earth
##
curl -O "http://flash3.ess.washington.edu/lightning_src.kmz"

##
# Extract the KMZ file for lightning data
##
unzip "lightning_src.kmz"

##
# Exit the data directory
##
cd ..

##
# Run the Processor
##
export TIMESTAMP=`date -u +%Y%m%d%H%M%S`
export OUTPUT_DIR="output"

node processor-json.js > "${OUTPUT_DIR}/${TIMESTAMP}_wwlln.json"
node processor-csv.js > "${OUTPUT_DIR}/${TIMESTAMP}_wwlln.csv"

##
# Copy latest file
##
cp "${OUTPUT_DIR}/${TIMESTAMP}_wwlln.json" "${OUTPUT_DIR}/latest.json"
cp "${OUTPUT_DIR}/${TIMESTAMP}_wwlln.csv" "${OUTPUT_DIR}/latest.csv"

##
# Generate Map
##
R --no-save < processor-map.r

##
# Completed
##