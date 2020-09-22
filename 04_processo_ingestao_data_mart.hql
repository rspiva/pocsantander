--LEVANTAMENTO DO EMISSSOR

insert into POC_DM.DADOSEMISSOR
select 
CRI.NU_COD_CETIP,
CRI.NU_CNPJ,
PJ.NM_FANTASIA,
CRI.QT_EMITIDAS,
CRI.VL_TOTAL_EMISSAO
from (
    SELECT
        nu_cod_cetip      nu_cod_cetip,
        cast(regexp_replace(regexp_replace(regexp_replace(nu_cnpj_emissor,"\\.",""),"\\-",""),"\\/","") AS BIGINT)   nu_cnpj,
        qt_emitidas                qt_emitidas,
        vl_total_emissao      vl_total_emissao    
    FROM POC.CRIBASECADASTRO 
) CRI
LEFT JOIN (
    SELECT 
        nu_cnpj           nu_cnpj,
        nm_fantasia       nm_fantasia
    FROM POC.PESSOAJURIDICA
) PJ
ON PJ.NU_CNPJ = CRI.nu_cnpj;
;
