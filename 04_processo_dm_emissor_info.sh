#!/bin/sh -x
# importacao para o datalake


beeline -u "jdbc:hive2://sandbox-hdp.hortonworks.com:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2" -f /root/poc/04_processo_ingestao_data_mart.hql
retorno=$?
if [ ${retorno} -ne 0 ]; then
    echo "------------------------------------------------------------------------------------------------------------------"
    echo "FALHA AO FAZER A INGESTAO                                                                                         "
    echo "------------------------------------------------------------------------------------------------------------------"
    exit ${retorno}
else
    echo "------------------------------------------------------------------------------------------------------------------"
    echo "CARGA FEITA COM SUCESSO                                                                                        "
    echo "------------------------------------------------------------------------------------------------------------------"
fi

