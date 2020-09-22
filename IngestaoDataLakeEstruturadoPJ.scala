
import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.Row
import java.text.SimpleDateFormat;
import scala.collection.mutable.ListBuffer
import java.util.Locale;



  object MapHiveTable{
    def setLine(lineArgs:String):Row = {
      var listFields = new ListBuffer[Any]()
            
      val tokens = lineArgs.split(",")
      
      listFields += tokens(0)
      listFields += tokens(1)
      listFields += tokens(2)
      
      
      listFields += 20200901 // <-- pode ser incluido nos dados ou pode se passado por parametro
      
      //*** Cortando as colunas por aqui, mas é possivel continuar para copletar as colunas
      return Row.fromSeq(listFields)      
      
    }     
  }  
  
  
  
 // def main(args: Array[String]): Unit = {
    
    //val spark        = SparkSession.builder() 
    //                        .appName("Ingestao cribase cadastro")
    //                        .master("yarn")
    //                        .enableHiveSupport
    //                        .config("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
    //                        .config("hive.exec.parallel", "true")
    //                        .config("hive.exec.dynamic.partition", "true")
    //                        .config("hive.exec.dynamic.partition.mode", "nonstrict")      
    //                        .getOrCreate()
          
    spark.conf.set("hive.exec.dynamic.partition", "true")
    spark.conf.set("hive.exec.dynamic.partition.mode", "nonstrict")
    val rddCsvFile  = spark.sparkContext.textFile("/poc/pessoajuridica/20200901/*")
    
    val schema          = spark.table("poc.pessoajuridica").schema
    
    val rddLinhaHive      = rddCsvFile.map(mapline => MapHiveTable.setLine(mapline)) 
    val dfHivePJ   = spark.createDataFrame(rddLinhaHive, schema) // <--Cria o dataframe conforme schema
    dfHivePJ.write.mode("append").format("orc").insertInto("poc.pessoajuridica")
    spark.stop()
 // }  
  
  