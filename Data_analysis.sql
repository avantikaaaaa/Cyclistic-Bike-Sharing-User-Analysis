#checking for mean of ride length
select member_casual, round(avg(ride_length),2) from `bike_share.data2020_21_new2` group by member_casual order by 2 desc;

#checking for mode of day of week
select day_of_week, count(*) from `bike_share.data2020_21_new2` group by day_of_week order by 2 desc;

#checking for ride type distribution
select member_casual, rideable_type, count(ride_id) from `bike_share.data2020_21_new2` group by 1,2 order by 1,2 desc; 

#checkng for in which month the maximum number of rides happened
select month, count(*) from `bike_share.data2020_21_new2` group by 1 order by 2 desc 
limit 1;

#checking for distinct start station location
select distinct start_station_name from `bike_share.data2020_21_new2`;

#checking for distinct end station location
select distinct end_station_name from `bike_share.data2020_21_new2`;