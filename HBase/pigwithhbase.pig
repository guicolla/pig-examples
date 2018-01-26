/*script para ler um arquivo do hdfs e gravar no hbase*/
file = LOAD '/user/admin/u.user' USING PigStorage('|') 
AS (userID:int, age:int, gender:chararray, occupation:chararray, zip:int);

STORE file INTO 'hbase://users' USING org.apache.pig.backend.hadoop.hbase.HBaseStorage
('usersinfo:age,usersinfo:gender,usersinfo:occupation,usersinfo:zip');
