#!/bin/bash

CASES_URL="https://raw.githubusercontent.com/Sandbird/covid19-Greece/master/cases.csv"
wget $CASES_URL \
		-O data/sandbird/cases_new.csv &&
	mv data/sandbird/cases_new.csv data/sandbird/cases.csv
rm -f data/sandbird/cases_new.csv
