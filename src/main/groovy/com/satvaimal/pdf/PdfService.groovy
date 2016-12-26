package com.satvaimal.pdf

import javax.xml.transform.TransformerFactory
import javax.xml.transform.sax.SAXResult
import javax.xml.transform.stream.StreamSource

import org.apache.fop.apps.FopFactory
import org.apache.fop.apps.MimeConstants

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class PdfService {

  def fopFactory

  @Autowired
  XslService xslService

  PdfService() {
    fopFactory = FopFactory.newInstance()
  }// End of constructor

  byte[] getFromXml( String xml, String templateName ) throws Exception {

    validateGetFromXmlInput( xml, templateName )
    def baos = new ByteArrayOutputStream()
    def out = new BufferedOutputStream( baos )
    def fop = fopFactory.newFop( MimeConstants.MIME_PDF, out )
    def xslTemplate = xslService.getTemplate( templateName )
    def xslt = new StreamSource( new StringReader( xslTemplate ) )
    def factory = TransformerFactory.newInstance()
    def transformer = factory.newTransformer( xslt )
    def src = new StreamSource( new StringReader( xml ) )
    def res = new SAXResult( fop.getDefaultHandler() )
    transformer.transform( src, res )
    out.close()
    baos.toByteArray()

  }// End of method

  void validateGetFromXmlInput( String xml, String templateName )
      throws Exception {

    if ( !xml ) {
      throw new IllegalArgumentException( 'pdfService.getFromXml.xml.blank' )
    }// End of if

    if ( !templateName ) {
      throw new IllegalArgumentException(
          'pdfService.getFromXml.templateName.blank' )
    }// End of if

  }// End of method

}// End of class
