package com.satvaimal.pdf.service.aop

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
class XslServiceGetTemplate {

  final static Logger log = LoggerFactory.getLogger(
      'com.satvaimal.pdf.service.aop.XslServiceGetTemplate' )

  @Pointcut(
    value='execution(String com.satvaimal.pdf.service.XslService.getTemplate(..)) && bean(xslService) && args(name)',
    argNames='name'
  )
  public void getTemplate( String name ) {}

  @Before('getTemplate(name)')
  void before( String name ) {
    log.info( "<< '{}'", name )
  }// End of method

  @AfterReturning(
    pointcut='getTemplate(String)',
    returning='xsl'
  )
  void afterReturning( String xsl ) {
    log.info( ">> {} B", xsl?.size() )
  }// End of method

  @AfterThrowing(
    pointcut='getTemplate(String)',
    throwing='e'
  )
  void afterThrowing( Exception e ) {
    log.info( "XX ${e.class.simpleName} - ${e.message}" )
  }// End of method

}// End of class
