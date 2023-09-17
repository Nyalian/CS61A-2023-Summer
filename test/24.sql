.open --new

create database locations;

use locations;

CREATE TABLE cities AS
 SELECT 'Berkeley' AS city,    38 AS latitude, 122 AS longitude UNION
 SELECT 'Cambridge'       ,    42            ,  71              UNION
 SELECT 'Minneapolis'     ,    45            ,  93;

select * from cities;

select city, latitude from cities;

select longitude as lon, latitude as lat from cities;

select city, longitude * 1000 as long_lon from cities;

#####
# Noodles Menu
#####

create database menu;

use menu;

create table menu as
    select 'Beef Brisket Noodle Soup' as item, 13.99 as price union
    select 'House Special Beef Rib', 18.99 union
    select 'Lamb Brisket Rice Bowl', 13.99 union
    select 'Chef Special Hand Pulled Lamb Shank', 20.99 union
    select 'Lamb Noodle Soup', 14.99;

select * from menu;

# first motivation: if

select * from menu where price < 15;

select item from menu where price < 15;

select * from menu where price > 14 and price < 20;

select item from menu where price > 14 and price < 20;

# second motivation: sorting

select * from menu order by price desc;

select * from menu order by price asc;

# asc is the default behavior

select * from menu order by item asc, price asc;

select * from menu order by price asc, item asc;

select * from menu order by price asc, item desc;

# third motivation: smaller output

select * from menu;

select * from menu order by price desc limit 1;

select * from menu limit 3;

select * from menu order by price desc limit 3;

# to anto: open WCA database

# joining small example:

select * from menu as a, menu as b

######
# WCA
######
use wca_public_results_dump;

# motivation 3: limiting output

select * from Results;

select * from results limit 10;

select * from results;

# connecting it together

select * from results
         where competitionId = 'BayAreaSpeedcubin412023' limit 10;

select * from results
         where competitionId = 'BayAreaSpeedcubin412023'
           and eventId = '333oh'
         order by pos limit 10;

select * from roundtypes;

select * from results
         where competitionId = 'BayAreaSpeedcubin412023'
           and eventId = '333oh'
           and roundTypeId='f'
         order by pos limit 10;

select * from results where personId='2017TUNG13' order by pos;

select * from results where personId='2017TUNG13' and pos <= 5 order by pos;

# joining

select * from Competitions where id='BayAreaSpeedcubin412023';

select competitionId, name, cityName from Results, Competitions
                                     where id = competitionId
                                       and competitionId = 'BayAreaSpeedcubin412023'
                                     limit 1;

# joining example:

select * from championships;
select * from competitions;
select Competitions.id, competition_id from competitions, championships limit 10;
select * from competitions, championships where competitions.id = competition_id limit 10;

# ambiguous names

select id from championships, competitions;
select id from championships;
select id from competitions;

select championships.id, competitions.id from championships, competitions;

# joining a table with itself

# look at the noodles table first for a visual on how a join looks

select * from results;

select * from results, results;

select * from results as a, results as b;

# let's create a join where i see all the times that my friend beats me

select * from results as a, results as b where a.personid='2017TUNG13' and b.personid='2015LEAN01';

select * from results as a, results as b
         where a.personid='2017TUNG13'
           and b.personid='2015LEAN01'
           and a.competitionId = b.competitionId;

select * from results as a, results as b
         where a.personid='2017TUNG13'
           and b.personid='2015LEAN01'
           and a.competitionId = b.competitionId
           and a.eventId = b.eventId
           and a.roundTypeId = b.roundTypeId;

select a.competitionId, a.eventId, a.personName, a.average, a.pos, b.personName, b.average, b.pos from results as a, results as b
         where a.personid='2017TUNG13'
           and b.personid='2015LEAN01'
           and a.competitionId = b.competitionId
           and a.eventId = b.eventId
           and a.roundTypeId = b.roundTypeId;

select a.competitionId, a.eventId, a.personName, a.average, a.pos, b.personName, b.average, b.pos from results as a, results as b
         where a.personid='2017TUNG13'
           and b.personid='2015LEAN01'
           and a.competitionId = b.competitionId
           and a.eventId = b.eventId
           and a.roundTypeId = b.roundTypeId
           and a.average > 0
           and b.average > 0;

select a.competitionId, a.eventId, a.personName, a.average, a.pos, b.personName, b.average, b.pos from results as a, results as b
         where a.personid='2017TUNG13'
           and b.personid='2015LEAN01'
           and a.competitionId = b.competitionId
           and a.eventId = b.eventId
           and a.roundTypeId = b.roundTypeId
           and a.average > 0 and b.average > 0
           and b.average < a.average order by b.average;

# other queries

select a.competitionId, a.eventId, a.personName, a.average, a.pos, b.personName, b.average, b.pos from results as a, results as b
         where a.personid='2017TUNG13'
           and b.personid='2022YINB01'
           and a.competitionId = b.competitionId
           and a.eventId = b.eventId
           and a.roundTypeId = b.roundTypeId
           and a.average > 0 and b.average > 0
           and b.average < a.average order by b.average;