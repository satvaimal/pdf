package com.satvaimal.pdf

import spock.lang.Specification

class XslServiceGetTemplateSpec extends Specification {

  def service = new XslService()

  def "getting an XSL template successfully"() {

    when:
      def result = service.getTemplate( name )
    then:
      result instanceof String
      result.size() > 0
    where:
      name = 'default'

  }// End of method

  def "template not found"() {

    when:
      service.getTemplate( name )
    then:
      IllegalArgumentException e = thrown()
      e.message == 'pdfService.getTemplate.name.notFound'
    where:
      name = 'notFound'

  }// End of method

  def "parameter 'name' is null"() {

    when:
      service.getTemplate( name )
    then:
      IllegalArgumentException e = thrown()
      e.message == 'pdfService.getTemplate.name.blank'
    where:
      name = null

  }// End of method

  def "parameter 'name' is blank"() {

    when:
      service.getTemplate( name )
    then:
      IllegalArgumentException e = thrown()
      e.message == 'pdfService.getTemplate.name.blank'
    where:
      name = ''

  }// End of method

}// End of class
