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
class QrServiceGenerate {

  final static Logger log = LoggerFactory.getLogger(
      'com.satvaimal.pdf.QrServiceGenerate' )

  @Pointcut(
    value='execution(byte[] com.satvaimal.pdf.QrService.generate(..)) && bean(qrService) && args(input)',
    argNames='input'
  )
  public void generate( String input ) {}

  @Before('generate(input)')
  void before( String input ) {
    log.info( "<< input:{}", input )
  }// End of method

  @AfterReturning(
    pointcut='generate(String)',
    returning='qr'
  )
  void afterReturning( byte[] qr ) {
    log.info( ">> qr:{} B", qr?.size() )
  }// End of method

  @AfterThrowing(
    pointcut='generate(String)',
    throwing='e'
  )
  void afterThrowing( Exception e ) {
    log.info( "XX ${e.class.simpleName} - ${e.message}" )
  }// End of method

}// End of class
