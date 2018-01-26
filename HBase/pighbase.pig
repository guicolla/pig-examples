/*script para ler os dados do hbase e mostrar na tela*/
file = LOAD 'hbase://user' USING org.apache.pig.backend.hadoop.hbase.HBaseStorage
('userinfo:age,userinfo:gender,userinfo:occupation,userinfo:zip') as (age: chararray, gender: chararray,
occupation: chararray, zip: int);

dump file;
