DROP TABLE IF EXISTS POC.PESSOAJURIDICA;
CREATE TABLE POC.PESSOAJURIDICA (
  nu_cnpj     STRING,
  nm_fantasia STRING,
  nm_razao_social STRING
) 
PARTITIONED BY (DATEREF INT)
STORED AS ORC
TBLPROPERTIES("orc.compress"="ZLIB")
;
