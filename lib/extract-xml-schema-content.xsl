<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:oxd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs"
  version="3.0">
  
  <xsl:output indent="yes" method="text"/>
  
  <xsl:variable name="xsltName" select="'extract-xml-schema-content'"/>
  <xsl:variable name="xsltVersion" select="'1.2.0'"/>
  
  <oxd:doc scope="stylesheet">
    <oxd:desc>
      <oxd:p><oxd:b>name: </oxd:b><xsl:value-of select="$xsltName"/></oxd:p>
      <oxd:p><oxd:b>version: </oxd:b><xsl:value-of select="$xsltVersion"/></oxd:p>
      <oxd:p><oxd:b>description: </oxd:b>Extract xml schema content missed by JAXB and output it as a JSON structure.</oxd:p>
      <oxd:p><oxd:b>main: </oxd:b>extract-xml-schema-content.xsl</oxd:p>
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
    <!--<xsl:if test="preceding-sibling::*:documentation">, </xsl:if>-->
    <xsl:choose>
      <xsl:when test="not(preceding-sibling::*:documentation)">"documentation": [ </xsl:when>
      <xsl:otherwise>, </xsl:otherwise>
    </xsl:choose>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="fn:replace(fn:replace(normalize-space(.),'\\', '\\\\'), '&quot;', '\\&quot;')"/>
    <xsl:text>"</xsl:text>
    <!--<xsl:choose>
      <xsl:when test="following-sibling::*:documentation">, </xsl:when>
      <xsl:otherwise>] </xsl:otherwise>
    </xsl:choose>-->
    <xsl:if test="not(following-sibling::*:documentation)"> ]</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:enumeration">
    <xsl:variable name="isString">
      <xsl:if test="contains(../@base, 'string') 
      || contains(lower-case(../@base), 'token')">
        <xsl:value-of select="true()"/>
      </xsl:if>
    </xsl:variable> 
    <!--<xsl:if test="not(preceding-sibling::*)">"enumeration": [ </xsl:if>-->
    <xsl:if test="not(preceding-sibling::*:enumeration)">"enumeration": [ </xsl:if>
    <xsl:text>{ "value": </xsl:text>
    <!--<xsl:if test="contains(../@base, 'string')">-->
    <xsl:if test="$isString">
      <xsl:text>"</xsl:text>
    </xsl:if>    
    <xsl:value-of select="./@value"/>
    <xsl:if test="$isString">
      <xsl:text>"</xsl:text>
    </xsl:if>
    <xsl:if test=" descendant::*">, </xsl:if>
    <xsl:apply-templates/>
    <xsl:text> } </xsl:text>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
      <xsl:otherwise> ] </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*:fractionDigits">
    <xsl:text>"fractionDigits": </xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:totalDigits">
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
    <!--<xsl:text>"pattern": "</xsl:text>-->
    <xsl:choose>
      <xsl:when test="not(preceding-sibling::*:pattern)">"pattern": [ </xsl:when>
      <xsl:otherwise>, </xsl:otherwise>
    </xsl:choose>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="fn:replace(fn:replace(normalize-space(./@value),'\\', '\\\\'), '&quot;', '\\&quot;')"/>
    <xsl:text>"</xsl:text>
    <xsl:if test="not(following-sibling::*:pattern)"> ]</xsl:if>
<!--    <xsl:choose>
      <xsl:when test="position()!=last()">, </xsl:when>
    </xsl:choose>-->
  </xsl:template>
  
  <xsl:template match="*:restriction">
    <xsl:if test="preceding-sibling::*:restriction">, </xsl:if>
    <!--<xsl:if test="preceding-sibling::*">, </xsl:if>-->
    <xsl:if test="@base">
      <xsl:text>"baseType": "</xsl:text>
      <xsl:value-of select="./@base"/>
      <xsl:text>"</xsl:text>
      <xsl:if test="descendant::*">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:apply-templates select="./*"/>
  </xsl:template>
  
  <xsl:template match="/*:schema/*:simpleType">
    <xsl:if test="preceding-sibling::*:simpleType">, </xsl:if>
    <!--<xsl:if test="preceding-sibling::*:simpleType | preceding-sibling::*:complexType | preceding-sibling::*:element">, </xsl:if>-->
    <xsl:text>"</xsl:text>
    <xsl:choose>
      <xsl:when test="./@name">
        <xsl:value-of select="./@name"/></xsl:when>
      <xsl:otherwise>anonymousType</xsl:otherwise>
    </xsl:choose>
    <xsl:text>": { "type": "simpleType"</xsl:text>
    <xsl:if test="*:annotation/*:documentation">, </xsl:if>
    <xsl:apply-templates select="./*:annotation/*:documentation"/>
    <xsl:text>, "facets": [ </xsl:text>
    <xsl:text> { </xsl:text>
    <xsl:apply-templates select="./*:restriction"/>
    <xsl:text> }</xsl:text>
    <xsl:text>] </xsl:text>
    <xsl:text>} </xsl:text>
  </xsl:template>
  
  <xsl:template match="*:simpleType">
    <xsl:if test="not(descendant::*:simpleType)"><xsl:text> { </xsl:text></xsl:if>
    <xsl:apply-templates/>
    <xsl:if test="not(descendant::*:simpleType)"><xsl:text> }</xsl:text></xsl:if>
    <xsl:if test="following-sibling::*">, </xsl:if>
  </xsl:template>

  <xsl:template match="*:complexType/*:attribute | *:element/*:attribute">
    <xsl:if test="preceding-sibling::*">, </xsl:if>
    <xsl:text>, "attributes": { </xsl:text>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="./@name"/>
    <xsl:text>": </xsl:text>
    <xsl:if test="*:annotation/*:documentation">
      <xsl:text>{ </xsl:text>
      <xsl:apply-templates select="./*:annotation/*:documentation"/>
      <xsl:text>}, </xsl:text>
    </xsl:if>
    <!--<xsl:text>": { "facets": [ </xsl:text>-->
    <xsl:text>{ "facets": [ </xsl:text>
    <xsl:apply-templates select="./*:simpleType"/>
    <xsl:text> ] </xsl:text>
    <xsl:text>} </xsl:text>
    <xsl:text>} </xsl:text>
  </xsl:template>
  
  <xsl:template match="*:complexType">
    <!--<xsl:if test="preceding-sibling::*">, </xsl:if>-->
    <!--<xsl:if test="preceding-sibling::*:simpleType | preceding-sibling::*:complexType | preceding-sibling::*:element">, </xsl:if>-->
    <xsl:if test="preceding-sibling::*:complexType">, </xsl:if>
    <xsl:text>"</xsl:text>
    <xsl:choose>
      <xsl:when test="./@name">
        <xsl:value-of select="concat(./@name,'.type')"/></xsl:when>
      <xsl:otherwise>anonymous.type</xsl:otherwise>
    </xsl:choose>
    <!--<xsl:text>": { "type": "complexType", "documentation": </xsl:text>
    <xsl:choose>
      <xsl:when test="*:annotation/*:documentation">
        <xsl:apply-templates select="./*:annotation/*:documentation"/></xsl:when>
      <xsl:otherwise>[] </xsl:otherwise>
    </xsl:choose>-->
    <xsl:text>": { "type": "complexType"</xsl:text>
    <xsl:if test="*:annotation/*:documentation">, </xsl:if>
    <xsl:apply-templates select="./*:annotation/*:documentation"/>
    <!-- 055+ -->
    <xsl:if test="./*:sequence/*:element | ./*:complexContent/*:extension/*:sequence/*:element">, </xsl:if>
    <!-- 055+ -->
    <xsl:apply-templates select="./*:sequence/*:element | ./*:complexContent/*:extension/*:sequence/*:element"/>
    <xsl:text>} </xsl:text>
  </xsl:template>
  
  <xsl:template match="*:element">
