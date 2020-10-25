#!/bin/bash

DATA="https://covid19.gov.gr/wp-content/covid-measures/data.js"

wget $DATA -O data/greece_map/data-new.js &&
	sed -i "s/^const data_namekey = //g" data/greece_map/data-new.js &&
	mv data/greece_map/data-new.js data/greece_map/data.json
rm -f data/greece_map/data-new.js

