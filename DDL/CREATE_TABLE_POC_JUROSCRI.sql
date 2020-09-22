DROP TABLE IF EXISTS POC.JUROSCRI;
CREATE TABLE POC.JUROSCRI (
  nu_cod_cetip                  STRING,
  vl_juros               DECIMAL(12,2),
  dt_lancamento                DATE
) 
STORED AS ORC
TBLPROPERTIES("orc.compress"="ZLIB")
;
