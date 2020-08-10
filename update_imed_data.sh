#!/bin/bash


wget https://raw.githubusercontent.com/iMEdD-Lab/open-data/master/COVID-19/regions_greece_cases.csv \
		-O data/data_imed_cases_new.csv && \
		mv data/data_imed_cases_new.csv data/data_imed_cases.csv
wget https://raw.githubusercontent.com/iMEdD-Lab/open-data/master/COVID-19/regions_greece_deaths.csv \
		-O data/data_imed_deaths_new.csv && \
		mv data/data_imed_deaths_new.csv data/data_imed_deaths.csv
rm -f data/data_imeda_deaths.csv
