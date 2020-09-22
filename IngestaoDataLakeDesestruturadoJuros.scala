import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.Row
import java.text.SimpleDateFormat;
import scala.collection.mutable.ListBuffer
import java.util.Locale
import java.lang.Double
import java.text.SimpleDateFormat


//object IngestaoDataLakeDesestruturadoJuros {

  object MapHiveTable{
    def setLine(lineArgs:String):Row = {
      
      //lineArgs = "05J00243740000820200921"
      var listFields = new ListBuffer[Any]()
      
      val cdCetip = lineArgs.substring(0,10)
      listFields += cdCetip
      
      val strvalor = lineArgs.substring(10,15)
      listFields += new java.math.BigDecimal(strvalor).divide(new java.math.BigDecimal(100))
  
      val strData = lineArgs.substring(15,23)
      val sdf = new SimpleDateFormat("yyyyMMdd")
      listFields += new java.sql.Date(sdf.parse(strData).getTime())    
     
      return Row.fromSeq(listFields)      
      
    }     
  } 
  
  
//  def main(args: Array[String]): Unit = {
    
    //val spark        = SparkSession.builder() 
    //                        .appName("Ingestao cribase cadastro")
    //                        .master("yarn")
    //                        .enableHiveSupport
    //                        .config("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
    //                        .config("hive.exec.parallel", "true")
    //                        .config("hive.exec.dynamic.partition", "true")
    //                        .config("hive.exec.dynamic.partition.mode", "nonstrict")      
    //                        .getOrCreate()
          
    
    val rddCsvFile  = spark.sparkContext.textFile("/poc/juroscri/20200921/*")
    
    println(rddCsvFile.first())
    
    val schema          = spark.table("poc.juroscri").schema
    
    val rddLinhaHive      = rddCsvFile.map(mapline => MapHiveTable.setLine(mapline)) 
    val dfHiveDetailCri   = spark.createDataFrame(rddLinhaHive, schema) // <--Cria o dataframe conforme schema
    dfHiveDetailCri.write.mode("append").format("orc").insertInto("poc.juroscri")
    spark.stop()
//  }
//}