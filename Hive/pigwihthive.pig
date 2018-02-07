var = load '/user/root/u.data' as (userid: int, movieid: int, rating: int, data: int);
store var into 'data_teste' using org.apache.hive.hcatalog.pig.HCatStorer();
