package com.pocsantander.spark

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.Row
import java.text.SimpleDateFormat;
import scala.collection.mutable.ListBuffer
import java.util.Locale


object IngestaoDataLakeEstruturadoCRI {

  object MapHiveTable{
    def setLine(lineArgs:String):Row = {
      var listFields = new ListBuffer[Any]()
      
      
      
      val tokens = lineArgs.split(";")
      
      listFields += tokens(0)
      listFields += tokens(1)
      listFields += tokens(2)
      listFields += tokens(3)
      listFields += new java.math.BigDecimal(if (tokens(4).equals("")) "0" else tokens(4).replaceAll("\\.", "").replaceAll("\\,", "\\.")).longValue()
      listFields += new java.math.BigDecimal(if (tokens(5).equals("")) "0" else tokens(5).replaceAll("\\.", "").replaceAll("\\,", "\\.")).longValue()
      listFields += new java.math.BigDecimal(if (tokens(6).equals("")) "0" else tokens(6).replaceAll("\\.", "").replaceAll("\\,", "\\.")).longValue()
      listFields += new java.math.BigDecimal(if (tokens(7).equals("")) "0" else tokens(7).replaceAll("\\.", "").replaceAll("\\,", "\\."))
      
     val sdf = new SimpleDateFormat("dd/MM/yyyy",new Locale("pt_BR"))
      
      val dtEmissao = sdf.parse(tokens(8))        			
      listFields += new java.sql.Date(dtEmissao.getTime())
      
      if(tokens(9) == null || tokens(9).equals("")) {
    			listFields += null
    	}else {
    			val dtVencimento = sdf.parse(tokens(9))        			
    			listFields += new java.sql.Date(dtVencimento.getTime())
    	}
    	
      listFields += 20200901 // <-- pode ser incluido nos dados ou pode se passado por parametro
      
      //*** Cortando as colunas por aqui, mas é possivel continuar para copletar as colunas
      return Row.fromSeq(listFields)      
      
    }     
  }  
  
  
  
  def main(args: Array[String]): Unit = {
    
    val spark        = SparkSession.builder() 
                            .appName("Ingestao cribase cadastro")
                            .master("yarn")
                            .enableHiveSupport
                            .config("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
                            .config("hive.exec.parallel", "true")
                            .config("hive.exec.dynamic.partition", "true")
                            .config("hive.exec.dynamic.partition.mode", "nonstrict")      
                            .getOrCreate()
          
    
    val rddCsvFile  = spark.sparkContext.textFile("/poc/detalhecri/20200901/*")
    
    println(rddCsvFile.first())
    
    val schema          = spark.table("poc.cribasecadastro").schema
    
    val rddLinhaHive      = rddCsvFile.map(mapline => MapHiveTable.setLine(mapline)) 
    val dfHiveDetailCri   = spark.createDataFrame(rddLinhaHive, schema) // <--Cria o dataframe conforme schema
    dfHiveDetailCri.write.mode("append").format("orc").insertInto("poc.cribasecadastro")
    spark.stop()
  }
  
}