<!--    <xsl:if test="preceding-sibling::*">, </xsl:if>-->
<!--    <xsl:if test="preceding-sibling::*:simpleType | preceding-sibling::*:complexType | preceding-sibling::*:element">, </xsl:if>-->
    <xsl:if test="preceding-sibling::*:element">, </xsl:if>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="./@name"/>
    <xsl:text>": { "type": "element"</xsl:text>
    <xsl:if test="*:annotation/*:documentation">, </xsl:if>
    <xsl:apply-templates select="./*:annotation/*:documentation"/>
    <xsl:text>, "facets": [ </xsl:text>
    <xsl:apply-templates select="./*:simpleType"/>
    <xsl:text>] </xsl:text>
    <xsl:apply-templates select="./*:complexType/*:attribute"/>
    <xsl:text>} </xsl:text>
  </xsl:template>
  
  <xsl:template match="*:schema">
    <xsl:text>{ "@context": {
    "@id": "</xsl:text>
    <xsl:value-of select="document-uri(/)"/>
    <xsl:text>",
    "dateModified": {
      "@id": "http://schema.org/dateModified"
    },
    "code": {
      "@id": "http://schema.org/Code"
    }
  },
  "dateModified": "</xsl:text><xsl:value-of select="current-dateTime()"/>
    <xsl:text>", "code": {
    "name": "</xsl:text><xsl:value-of select="$xsltName"/>
    <xsl:text>", "version": "</xsl:text><xsl:value-of select="$xsltVersion"/>
    <xsl:text>" },  </xsl:text> 
    <xsl:text>"schemaUri": </xsl:text>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="//@targetNamespace"/>
    <xsl:text>"</xsl:text>
    <xsl:if test="*:annotation/*:documentation">, </xsl:if>
    <xsl:apply-templates select="*:annotation/*:documentation"/>
    <xsl:text>, "components": { </xsl:text>
    <xsl:apply-templates select="*:simpleType"/>
    <xsl:if test="*:simpleType and *:complexType">, </xsl:if>
    <xsl:apply-templates select="*:complexType"/>
    <xsl:if test="*:complexType and *:element">, </xsl:if>
    <xsl:apply-templates select="*:element"/>
    <xsl:text>} </xsl:text>
    <xsl:text>}</xsl:text>
  </xsl:template>

</xsl:stylesheet>