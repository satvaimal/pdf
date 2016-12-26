package com.satvaimal.pdf

import org.aspectj.lang.annotation.AfterReturning
import org.aspectj.lang.annotation.AfterThrowing
import org.aspectj.lang.annotation.Aspect
import org.aspectj.lang.annotation.Before
import org.aspectj.lang.annotation.Pointcut

import org.slf4j.Logger
import org.slf4j.LoggerFactory

import org.springframework.stereotype.Component

@Component
@Aspect
class PdfServiceGetFromXml {

  final static Logger log = LoggerFactory.getLogger(
      'com.satvaimal.pdf.PdfServiceGetFromXml' )

  @Pointcut(
    value='execution(byte[] com.satvaimal.pdf.PdfService.getFromXml(..)) && bean(pdfService) && args(xml, templateName)',
    argNames='xml, templateName'
  )
  public void getFromXml( String xml, String templateName ) {}

  @Before('getFromXml(xml, templateName)')
  void before( String xml, String templateName ) {
    log.info( "<< {} B, '{}'", xml?.size(), templateName )
  }// End of method

  @AfterReturning(
    pointcut='getFromXml(String, String)',
    returning='pdf'
  )
  void afterReturning( byte[] pdf ) {
    log.info( ">> {} B", pdf?.size() )
  }// End of method

  @AfterThrowing(
    pointcut='getFromXml(String, String)',
    throwing='e'
  )
  void afterThrowing( Exception e ) {
    log.info( "XX ${e.class.simpleName} - ${e.message}" )
  }// End of method

}// End of class
