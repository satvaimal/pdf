package com.satvaimal.pdf.controller

import com.satvaimal.pdf.service.PdfService

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.ResponseStatus

@RestController
class PdfController {

  @Autowired
  PdfService pdfService

  @RequestMapping(value = "/pdf/get", method = RequestMethod.POST)
  Map getPdf( @RequestBody PdfGetRequest input ) {

    def xml = input.xml?.decodeBase64()
    def pdf = pdfService.getFromXml( new String(  xml ?: '' ), input.template )
    [ pdf:pdf.encodeBase64().toString() ]

  }// End of method

  @ResponseStatus(value = HttpStatus.BAD_REQUEST)
  @ExceptionHandler(IllegalArgumentException)
  Map handleIllegalArgumentException( IllegalArgumentException e ) {
    [ error:e.message ]
  }// End of method

}// End of class
