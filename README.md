# pocsantander

Tarefas de avaliação do Santander

PocSantander - Projeto em eclipse - Build com o Maven

shell script: 
01_importacao_pj_sqoop.sh
02_ingestao_detalhe_cri.sh
03_1_ingestao_formatada_detalhe.sh
03_2_ingestao_pessoa_juridica.sh
03_3_ingestão_juros.sh
04_1_processo_ingestao_hbase_cri_bulkload.sh
04_processo_dm_emissor_info.sh

HQL:
04_processo_ingestao_data_mart.hql
04_processo_ingestao_hbase_cri_mart.hql

dados:  diretório com fontes para teste

DDL: diretório com os DDLs do Hive

Opção para execução no spark-shell:
IngestaoDataLakeDesestruturadoJuros.scala
IngestaoDataLakeEstruturadoCRI.scala
IngestaoDataLakeEstruturadoPJ.scala

Apresentação:
SantanderPOC.pptx
