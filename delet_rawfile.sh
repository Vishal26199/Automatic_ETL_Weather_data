#! /bin/bash

#delet daily created raw data file after the etl_data script run:
today=today=$(date +%Y%m%d)
weather_report=raw_data_$today
rm $weather_report