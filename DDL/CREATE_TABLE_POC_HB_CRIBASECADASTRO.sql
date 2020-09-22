
--CODIGO HBASE
--create 'poc:cadastrocri', { NAME => 'cf', COMPRESSION => 'SNAPPY', VERSIONS => '3', REPLICATION_SCOPE => '0'}

DROP TABLE IF EXISTS POC_WRK.HB_CRIBASECADASTRO;
CREATE EXTERNAL TABLE POC_WRK.HB_CRIBASECADASTRO(
     nu_cod_cetip                 STRING
    ,ds_fonte_dado                STRING
    ,nu_cnpj_emissor              STRING
    ,nu_cnpj_fiduciario           STRING
    ,nu_emissao                   STRING
    ,nu_serie                     STRING
    ,qt_emitidas                  STRING
    ,vl_total_emissao             STRING
    ,dt_emissao                   STRING
    ,dt_vencimento                STRING
   )
ROW FORMAT SERDE 'org.apache.hadoop.hive.hbase.HBaseSerDe' 
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler' 
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,cf:dsf,cf:nce,cf:ncf,cf:ne,cf:ns,cf:qe,cf:vte,cf:dte,cf:dtv") 
TBLPROPERTIES ("hbase.table.name" = "poc:cadastrocri","orc.compress"="snappy")
;