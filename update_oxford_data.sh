#!/bin/bash


wget https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv \
		-O data/data_oxford_new.csv && \
	grep "^CountryName,\|,GRC," data/data_oxford_new.csv > data/data_oxford.csv
rm -f data/data_oxford_new.csv
