<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">

  <xsl:include href="xsl/numberToWord.xsl"/>

  <xsl:attribute-set name="tableBorder">
    <xsl:attribute name="border-color">#333333</xsl:attribute>
    <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="textCell">
    <xsl:attribute name="padding">1.5pt</xsl:attribute>
  </xsl:attribute-set>

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
          <fo:block font-size="14pt" color="#333333"><xsl:apply-templates select="oxxoPayment"/></fo:block> 
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="oxxoPayment">

    <fo:table table-layout="fixed" width="100%">
    <fo:table-body>

      <fo:table-row>
        <fo:table-cell text-align="center">
          <fo:block><fo:external-graphic src="url('img/timbrale.png')" content-height="scale-to-fit" height="3cm" scaling="uniform"/></fo:block>
          <fo:block font-size="18pt" font-weight="bold"><xsl:text>Recibo de pago de servicios electr&#243;nicos</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

    </fo:table-body>
    </fo:table>

    <fo:table table-layout="fixed" width="100%" margin-top="1cm">
    <fo:table-column column-width="75%"/>
    <fo:table-column column-width="25%"/>
    <fo:table-body>

      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="tableBorder textCell" background-color="#ECECEC">
          <fo:block font-weight="bold"><xsl:text>Descripci&#243;n</xsl:text></fo:block>
        </fo:table-cell>
        <fo:table-cell text-align="right" xsl:use-attribute-sets="tableBorder textCell" background-color="#ECECEC">
          <fo:block font-weight="bold"><xsl:text>Importe</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>
      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="tableBorder textCell">
          <fo:block><xsl:value-of select="@description"/></fo:block>
        </fo:table-cell>
        <fo:table-cell text-align="right" xsl:use-attribute-sets="tableBorder textCell">
          <fo:block><xsl:value-of select="format-number(@amount, '$###,###,###,###.00')"/></fo:block>
        </fo:table-cell>
      </fo:table-row>

    </fo:table-body>
    </fo:table>

    <fo:table table-layout="fixed" width="100%" margin-top="1cm">
    <fo:table-body>

      <fo:table-row>
        <fo:table-cell>
          <fo:block font-weight="bold"><xsl:text>Importe con letra:</xsl:text></fo:block>
          <fo:block text-transform="uppercase">
            <xsl:call-template name="number-to-word">
              <xsl:with-param name="value" select="@amount"/>
            </xsl:call-template>
            <xsl:text> PESOS </xsl:text>
            <xsl:variable name="decimals" select="@amount - floor(@amount div 1)"/>
            <xsl:value-of select="translate(format-number($decimals, '#.00'), '.', '')"/>
            <xsl:text>/100 M.N.</xsl:text>
          </fo:block>
          <fo:block font-weight="bold"><xsl:text>Vigencia:</xsl:text></fo:block>
          <fo:block><xsl:value-of select="@expires"/></fo:block>
          <fo:block font-weight="bold"><xsl:text>Pago en una sola exhibici&#243;n</xsl:text></fo:block>
        </fo:table-cell>
      </fo:table-row>

    </fo:table-body>
    </fo:table>

    <fo:table table-layout="fixed" width="100%" margin-top="1cm">
    <fo:table-column column-width="50%"/>
    <fo:table-column column-width="50%"/>
    <fo:table-body>

      <fo:table-row>
        <fo:table-cell>
          <fo:block><fo:external-graphic src="url('img/oxxo.png')" content-height="scale-to-fit" height="2cm" scaling="uniform"/></fo:block>
        </fo:table-cell>
        <fo:table-cell text-align="right">
          <xsl:variable name="barcodeUrl" select="@barcodeUrl"/>
          <fo:block><fo:external-graphic src="url('{$barcodeUrl}')" content-height="scale-to-fit" height="1.5cm" scaling="uniform"/></fo:block>
          <fo:block font-size="9pt" font-weight="bold"><xsl:value-of select="@barcode"/></fo:block>
        </fo:table-cell>
      </fo:table-row>

    </fo:table-body>
    </fo:table>


    <fo:table table-layout="fixed" width="100%" border-top-style="dashed" margin-top="0.5cm">
    <fo:table-body>

      <fo:table-row>
        <fo:table-cell>
          <fo:block></fo:block>
        </fo:table-cell>
      </fo:table-row>

    </fo:table-body>
    </fo:table>

  </xsl:template>
</xsl:stylesheet>
