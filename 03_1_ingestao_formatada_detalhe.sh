#!/bin/sh -x
# ingestao formatada clube_cri_detalhe


JAR=/root/poc/lib/POCSantader-0.0.4-SNAPSHOT-jar-with-dependencies.jar
CLASS=com.pocsantander.spark.IngestaoDataLakeEstruturadoCRI

export SPARK_MAJOR_VERSION=2
spark-submit \
--class ${CLASS} \
--master yarn \
--deploy-mode client \
--driver-memory 2G \
--executor-memory 2G \
--executor-cores 8 \
--conf "spark.dynamicAllocation.enabled=true" \
--conf "spark.shuffle.service.enabled=true" \
--conf "spark.shuffle.service.port=7337" \
--conf "spark.dynamicAllocation.initialExecutors=10" \
--conf "spark.dynamicAllocation.minExecutors=10" \
--conf "spark.dynamicAllocation.maxExecutors=80" \
--conf "spark.yarn.driver.memoryOverhead=2000" \
--conf "spark.yarn.executor.memoryOverhead=2000" \
--queue "defualt" \
--jar ${JAR_PATH}   
