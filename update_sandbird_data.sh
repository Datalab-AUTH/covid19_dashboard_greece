#!/bin/bash

URL="https://raw.githubusercontent.com/Sandbird/covid19-Greece/master/cases.csv"
wget $URL \
		-O data/sandbird/cases_new.csv &&
	mv data/sandbird/cases_new.csv data/sandbird/cases.csv
rm -f data/sandbird/cases_new.csv

URL="https://raw.githubusercontent.com/Sandbird/covid19-Greece/master/prefectures.csv"
wget $URL \
		-O data/sandbird/prefectures_new.csv &&
	mv data/sandbird/prefectures_new.csv data/sandbird/prefectures.csv
rm -f data/sandbird/prefectures_new.csv
