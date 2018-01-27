<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:oxd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs"
  version="3.0">
  
  <xsl:output indent="yes" method="text"/>
  
  <oxd:doc scope="stylesheet">
    <oxd:desc>
      <oxd:p><oxd:b>name: </oxd:b>extract-xml-schema-documentation</oxd:p>
      <oxd:p><oxd:b>version: </oxd:b>0.1.2</oxd:p>
      <oxd:p><oxd:b>description: </oxd:b>Extract xml schema documentation and output as a JSON structure.</oxd:p>
      <oxd:p><oxd:b>main: </oxd:b>extract-xml-schema-documentation.xsl</oxd:p>
      <oxd:p><oxd:b>author: </oxd:b>[George Moyano] (https://onename.com/gmoyano)</oxd:p>
      <oxd:p><oxd:b>license: </oxd:b>MIT</oxd:p>
      <oxd:p><oxd:b>dependencies: </oxd:b>none</oxd:p>
      <oxd:p/>
    </oxd:desc>
  </oxd:doc>
  
  <xsl:template match="node() | @*">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*:documentation">
    <xsl:choose>
      <xsl:when test="preceding-sibling::*:documentation"/>
      <xsl:otherwise>"documentation": [ </xsl:otherwise>
    </xsl:choose>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="fn:replace(fn:replace(normalize-space(.),'\\', '\\\\'), '&quot;', '\\&quot;')"/>
    <xsl:text>"</xsl:text>
    <xsl:choose>
      <xsl:when test="following-sibling::*:documentation">, </xsl:when>
      <xsl:otherwise>] </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:enumeration">
    <xsl:if test="not(preceding-sibling::*)">"enumeration": [ </xsl:if> 
    <xsl:text>{ "value": </xsl:text>
    <xsl:value-of select="./@value"/>
    <!--<xsl:text>, "documentation": </xsl:text>-->
    <xsl:if test=" descendant::*">, </xsl:if>
    <xsl:apply-templates/>
    <xsl:text> } </xsl:text>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
      <xsl:otherwise> ] </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*:fractionDigits">
    <!--<xsl:if test="preceding-sibling::*">, </xsl:if>-->
    <xsl:text>"fractionDigits": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:totalDigits">
    <!--<xsl:if test="preceding-sibling::*">, </xsl:if>-->
    <xsl:text>"totalDigits": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*:maxExclusive">
    <xsl:text>"maxExclusive": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:minExclusive">
    <xsl:if test="preceding-sibling::*">, </xsl:if>
    <xsl:text>"minExclusive": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:maxInclusive">
    <xsl:text>"maxInclusive": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:minInclusive">
    <xsl:text>"minInclusive": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*:maxLength">
    <xsl:text>"maxLength": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:length">
    <xsl:text>"length": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:minLength">
    <xsl:text>"minLength": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:pattern">
    <xsl:text>"pattern": "</xsl:text>
    <xsl:value-of select="fn:replace(fn:replace(normalize-space(./@value),'\\', '\\\\'), '&quot;', '\\&quot;')"/>
    <xsl:text>"</xsl:text>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:restriction">
    <!--<xsl:if test="not(preceding-sibling::*)">"restrictions": [ </xsl:if>-->
    <!--<xsl:if test="count(../preceding-sibling::*)=0">"restrictions": [ </xsl:if>-->
    <!--<xsl:text>{ </xsl:text>-->
    <!--<xsl:if test="count(../preceding-sibling::*)=0"> { </xsl:if>-->
    <xsl:if test="preceding-sibling::*">, </xsl:if>
    <xsl:apply-templates select="./*"/>
    <!--<xsl:text> } </xsl:text>-->
    <!--<xsl:choose>-->
      <!--<xsl:when test="position()!=last()">, </xsl:when>-->
      <!--<xsl:otherwise> ] </xsl:otherwise>-->
    <!--</xsl:choose>-->
    <!--<xsl:if test="position()!=last()">, </xsl:if>-->
    <!--<xsl:if test="position()=last()">] </xsl:if>-->
    <!--<xsl:if test="count(../preceding-sibling::*)+1=count(../../*:simpleType)">] </xsl:if>-->
    <!--<xsl:if test="not(parent::*/following-sibling::*)">] </xsl:if>-->
    <!--<xsl:if test="not(parent::*/following-sibling::*)">} </xsl:if>-->
  </xsl:template>
  
  <xsl:template match="*:simpleType">
    <!--<xsl:apply-templates select="descendant::*:simpleType"/>-->
    <!--<xsl:apply-templates select="./*:restriction"/>-->
    <xsl:if test="not(descendant::*:simpleType)"><xsl:text> { </xsl:text></xsl:if>
    <!--<xsl:if test="preceding-sibling::*">, </xsl:if>-->
    <!--<xsl:text> { </xsl:text>-->
    <xsl:apply-templates/>
    <!--<xsl:choose>-->
      <!--<xsl:when test="position()!=last()">, </xsl:when>-->
    <xsl:if test="not(descendant::*:simpleType)"><xsl:text> }</xsl:text></xsl:if>
      <xsl:if test="following-sibling::*">, </xsl:if>
      <!--<xsl:otherwise> ] </xsl:otherwise>-->
    <!--</xsl:choose>-->
    <!--<xsl:text> } </xsl:text>-->
