package com.satvaimal.pdf.service

import spock.lang.Specification

class PdfServiceGetFromXmlSpec extends Specification {

  def service = new PdfService()
  def xslService = Mock( XslService )

  def setup() {
    service.xslService = xslService
  }// End of method

  def "creating a PDF successfully"() {

    when:
      def result = service.getFromXml( xml, templateName )
    then:
      1 * xslService.getTemplate( _ as String ) >> xsl
      result instanceof byte[]
      result.size() > 0
    where:
      xml = new File( 'src/test/resources/cfdi.xml' ).text
      templateName = 'default'
      xsl = new File( 'xsl/default.xsl' ).text

  }// End of method

  def "parameter 'xml' is null"() {

    when:
      service.getFromXml( xml, templateName )
    then:
      IllegalArgumentException e = thrown()
      e.message == 'pdfService.getFromXml.xml.blank'
    where:
      xml = null
      templateName = 'templateName'

  }// End of method

  def "parameter 'xml' is blank"() {

    when:
      service.getFromXml( xml, templateName )
    then:
      IllegalArgumentException e = thrown()
      e.message == 'pdfService.getFromXml.xml.blank'
    where:
      xml = ''
      templateName = 'templateName'

  }// End of method

  def "parameter 'templateName' is null"() {

    when:
      service.getFromXml( xml, templateName )
    then:
      IllegalArgumentException e = thrown()
      e.message == 'pdfService.getFromXml.templateName.blank'
    where:
      xml = 'xml'
      templateName = null

  }// End of method

  def "parameter 'templateName' is blank"() {

    when:
      service.getFromXml( xml, templateName )
    then:
      IllegalArgumentException e = thrown()
      e.message == 'pdfService.getFromXml.templateName.blank'
    where:
      xml = 'xml'
      templateName = ''

  }// End of method

  def "parameter 'templateName' is invalid"() {

    when:
      service.getFromXml( xml, templateName )
    then:
      1 * xslService.getTemplate( _ as String ) >> {
          throw new IllegalArgumentException( 'error' ) }
      IllegalArgumentException e = thrown()
      e.message == 'error'
    where:
      xml = 'xml'
      templateName = 'invalid'

  }// End of method

}// End of class
