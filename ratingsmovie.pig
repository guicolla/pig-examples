/*Lendo o arquivo u.data dentro do HDFS e armazenando dentro da variavel ratings
(userID,movieID,rating,ratingTime)
(userID,movieID,rating,ratingTime)
*/
ratings = LOAD '/user/admin/u.data' as (userID: int, movieID: int, rating: int, ratingTime
: int);
/*Lendo o arquivo u.item, porem especifincaod o delimitador em que os campos serao separados*/
metadata = LOAD '/user/admin/u.item' using PigStorage ('|') as (movieID: int, movieTitle: chararray,
releaseDate: chararray, videoRelease: chararray, imdbLink: chararray);
/*mostra na tela*/
/*dump metadata;*/
/*gerando uma nova linha com formato diferente, a data fiocara com formato 01-Jan-1995*/
/*ToUnixTime data em tempo do Unix*/
nameLookup = FOREACH metadata GENERATE movieID, movieTitle, ToUnixTime(ToDate(releaseDate,'dd-MMM-YYYY'))
as releaseTime;
/*agrupando o ratings(variavel) por movieID*/
ratingsByMovie = GROUP ratings BY movieID;
/*dump ratingsByMovie*/
avgRatings = FOREACH ratingsByMovie GENERATE group as movieID, AVG(ratings.rating) AS avgRating;
/*dump avgRatings;*/
/*descricao das variaveis*/
/*describe ratings;
describe ratingsByMovie;
describe avgRatings;*/
fiveStarMovies = FILTER avgRatings BY avgRating >= 5.0;
/*dump fiveStarMovies;*/
fiveStartsWithData = JOIN fiveStarMovies by movieID, nameLookup by movieID;
/*describe fiveStartsWithData;
dump fiveStartsWithData;*/
fiveStarsFormat = FOREACH fiveStartsWithData GENERATE fiveStarMovies::movieID, fiveStarMovies::avgRating, nameLookup::movieTitle;
/*dump newvar;*/
oldestFiveStarsFormat = ORDER fiveStarsFormat BY nameLookup::movieTitle;
/*dump oldestFiveStarsFormat;*/
STORE oldestFiveStarsFormat INTO 'outRatings' USING PigStorage(';');