<!--    <xsl:choose>
    <xsl:when test="not(following-sibling::*)"><xsl:text> ] </xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>

  <xsl:template match="*:attribute">
    <xsl:if test="preceding-sibling::*">, </xsl:if>
    <xsl:text>, "attributes": { </xsl:text>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="./@name"/>
    <xsl:text>": { "facets": [ </xsl:text>
    <!--<xsl:if test="./*:simpleType">-->
      <!--<xsl:text>{ </xsl:text>-->
      <xsl:apply-templates select="./*:simpleType"/>
      <xsl:text> ] </xsl:text>
      <!--<xsl:text>} </xsl:text>-->
    <!--</xsl:if>-->
    <xsl:text>} </xsl:text>
    <xsl:text>} </xsl:text>
  </xsl:template>
  
  <xsl:template match="*:complexType">
    <xsl:if test="preceding-sibling::*:complexType">, </xsl:if>
    <xsl:text>"</xsl:text>
    <xsl:choose>
      <xsl:when test="./@name">
        <xsl:value-of select="./@name"/></xsl:when>
      <xsl:otherwise>anonymousType</xsl:otherwise>
    </xsl:choose>
    <xsl:text>": { "type": "complexType", "documentation": </xsl:text>
    <xsl:choose>
      <xsl:when test="*:annotation/*:documentation">
        <xsl:apply-templates select="./*:annotation/*:documentation"/></xsl:when>
      <xsl:otherwise>[] </xsl:otherwise>
    </xsl:choose>
    <xsl:text>} </xsl:text>
  </xsl:template>
  
  <xsl:template match="*:element">
    <xsl:if test="preceding-sibling::*">, </xsl:if>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="./@name"/>
    <xsl:text>": { "type": "element", "facets": { </xsl:text>
    <!--<xsl:choose>
      <xsl:when test="./*:simpleType">-->
        <xsl:apply-templates select="./*:simpleType"/>
        <!--<xsl:text>} </xsl:text>-->
      <!--</xsl:when>
      <xsl:otherwise>-->
        <!--<xsl:text>}, "attributes": { </xsl:text>-->
    <xsl:text>} </xsl:text>
        <!--<xsl:choose>
          <xsl:when test="./*:complexType/*:attribute">-->
            <xsl:apply-templates select="./*:complexType/*:attribute"/>
          <!--</xsl:when>
        </xsl:choose>-->
        <!--<xsl:text>} </xsl:text>-->
      <!--</xsl:otherwise>
    </xsl:choose>-->
    <!--<xsl:text>} </xsl:text>-->
    <xsl:text>} </xsl:text>
  </xsl:template>
  
  <xsl:template match="*:schema">
    <xsl:text>{ "schemaUri": "</xsl:text>
    <xsl:value-of select="//@targetNamespace"/>
    <xsl:text>", "documentation": [</xsl:text>
    <xsl:apply-templates select="*:annotation/*:documentation"/>
    <xsl:text>],</xsl:text>
    <xsl:text>"components": {</xsl:text>
    <!--<xsl:if test="*:simpleType">-->
      <xsl:apply-templates select="*:simpleType"/>
      <!--<xsl:text>, </xsl:text>-->
    <!--</xsl:if>-->
    <!--<xsl:if test="*:complexType">-->
      <xsl:apply-templates select="*:complexType"/>
      <!--<xsl:text>, </xsl:text>-->
    <!--</xsl:if>-->
    <!--<xsl:if test="*:element">-->
      <xsl:apply-templates select="*:element"/>
      <!--<xsl:text>, </xsl:text>-->
    <!--</xsl:if>-->
    <xsl:text>} </xsl:text>
    <xsl:text>}</xsl:text>
  </xsl:template>

</xsl:stylesheet>