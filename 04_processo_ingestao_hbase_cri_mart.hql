

SET hive.hbase.generatehfiles=true;
SET hfile.family.path=/poc/cri/hfile/cf;
INSERT OVERWRITE TABLE POC_WRK.HB_CRIBASECADASTRO 
SELECT
     nu_cod_cetip                 
    ,ds_fonte_dado                
    ,nu_cnpj_emissor              
    ,nu_cnpj_fiduciario           
    ,nu_emissao                   
    ,nu_serie                     
    ,qt_emitidas                  
    ,vl_total_emissao             
    ,dt_emissao                   
    ,dt_vencimento                
FROM POC.CRIBASECADASTRO
CLUSTER BY nu_cod_cetip
;
