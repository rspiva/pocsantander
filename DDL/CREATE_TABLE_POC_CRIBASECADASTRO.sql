DROP TABLE IF EXISTS POC.CRIBASECADASTRO;
CREATE TABLE POC.CRIBASECADASTRO (
  nu_cod_cetip                  STRING,
  ds_fonte_dado                 STRING,
  nu_cnpj_emissor               STRING,
  nu_cnpj_fiduciario            STRING,
  nu_emissao                    BIGINT,         
  nu_serie                      BIGINT,
  qt_emitidas                   BIGINT,
  vl_total_emissao              DECIMAL(15,2),
  dt_emissao                    DATE,
  dt_vencimento                 DATE 
) 
PARTITIONED BY (DATEREF INT)
STORED AS ORC
TBLPROPERTIES("orc.compress"="ZLIB")
;
