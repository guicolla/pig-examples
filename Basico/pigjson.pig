entrada = LOAD '/user/admin/u.data' AS (userId: int, movieId: int, rating: int, timeRating: int);
saida = STORE entrada INTO 'first_table.json' USING JsonStorage();
