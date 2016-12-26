package com.satvaimal.pdf

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.ResponseStatus

@Controller
class QrController {

  @Autowired
  QrService qrService

  @RequestMapping(value = '/qr/get', method = RequestMethod.GET )
  @ResponseBody
  HttpEntity<byte[]> getQr( @RequestParam( 'input' ) String input ) {

    def qr = qrService.generate( input )
    def headers = new HttpHeaders()
    headers.setContentType( MediaType.IMAGE_PNG )
    headers.setContentLength( qr.length )
    new HttpEntity<byte[]>( qr, headers )

  }// End of method

}// End of class
