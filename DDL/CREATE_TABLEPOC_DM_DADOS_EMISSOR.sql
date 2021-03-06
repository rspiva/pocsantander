DROP TABLE IF EXISTS POC_DM.DADOSEMISSOR;
CREATE TABLE POC_DM.DADOSEMISSOR (
    NU_COD_CETIP     STRING,
    nu_cnpj          BIGINT,
    nm_fantasia      STRING,
    QT_EMITIDAS      BIGINT,
    VL_TOTAL_EMISSAO DECIMAL(15,2)
)STORED AS ORC
TBLPROPERTIES("orc.compress"="ZLIB")
;
