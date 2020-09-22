#!/bin/sh -x
# importacao para o datalake
#astrapdod134

sqoop import \
      --connect jdbc:mysql://192.168.15.34:3306/clubecri?useSSL=false \
      --username sqoop \
      --password astrapdod134 \
      -e 'SELECT * FROM clubecri.pessoa_juridica WHERE $CONDITIONS' \
      --m 1 \
      --target-dir /poc/pessoajuridica/20200901 \
  
  

