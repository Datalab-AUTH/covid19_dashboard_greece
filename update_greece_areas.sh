#!/bin/bash

DATA="https://raw.githubusercontent.com/Datalab-AUTH/covid19_measures_map_greece/master/data.json"

wget $DATA -O data/greece_map/data-new.js &&
	sed -i "s/^const data_namekey = //g" data/greece_map/data-new.js &&
	mv data/greece_map/data-new.js data/greece_map/data.json
rm -f data/greece_map/data-new.js

