-- Running the file from IMDb_cleaning

USE IMDb_cleaning;

-- Opening the dataset 
SELECT * 
FROM Movies;


-- Cleaning the IMBD title ID COLUMN
exec sp_rename 'movies.[IMBD title ID]', 'IMBD_title_ID', 'COLUMN'


-- Deleting the empty row in all the rows
DELETE Movies
WHERE Genre = '' or Genre is null 


-- Deleting the NoName column 
alter table movies 
drop column noname 


-- cleaning the release year 
EXEC sp_rename 'movies.[Release year]', 'Release_year', 'COLUMN' 


-- changing the formate of the release date to YYYY-MMMM-DDDD
SELECT *
FROM Movies
WHERE Release_year LIKE '%e%';

UPDATE MOVIES 
Set Release_year = REPLACE(REPLACE(REPLACE(Release_year,'/','-'),' ', '-'),'--','-')

update movies 
set Release_year = case 
					when Release_year like '12' then '2004-12-23'
					when Release_year like '23rd-December-of-1966' then '1966-12-23'
					when Release_year like 'The-6th-of-marzo,-year-1951' then '1951-03-06'
					Else Release_year
					End; 

update movies
set Release_year = case	
					when Release_year like '23-07-2008' then '2008-07-23'
					when Release_year like '18-11-1976' then '1976-11-18'
					when Release_year like '1976-13-24' then '1976-12-24'
					when Release_year like '1976-13-24' then '1976-12-24'
					Else Release_year
					END;

update movies
set Release_year = TRY_CAST(Release_year as date)


-- Cleaning the duration column by removin all characters contain and puting the duration in number
UPDATE MOVIES 
SET Duration = CASE 
				WHEN IMBD_title_ID = 'tt0110912' then 165
				WHEN IMBD_title_ID = 'tt0108052' then 195
				WHEN IMBD_title_ID = 'tt0137523' then 139
				WHEN IMBD_title_ID = 'tt0120737' then 178
				WHEN IMBD_title_ID = 'tt0133093' then 136
				WHEN IMBD_title_ID = 'tt0080684' then 124
				WHEN IMBD_title_ID = 'tt0073486' then 133
				else Duration
				end;

-- changing the data type from nvarchar to int
alter table movies
alter column duration int


-- cleaning the country column by using a uniform country like US. to USA and US to USA
-- West German is German, New Zesland and New Zeland as New Zealand and Italy1 as Italy
SELECT * FROM Movies
WHERE Country LIKE '%Y%';

update Movies
set country = case	
					WHEN country like '%West Germany%' then 'Germany' 
					WHEN country like '%New Zesland%'or country like '%New Zeland%' then 'New Zealand'
					WHEN country like '%Italy1%' then 'Italy' 
					WHEN country like '%US.%' or country like 'US%' then 'USA' 
					ELSE COUNTRY
					END;


-- cleaning the content rating 
-- there five types of movies rating which are PG, R, G, PG-13, NC-17.
EXEC sp_rename 'movies.[content rating]', 'Content_rating', 'COLUMN'

SELECT * FROM Movies
WHERE Content_rating = '#N/A' 
or Content_rating = 'not rated'
or Content_rating = 'approved';

update Movies
SET Content_rating = CASE 
							WHEN Content_rating LIKE '%#N/A%' THEN 'Unrated'
							WHEN Content_rating LIKE '%Approved%' THEN 'Rated'
							WHEN Content_rating LIKE '%Not Rated%' THEN 'Unrated'
							ELSE Content_rating
							END;


-- Cleaning the income column by removing the 
update movies 
set income = LTRIM(LTRIM(replace(replace(REPLACE(income,'$',''),'o','0'),',','')));

-- changing the data type from nvarchar to numeric 
alter table movies
alter column income numeric 

-- Some number contains o instead of 0 
-- cleaning the o to 0 
-- The vote are in hundrends of thousand. 
-- Removing the . and replacing it with 
update movies 
set votes = replace(replace(Votes,'.',''),'o','0')

-- changing the data type from nvarchar to in 
ALTER TABLE MOVIES
ALTER COLUMN votes int


-- this column contains alots of inconsistencies and need cleaning 
update movies 
set Score = replace(replace(replace(replace(replace(replace(replace(replace
				(replace(replace(score,'..','.'),'.:','.'),',:','.'),':','.'),',','.'),
				'8.9f','8.9'),'++8.7','8.7'),'8.7e-0','8.7'),'..','.'),'8.7.','8.7')

-- changing the data type from nvarchar to decimal
alter table movies 
alter column score decimal(2,1)


SELECT  *
FROM Movies;
order by 
