#!/bin/bash

#Create datstamped filename for the raw wttr data:
today=$(date +%Y%m%d)
weather_report=raw_data_$today

#download today's weather data from wttr.in:
city=markham
curl wttr.in/$city > $weather_report

#store current year,month,day and hour data:
hour=$(TZ='Ontario/Markham' date -u +%H)
day=$(TZ='Ontario/Markham' date -u +%d)
month=$(TZ='Ontario/Markham' date +%m)
year=$(TZ='Ontario/Markham' date +%Y)

#create tempratures.txt from raw data to store all tempratures:
grep °C $weather_report > tempratures.txt

#store obs_temp and fc_temp from today's raw data:
obs_temp=$(head -n 1 tempratures.txt | xargs | tr -s " " | rev | cut -d " " -f2 | rev)
fc_temp=$(head -n 2 tempratures.txt | tail -n 1 | xargs | tr -s " " | cut -d "C" -f2 | rev | cut -d " " -f2 | rev)

# add all values to table in etl_data.log:
values="$year\t$month\t$day\t$hour\t$obs_temp\t$fc_temp"
echo -e $values >> etl_data.log