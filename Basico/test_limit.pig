/*Script para testar a funço LIMIT do pig*/
ratings = LOAD '/user/admin/u.data' as (userID: int, movieID: int, rating: int, ratingTime
: int);
ratings_limit = LIMIT ratings 5;
dump ratings_limit;
describe ratings;
ratings_new = LOAD '/user/admin/u.data' using TextLoader();
rat_limit = LIMIT ratings_new 5;
dump rat_limit;
describe ratings_new;
