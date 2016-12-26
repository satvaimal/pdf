package com.satvaimal.pdf.service

import org.springframework.stereotype.Service

@Service
class XslService {

  String getTemplate( String name ) throws Exception {

    if ( !name ) {
      throw new IllegalArgumentException( 'pdfService.getTemplate.name.blank' )
    }// End of if

    def xslBasePath = 'xsl/'
    def xslTemplate = new File( "${xslBasePath}${name}.xsl" )

    if ( !xslTemplate.exists() ) {
      throw new IllegalArgumentException(
          'pdfService.getTemplate.name.notFound' )
    }// End of if

    xslTemplate.text

  }// End of method

}// End of class
