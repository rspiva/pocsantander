#!/bin/sh -x
# importacao para o datalake
dataref="20200901"

hadoop fs -mkdir -p /poc/detalhecri/${dataref}/
hadoop fs -put /root/poc/staging/detalhecri/* /poc/detalhecri/${dataref}/
retorno=$?
if [ ${retorno} -ne 0 ]; then
    echo "------------------------------------------------------------------------------------------------------------------"
    echo "FALHA AO FAZER A INGESTAO                                                                                         "
    echo "------------------------------------------------------------------------------------------------------------------"
    exit ${retorno}
else
    echo "------------------------------------------------------------------------------------------------------------------"
    echo "INGESTAO FEITA COM SUCESSO                                                                                        "
    echo "REMOCAO DA STAGE                                                                                                  "
    echo "------------------------------------------------------------------------------------------------------------------"
    rm /root/poc/staging/detalhecri/*
fi

