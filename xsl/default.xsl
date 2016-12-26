<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" xmlns:tfd="http://www.sat.gob.mx/TimbreFiscalDigital" exclude-result-prefixes="fo">

  <xsl:include href="xsl/numberToWord.xsl"/>

  <xsl:attribute-set name="titleCell">
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="background-color">#BEBEBE</xsl:attribute>
    <xsl:attribute name="color">#333333</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="padding">1.5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="textCell">
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="padding">1.5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="conceptTitleCell">
    <xsl:attribute name="background-color">#ECECEC</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="padding">1.5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="conceptTextCell">
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="padding">1.5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="fixedTextCell">
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-size">8.25pt</xsl:attribute>
    <xsl:attribute name="padding">1.5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="tableBorder">
    <xsl:attribute name="border-color">#BEBEBE</xsl:attribute>
    <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"/>
        <xsl:value-of select="$with"/>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text" select="substring-after($text,$replace)"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="with" select="$with"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="content" page-height="29.7cm" page-width="21.6cm" margin-top="1.5cm" margin-bottom="1.5cm" margin-left="1.5cm" margin-right="1.5cm">
          <fo:region-body/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="content">
        <fo:flow flow-name="xsl-region-body"> 
          <fo:block font-size="10pt" color="#333333"><xsl:apply-templates select="cfdi:Comprobante"/></fo:block> 
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="cfdi:Comprobante">

    <fo:table table-layout="fixed" width="100%">
    <fo:table-column column-width="50%"/>
    <fo:table-column column-width="50%"/>
    <fo:table-body>
      <fo:table-row>

        <fo:table-cell text-align="center">
          <fo:block><fo:external-graphic src="url('img/timbrale.png')" content-height="scale-to-fit" height="2cm" scaling="uniform"/></fo:block>
        </fo:table-cell>

        <fo:table-cell xsl:use-attribute-sets="textCell">
          <fo:block font-size="12pt" font-weight="bold"><xsl:value-of select="cfdi:Emisor/@nombre"/></fo:block>
          <fo:block><xsl:text>RFC: </xsl:text><xsl:value-of select="cfdi:Emisor/@rfc"/></fo:block>
          <fo:block><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@calle"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@noExterior"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@noInterior"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@colonia"/></fo:block>
          <fo:block><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@localidad"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@referencia"/></fo:block>
          <fo:block><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@municipio"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@estado"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@pais"/><xsl:text> C.P. </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:DomicilioFiscal/@codigoPostal"/></fo:block>
          <fo:block><xsl:text>R&#233;gimen fiscal: </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:RegimenFiscal/@Regimen"/></fo:block>
        </fo:table-cell>

      </fo:table-row>
    </fo:table-body>
    </fo:table>

    <fo:table table-layout="fixed" width="100%" xsl:use-attribute-sets="tableBorder">
    <fo:table-column column-width="25%"/>
    <fo:table-column column-width="25%"/>
    <fo:table-column column-width="25%"/>
    <fo:table-column column-width="25%"/>
    <fo:table-body>
      <fo:table-row>

        <fo:table-cell xsl:use-attribute-sets="titleCell" number-columns-spanned="2">
          <fo:block><xsl:text>Serie - Folio</xsl:text></fo:block>
        </fo:table-cell>

        <fo:table-cell xsl:use-attribute-sets="titleCell" number-columns-spanned="2">
          <fo:block><xsl:text>Folio fiscal (UUID)</xsl:text></fo:block>
        </fo:table-cell>

      </fo:table-row>
      <fo:table-row>

        <fo:table-cell xsl:use-attribute-sets="textCell" number-columns-spanned="2">
          <fo:block color="red" font-weight="bold" font-size="12pt"><xsl:value-of select="@serie"/><xsl:text> - </xsl:text><xsl:value-of select="@folio"/></fo:block>
        </fo:table-cell>

        <fo:table-cell xsl:use-attribute-sets="textCell" number-columns-spanned="2">
          <fo:block font-weight="bold" font-size="12pt"><xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@UUID"/></fo:block>
        </fo:table-cell>

      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell">
          <fo:block><xsl:text>Fecha de expedici&#243;n</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="titleCell">
          <fo:block><xsl:text>Fecha de certificaci&#243;n</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="titleCell">
          <fo:block><xsl:text>No. de certificado</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="titleCell">
          <fo:block><xsl:text>No. de certificado SAT</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="textCell">
          <fo:block><xsl:value-of select="translate(@fecha, 'T', ' ')"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="textCell">
          <fo:block><xsl:value-of select="translate(cfdi:Complemento/tfd:TimbreFiscalDigital/@FechaTimbrado, 'T', ' ')"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="textCell">
          <fo:block><xsl:value-of select="@noCertificado"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="textCell">
          <fo:block><xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@noCertificadoSAT"/></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell" number-columns-spanned="2">
          <fo:block><xsl:text>Receptor</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="titleCell" number-columns-spanned="2">
          <fo:block><xsl:text>Lugar de expedici&#243;n</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="textCell" number-columns-spanned="2">
          <fo:block font-weight="bold"><xsl:value-of select="cfdi:Receptor/@nombre"/></fo:block>
          <fo:block><xsl:text>RFC: </xsl:text><xsl:value-of select="cfdi:Receptor/@rfc"/></fo:block>
          <fo:block><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@calle"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@noExterior"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@noInterior"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@colonia"/></fo:block>
          <fo:block><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@localidad"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@referencia"/></fo:block>
          <fo:block><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@municipio"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@estado"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@pais"/><xsl:text> C.P. </xsl:text><xsl:value-of select="cfdi:Receptor/cfdi:Domicilio/@codigoPostal"/></fo:block>
        </fo:table-cell>

        <fo:table-cell xsl:use-attribute-sets="textCell" number-columns-spanned="2">
          <fo:block><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@calle"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@noExterior"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@noInterior"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@colonia"/></fo:block>
          <fo:block><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@localidad"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@referencia"/></fo:block>
          <fo:block><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@municipio"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@estado"/><xsl:text> </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@pais"/><xsl:text> C.P. </xsl:text><xsl:value-of select="cfdi:Emisor/cfdi:ExpedidoEn/@codigoPostal"/></fo:block>
        </fo:table-cell>

      </fo:table-row>
    </fo:table-body>
    </fo:table>

    <fo:table table-layout="fixed" width="100%" xsl:use-attribute-sets="tableBorder">
    <fo:table-column column-width="3cm"/>
    <fo:table-column column-width="3cm"/>
    <fo:table-column column-width="6.6cm"/>
    <fo:table-column column-width="2.5cm"/>
    <fo:table-column column-width="3.5cm"/>
    <fo:table-body>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell" number-columns-spanned="5">
          <fo:block><xsl:text>Conceptos</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="conceptTitleCell">
          <fo:block><xsl:text>Cantidad</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTitleCell">
          <fo:block><xsl:text>Unidad</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTitleCell">
          <fo:block><xsl:text>Descripci&#243;n</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTitleCell" text-align="right">
          <fo:block><xsl:text>Valor unitario</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTitleCell" text-align="right">
          <fo:block><xsl:text>Importe</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <xsl:for-each select="cfdi:Conceptos/cfdi:Concepto">
      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell">
          <fo:block><xsl:value-of select="@cantidad"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell">
          <fo:block><xsl:value-of select="@unidad"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell">
          <fo:block><xsl:value-of select="@descripcion"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right">
          <fo:block><xsl:value-of select="format-number(@valorUnitario, '$###,###,###,###.00')"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right">
          <fo:block><xsl:value-of select="format-number(@importe, '$###,###,###,###.00')"/></fo:block>
        </fo:table-cell>
      </fo:table-row>
      </xsl:for-each>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right" font-weight="bold" number-columns-spanned="4">
          <fo:block><xsl:text>Subtotal</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right" font-weight="bold">
          <fo:block><xsl:value-of select="format-number(@subTotal, '$###,###,###,###.00')"/></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <xsl:for-each select="cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado">
      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right" font-weight="bold" number-columns-spanned="4">
          <fo:block><xsl:value-of select="@impuesto"/><xsl:text> </xsl:text><xsl:value-of select="format-number(@tasa, '###,###,###,###.##')"/><xsl:text>%</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right" font-weight="bold">
          <fo:block><xsl:value-of select="format-number(@importe, '$###,###,###,###.00')"/></fo:block>
        </fo:table-cell>
      </fo:table-row>
      </xsl:for-each>

      <xsl:for-each select="cfdi:Impuestos/cfdi:Retenciones/cfdi:Retencion">
      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right" font-weight="bold" number-columns-spanned="4">
          <fo:block><xsl:value-of select="@impuesto"/><xsl:text> retenido</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right" font-weight="bold">
          <fo:block><xsl:value-of select="format-number(@importe, '$###,###,###,###.00')"/></fo:block>
        </fo:table-cell>
      </fo:table-row>
      </xsl:for-each>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right" font-weight="bold" number-columns-spanned="4">
          <fo:block><xsl:text>Total</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="conceptTextCell" text-align="right" font-weight="bold">
          <fo:block><xsl:value-of select="format-number(@total, '$###,###,###,###.00')"/></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell" text-align="left" number-columns-spanned="5">
          <fo:block><xsl:text>Importe con letra</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="textCell" text-align="left" text-transform="uppercase" number-columns-spanned="5">
          <fo:block>
            <xsl:call-template name="number-to-word">
              <xsl:with-param name="value" select="@total"/>
            </xsl:call-template>
            <xsl:text> PESOS </xsl:text>
            <xsl:variable name="decimals" select="@total - floor(@total div 1)"/>
            <xsl:value-of select="translate(format-number($decimals, '#.00'), '.', '')"/>
            <xsl:text>/100 M.N.</xsl:text>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell" text-align="left" number-columns-spanned="5">
          <fo:block><xsl:text>Cadena original del SAT</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="fixedTextCell" number-columns-spanned="5">
            <xsl:variable name="originalChain">||<xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@version"/>|<xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@UUID"/>|<xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@FechaTimbrado"/>|<xsl:value-of select="@sello"/>|<xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@noCertificadoSAT"/>||</xsl:variable>
          <fo:block>
            <xsl:value-of select="substring($originalChain, 1, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($originalChain, 106, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($originalChain, 211, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($originalChain, 316, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($originalChain, 421, 105)"/>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell" text-align="left" number-columns-spanned="5">
          <fo:block><xsl:text>Sello digital</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="fixedTextCell" number-columns-spanned="5">
          <xsl:variable name="sello" select="@sello"/>
          <fo:block>
            <xsl:value-of select="substring($sello, 1, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($sello, 106, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($sello, 211, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($sello, 316, 105)"/>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell" text-align="left" number-columns-spanned="5">
          <fo:block><xsl:text>Sello digital del SAT</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="fixedTextCell" number-columns-spanned="5">
          <xsl:variable name="selloSAT" select="cfdi:Complemento/tfd:TimbreFiscalDigital/@selloSAT"/>
          <fo:block>
            <xsl:value-of select="substring($selloSAT, 1, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($selloSAT, 106, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($selloSAT, 211, 105)"/>
          </fo:block>
          <fo:block>
            <xsl:value-of select="substring($selloSAT, 316, 105)"/>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>

    </fo:table-body>
    </fo:table>

    <fo:table table-layout="fixed" width="100%" xsl:use-attribute-sets="tableBorder">
    <fo:table-column column-width="6.5cm"/>
    <fo:table-column column-width="6.5cm"/>
    <fo:table-column column-width="5.6cm"/>
    <fo:table-body>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell" text-align="left">
          <fo:block><xsl:text>Tipo de comprobante</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="titleCell" text-align="left">
          <fo:block><xsl:text>M&#233;todo de pago</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="tableBorder" text-align="center" number-rows-spanned="5">
          <xsl:variable name="baseUrl">localhost:8080</xsl:variable>
          <xsl:variable name="re">
            <xsl:call-template name="replace-string">
              <xsl:with-param name="text" select="cfdi:Emisor/@rfc"/>
              <xsl:with-param name="replace" select="'&amp;'" />
              <xsl:with-param name="with" select="'%26'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="rr">
            <xsl:call-template name="replace-string">
              <xsl:with-param name="text" select="cfdi:Receptor/@rfc"/>
              <xsl:with-param name="replace" select="'&amp;'" />
              <xsl:with-param name="with" select="'%26'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="tt"><xsl:value-of select="format-number(@total, '0000000000.000000')"/></xsl:variable>
          <xsl:variable name="id"><xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@UUID"/></xsl:variable>
          <fo:block><fo:external-graphic src="url(http://{$baseUrl}/qr/get?input=%3Fre%3D{$re}%26rr%3D{$rr}%26tt%3D{$tt}%26id%3D{$id})" content-height="scale-to-fit" height="5cm" scaling="uniform"/></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="textCell" text-align="left" text-transform="uppercase">
          <fo:block><xsl:value-of select="@tipoDeComprobante"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="textCell" text-align="left">
          <fo:block><xsl:value-of select="@metodoDePago"/></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="titleCell" text-align="left">
          <fo:block><xsl:text>No. de cuenta de pago</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="titleCell" text-align="left">
          <fo:block><xsl:text>Lugar de expedici&#243;n</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="textCell" text-align="left">
          <fo:block><xsl:value-of select="@NumCtaPago"/></fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="textCell" text-align="left">
          <fo:block><xsl:value-of select="@LugarExpedicion"/></fo:block>
        </fo:table-cell>
      </fo:table-row>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="tableBorder textCell" number-columns-spanned="2">
          <fo:block font-size="12pt" font-weight="bold"><xsl:text>Emita sus facturas en www.timbrale.com.mx</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

    </fo:table-body>
    </fo:table>

    <fo:block xsl:use-attribute-sets="textCell" text-align="left" font-size="8pt"><xsl:text>Este documento es una representaci&#243;n impresa de un CFDI</xsl:text></fo:block>
    <fo:block xsl:use-attribute-sets="textCell" text-align="left" font-size="8pt"><xsl:value-of select="@formaDePago"/></fo:block>

  </xsl:template>
</xsl:stylesheet>
