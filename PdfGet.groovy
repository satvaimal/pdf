@Grab( 'com.github.groovy-wslite:groovy-wslite:1.1.2' )
import wslite.rest.RESTClient

def data = [:]
def xml = new File( 'src/test/resources/cfdi.xml' ).text
xml = editXml( xml )
data.xml = xml.bytes.encodeBase64().toString()
data.template = 'default'
def client = new RESTClient( 'http://localhost:8080' )
def response = client.post( path:'/pdf/get' ) {
  json data
}
new File( 'build/output.pdf' ).bytes = response.json.pdf.decodeBase64()
null

String editXml( String xml ) {

  def parser = new XmlParser().parseText( xml )
  def maxSize = 65
  parser.'@sello' = parser.'@sello' * 2
  parser.'cfdi:Complemento'.'tfd:TimbreFiscalDigital'[ 0 ].'@selloSAT' =
      parser.'cfdi:Complemento'.'tfd:TimbreFiscalDigital'[ 0 ].'@selloSAT' * 2
  def writer = new StringWriter()
  def indentPrinter = new IndentPrinter( writer, '', false )
  new XmlNodePrinter( indentPrinter ).print( parser )
  writer.toString()

}// End of method