file = LOAD '/user/admin/u.user' USING PigStorage('|') 
AS (userID:int, age:int, gender:chararray, occupation:chararray, zip:int);

STORE file INTO 'hbase://user' USING org.apache.pig.backend.hadoop.hbase.HBaseStorage
('userinfo:age,userinfo:gender,userinfo:occupation,userinfo:zip');
