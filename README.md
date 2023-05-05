
![](Homeimage.jpeg)
----
# Introduction

The Internet Movie Database (IMDb) is an online database containing information and statistics about movies, TV shows and video games as well as actors, directors and other film industry professionals. This information can include lists of cast and crew members, movie release dates and box office information, plot summaries, trailers, actor and director biographies and other trivia.

# About the dataset 
The dataset is a messy and contains 102 fields and 11 records. After the cleaning, 101 fields and 11 records were left. 

# Error in Dataset
- Symbols in field name 
- Inappropriate Data type 
- Inconsistency in the country name 
- 'O' in the income field 

# Clearing Process

- Original titl�: Contains symbol � changed to original title 

- Blank rows in the record and was deleted.

- I manually changed the release year since all are not in the same format which gave error when trying to do it automatically 

- Some duration of the movies where empty and the duration was searched for on google and manually replace it. 

- The country column is inconsistent like Italy1 in all column changed to italy and changing US., US, usa to USA, New Zeland, New Zesland to New Zealand 
and West German to Germany

- There are five types of movies rating which are PG, R, G, PG-13, NC-17. THE N/A was rated as unrated futher reading for better understanding on why the II brouno was rated approved and was done and was letter changed to rated because of it voilent content  

- Column 1 was removed because it contains blank all through

- The data type of released date was changed to date 

- The data type of duration was changed to number

- The income was inspected and discovered that the 0  was put as  o and was changed to 0 and data type currency 

- The votes has two periods (.) and was removed. The votes are in hundreds of thousands and data type number.

# Conclusion 
The cleaning was done using Excel power query and SQL. This was done to sharpen my skills in data cleaning using Excel and SQL. 

## Thank You 
