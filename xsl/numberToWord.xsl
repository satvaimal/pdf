<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="number-to-word">
    <xsl:param name="value"/>

    <xsl:variable name="intNumber" select="floor($value div 1)"/>

    <xsl:choose>

      <xsl:when test="$intNumber &lt; 1000">
        <xsl:call-template name="get-word">
          <xsl:with-param name="value" select="$intNumber"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$intNumber &gt;= 1000 and $intNumber &lt; 1000000">
        <xsl:call-template name="get-thousands">
          <xsl:with-param name="value" select="$intNumber"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:otherwise>

        <xsl:variable name="millions" select="floor($intNumber div 1000000)"/>
        <xsl:variable name="thousands" select="floor($millions div 1000)"/>
        <xsl:variable name="rest" select="$intNumber mod 1000000"/>

        <xsl:choose>

          <xsl:when test="$millions &gt; 1">
            <xsl:call-template name="get-thousands">
              <xsl:with-param name="value" select="$millions"/>
              <xsl:with-param name="space" select="$thousands != 0"/>
            </xsl:call-template>
            <xsl:text> millones</xsl:text>
          </xsl:when>

          <xsl:otherwise>
            <xsl:text> un mill&#243;n</xsl:text>
          </xsl:otherwise>

        </xsl:choose>

        <xsl:choose>

          <xsl:when test="$rest != 0 and $rest &gt;= 1000">
            <xsl:text> </xsl:text>
          </xsl:when>

        </xsl:choose>

        <xsl:call-template name="get-thousands">
          <xsl:with-param name="value" select="$rest"/>
        </xsl:call-template>

      </xsl:otherwise>

    </xsl:choose>
  
  </xsl:template>

  <xsl:template name="get-word">
    <xsl:param name="value"/>

    <xsl:choose>
      <xsl:when test="$value = 100">
        <xsl:text>cien</xsl:text>
      </xsl:when>
      <xsl:otherwise>

        <xsl:variable name="mod" select="$value mod 100"/>
        <xsl:variable name="hundreds" select="floor($value div 100)"/>
        <xsl:variable name="tens" select="floor($mod div 10)"/>
        <xsl:variable name="units" select="$mod mod 10"/>

        <xsl:call-template name="get-hundreds">
          <xsl:with-param name="value" select="$hundreds"/>
        </xsl:call-template>

        <xsl:choose>
          <xsl:when test="$hundreds != 0 and ( $tens != 0 or $units != 0 )">
            <xsl:text> </xsl:text>
          </xsl:when>
        </xsl:choose>

        <xsl:choose>

          <xsl:when test="$mod  &gt;= 10 and $mod &lt;= 20">
            <xsl:call-template name="get-quick-number">
              <xsl:with-param name="value" select="$mod"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="$tens = 2">
            <xsl:text>veinti</xsl:text>
            <xsl:call-template name="get-units">
              <xsl:with-param name="value" select="$units"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:otherwise>

            <xsl:choose>
              <xsl:when test="$tens != 0">
                <xsl:call-template name="get-tens">
                  <xsl:with-param name="value" select="$tens"/>
                </xsl:call-template>
              </xsl:when>
            </xsl:choose>

            <xsl:choose>
              <xsl:when test="$units != 0 and $tens != 0">
                <xsl:text> y </xsl:text>
              </xsl:when>
            </xsl:choose>

            <xsl:call-template name="get-units">
              <xsl:with-param name="value" select="$units"/>
            </xsl:call-template>

          </xsl:otherwise>

        </xsl:choose>

      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="get-thousands">
    <xsl:param name="value"/>
    <xsl:param name="space" select="true()"/>

    <xsl:variable name="thousands" select="floor($value div 1000)"/>
    <xsl:variable name="rest" select="$value mod 1000"/>

    <xsl:choose>
      <xsl:when test="$thousands &gt; 1">
        <xsl:call-template name="get-word">
          <xsl:with-param name="value" select="$thousands"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:when>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="$thousands != 0">
        <xsl:text>mil</xsl:text>
      </xsl:when>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="$space and $rest != 0">
        <xsl:text> </xsl:text>
      </xsl:when>
    </xsl:choose>

    <xsl:call-template name="get-word">
      <xsl:with-param name="value" select="$rest"/>
    </xsl:call-template>
  
  </xsl:template>

  <xsl:template name="get-quick-number">
    <xsl:param name="value"/>

    <xsl:choose>
      <xsl:when test="$value = 10">diez</xsl:when>
      <xsl:when test="$value = 11">once</xsl:when>
      <xsl:when test="$value = 12">doce</xsl:when>
      <xsl:when test="$value = 13">trece</xsl:when>
      <xsl:when test="$value = 14">catorce</xsl:when>
      <xsl:when test="$value = 15">quince</xsl:when>
      <xsl:when test="$value = 16">dieciseis</xsl:when>
      <xsl:when test="$value = 17">diecisiete</xsl:when>
      <xsl:when test="$value = 18">dieciocho</xsl:when>
      <xsl:when test="$value = 19">diecinueve</xsl:when>
      <xsl:when test="$value = 20">veinte</xsl:when>
    </xsl:choose>
  
  </xsl:template>

  <xsl:template name="get-hundreds">
    <xsl:param name="value"/>

    <xsl:choose>
      <xsl:when test="$value = 0"></xsl:when>
      <xsl:when test="$value = 1">ciento</xsl:when>
      <xsl:when test="$value = 2">doscientos</xsl:when>
      <xsl:when test="$value = 3">trescientos</xsl:when>
      <xsl:when test="$value = 4">cuatrocientos</xsl:when>
      <xsl:when test="$value = 5">quinientos</xsl:when>
      <xsl:when test="$value = 6">seiscientos</xsl:when>
      <xsl:when test="$value = 7">setecientos</xsl:when>
      <xsl:when test="$value = 8">ochocientos</xsl:when>
      <xsl:when test="$value = 9">novecientos</xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="get-tens">
    <xsl:param name="value"/>

    <xsl:choose>
      <xsl:when test="$value = 3">treinta</xsl:when>
      <xsl:when test="$value = 4">cuarenta</xsl:when>
      <xsl:when test="$value = 5">cincuenta</xsl:when>
      <xsl:when test="$value = 6">sesenta</xsl:when>
      <xsl:when test="$value = 7">setenta</xsl:when>
      <xsl:when test="$value = 8">ochenta</xsl:when>
      <xsl:when test="$value = 9">noventa</xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="get-units">
    <xsl:param name="value"/>

    <xsl:choose>
      <xsl:when test="$value = 1">un</xsl:when>
      <xsl:when test="$value = 2">dos</xsl:when>
      <xsl:when test="$value = 3">tres</xsl:when>
      <xsl:when test="$value = 4">cuatro</xsl:when>
      <xsl:when test="$value = 5">cinco</xsl:when>
      <xsl:when test="$value = 6">seis</xsl:when>
      <xsl:when test="$value = 7">siete</xsl:when>
      <xsl:when test="$value = 8">ocho</xsl:when>
      <xsl:when test="$value = 9">nueve</xsl:when>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
