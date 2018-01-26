/*Script que utiliza o phoenix para carregar os dados em uma tabela do hbase, apos carregar os dados esses dados sao
lidos novamente e é realizado alguns filtros para mostrar quantos projetos deram failed e quantos deram successful*/
REGISTER /usr/hdp/current/phoenix-client/phoenix-client.jar

dados = LOAD '/user/admin/projects2.csv' USING PigStorage(',') as (id: int, name: chararray,
category: chararray, main_category: chararray, currency: chararray, deadline: chararray, goal: int,
launched: chararray, pledged: int, state: chararray, backers: int, country: chararray, usd_pledged: int);

STORE dados INTO 'hbase://project' USING org.apache.phoenix.pig.PhoenixHBaseStorage('localhost','-batchSize 5000');

dados_project = LOAD 'hbase://table/project/ID,STATE' using org.apache.phoenix.pig.PhoenixHBaseLoader('localhost');

dados_filter = FILTER dados_project BY STATE in ('successful','failed');

dados_group = GROUP dados_filter BY STATE;

dados_count = FOREACH dados_group GENERATE $0, COUNT($1);

dump dados_count;
