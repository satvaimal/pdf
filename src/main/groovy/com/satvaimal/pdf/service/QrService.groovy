package com.satvaimal.pdf.service

import net.glxn.qrgen.QRCode
import net.glxn.qrgen.image.ImageType

import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service

@Service
class QrService {

  @Value('${qr.width}')
  Integer qrWidth

  @Value('${qr.height}')
  Integer qrHeight

  byte[] generate( String input ) throws Exception {

    QRCode.from( input ).to( ImageType.PNG ).withSize(
        qrWidth, qrHeight ).stream().toByteArray()

  }// End of method

}// End of class
