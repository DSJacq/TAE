#### PREDICTING THE BASEBALL WORLD SERIES CHAMPION (OPTIONAL)

Last week, in the Moneyball lecture, we discussed how regular season performance is not strongly correlated with winning the World Series in baseball. In this homework question, we'll use the same data to investigate how well we can predict the World Series winner at the beginning of the playoffs.

To begin, load the dataset baseball.csv into R using the read.csv function, and call the data frame "baseball". This is the same data file we used during the Moneyball lecture, and the data comes from Baseball-Reference.com.

As a reminder, this dataset contains data concerning a baseball team's performance in a given year. It has the following variables:

- **Team**: A code for the name of the team
- **League**: The Major League Baseball league the team belongs to, either AL (American League) or NL (National League)
- **Year**: The year of the corresponding record
- **RS**: The number of runs scored by the team in that year
- **RA**: The number of runs allowed by the team in that year
- **W**: The number of regular season wins by the team in that year
- **OBP**: The on-base percentage of the team in that year
- **SLG**: The slugging percentage of the team in that year
- **BA**: The batting average of the team in that year
- **Playoffs**: Whether the team made the playoffs in that year (1 for yes, 0 for no)
- **RankSeason**: Among the playoff teams in that year, the ranking of their regular season records (1 is best)
- **RankPlayoffs**: Among the playoff teams in that year, how well they fared in the playoffs. The team winning the World Series gets a RankPlayoffs of 1.
- **G**: The number of games a team played in that year
- **OOBP**: The team's opponents' on-base percentage in that year
- **OSLG**: The team's opponents' slugging percentage in that year
