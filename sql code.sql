

--create database

create database ipl
go

--load the data into database 
--Rename table ipl_ball  as deliviries
select * from deliviries
--Rename table IPL_matches as matches
select * from matches

/*Select the top 20 rows of the deliveries table after ordering them by id, inning, over, ball in ascending order.*/

select top(20) * from deliviries
order by id asc,inning asc , nover asc, ball 

--Select the top 20 rows of the matches table.

select top(20) * from matches

--Fetch data of all the matches played on 2nd May 2013 from the matches table..

select * from matches
where date = '2/5/2013'
-- Fetch data of all the matches where the result mode is ‘runs’ and margin of victory is more than 100 runs.

select * from matches
where result = 'runs' and result_margin>100


-- Fetch data of all the matches where the final scores of both teams tied and order it in descending order of the date.
select * from matches
where result = 'tie'
order by date desc

--  Get the count of cities that have hosted an IPL match.

select count( distinct city) as number_of_cities from matches 

--
select * from deliviries

SELECT *,
       CASE
           WHEN total_runs >= 4 THEN 'boundary'
           WHEN total_runs = 0 THEN 'dot'
           ELSE 'other'
       END AS ball_result
 into new FROM deliviries;

 select * from new

 -- Write a query to fetch the total number of boundaries and dot balls from the deliveries_v02 table.

 select count(*)  from new
 where ball_result='boundary' or  ball_result='dot'

 /* Write a query to fetch the total number of boundaries scored by each team from the deliveries_v02 table 
 and order it in descending order of the number of boundaries scored.*/
 select batting_team,bowling_team,count(*)  from new
 where ball_result='boundary'
 group by batting_team,bowling_team
 order by count(*) desc
 /* Write a query to fetch the total number of dot balls bowled by each team and 
 order it in descending order of the total number of dot balls bowled.*/
 select batting_team,bowling_team,count(*)  from new
 where ball_result='dot'
 group by batting_team,bowling_team
 order by count(*) desc

-- Write a query to fetch the total number of dismissals by dismissal kinds where dismissal kind is not NA

 select count(*) from deliviries
 where dismissal_kind <> 'NA'

 -- Write a query to get the top 5 bowlers who conceded maximum extra runs from the deliveries table

 select top 5 bowler,sum(extra_runs) from deliviries
 --where bowler='SL Malinga'
 group by bowler
 order by sum(extra_runs) desc
/* --output
 SL Malinga	293
P Kumar	236
UT Yadav	226
DJ Bravo	210
B Kumar	201*/

/* Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table 
and two additional column (named venue and match_date)
--of venue and date from table matches
*/
 
CREATE TABLE deliveries_v03 AS
SELECT dv2.*, m.venue, m.match_date
FROM deliveries_v02 as dv2
JOIN matches m ON dv2.match_id = m.match_id;


/* Write a query to fetch the total runs scored for each venue 
--and order it in the descending order of total runs scored.
select distinct venue from deliviries_02*/

select venue,sum(total_runs) as total_runs from deliviries_02 --252794
group by venue
order by sum(total_runs) desc

/* Write a query to fetch the year-wise total runs scored at Eden Gardens and 
order it in the descending order of total runs scored.*/

/* first convert string to date format by using the parse
UPDATE deliviries_02
SET match_date = parse (match_date as date USING 'es-ES')*/

select venue,year(match_date),sum(total_runs) as venue_wise_total_runs  from deliviries_02
where venue = 'eden gardens'
group by venue,year(match_date)
order by sum(total_runs) desc


--Get unique team1 names from the matches table,
/*you will notice that there are two entries 
for Rising Pune Supergiant one with Rising Pune Supergiant and
another one with Rising Pune Supergiants.  Your task is to create a matches_corrected table 
with two additional columns team1_corr and team2_corr containing team names with 
replacing Rising Pune Supergiants with Rising Pune Supergiant. 
Now analyse these newly created columns.*/
--syntex
select *,case when team1= 'Rising Pune Supergiants' THEN 'Rising Pune Supergiant' else team1 end as team1_corr
,case when team2 ='Rising Pune Supergiants' THEN 'Rising Pune Supergiant' else team2 end as team2_corr into new_match_recordss  from matches
where team1='Rising Pune Supergiants' or team2='Rising Pune Supergiants'