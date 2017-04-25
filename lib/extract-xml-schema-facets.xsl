<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:oxd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:output indent="yes" method="text"/>
  
  <oxd:doc scope="stylesheet">
    <oxd:desc>
      <oxd:p><oxd:b>name: </oxd:b>extract-xml-schema-facets</oxd:p>
      <oxd:p><oxd:b>version: </oxd:b>0.1.0</oxd:p>
      <oxd:p><oxd:b>description: </oxd:b>Extract xml schema facets and output as a JSON structure.</oxd:p>
      <oxd:p><oxd:b>main: </oxd:b>extract-xml-schema-facets.xsl</oxd:p>
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
  
  <xsl:template match="*:schema">
    <xsl:text>{ "schemaUri": "</xsl:text>
    <xsl:value-of select="//@targetNamespace"/>
    <xsl:text>", "documentations": [</xsl:text>
    <xsl:apply-templates select="*:annotation/*:documentation"/>
    <xsl:text>],</xsl:text>
    <xsl:text>"components": [</xsl:text>
    <xsl:apply-templates select="*:simpleType"/>
    <xsl:text>]}</xsl:text>
  </xsl:template>
 
  <xsl:template match="*:simpleType">
    <xsl:text>{ "name": "</xsl:text>
    <xsl:value-of select="./@name"/>
    <xsl:text>", "type": "simpleType", "documentations": [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
    <xsl:if test="following-sibling::*:simpleType">,</xsl:if>
  </xsl:template>
  
<!--  <xsl:template match="*:simpleType/*:annotation/*:documentation">
    <xsl:text>{"documentation": "</xsl:text>
    <xsl:value-of select="normalize-space(.)" />
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>-->
  
  <xsl:template match="*:documentation">
    <xsl:text>{"documentation": "</xsl:text>
    <xsl:value-of select="normalize-space(.)" />
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
<!--  <xsl:template match="*:element">
    <xsl:text>{ "name": "</xsl:text>
    <xsl:value-of select="./@name"/>
    <xsl:text>", "type": "element", "documentations": [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>--> 
  
  <xsl:template match="*:restriction">
    <xsl:text>], "restrictions": [ </xsl:text>
    <!--<xsl:value-of select="./@base"/>-->
    <!--<xsl:text>", "enumerations": [</xsl:text>-->
    <xsl:apply-templates/>
    <xsl:text>]</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>

  <xsl:template match="*:assertion">
    <xsl:text>{ "restriction": "assertion", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:text>", "documentations": [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:enumeration">
    <xsl:text>{ "restriction": "enumeration", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:text>", "documentations": [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:length">
    <xsl:text>{ "restriction": "length", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <!--<xsl:text>", "documentations": [</xsl:text>-->
    <!--<xsl:apply-templates/>-->
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:maxExclusive">
    <xsl:text>{ "restriction": "maxExclusive", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <!--<xsl:text>", "documentations": [</xsl:text>-->
    <!--<xsl:apply-templates/>-->
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:minExclusive">
    <xsl:text>{ "restriction": "minExclusive", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <!--<xsl:text>", "documentations": [</xsl:text>-->
    <!--<xsl:apply-templates/>-->
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:maxInclusive">
    <xsl:text>{ "restriction": "maxInclusive", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <!--<xsl:text>", "documentations": [</xsl:text>-->
    <!--<xsl:apply-templates/>-->
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:minInclusive">
    <xsl:text>{ "restriction": "minInclusive", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <!--<xsl:text>", "documentations": [</xsl:text>-->
    <!--<xsl:apply-templates/>-->
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:maxLength">
    <xsl:text>{ "restriction": "maxLength", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <!--<xsl:text>", "documentations": [</xsl:text>-->
    <!--<xsl:apply-templates/>-->
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:minLength">
    <xsl:text>{ "restriction": "minLength", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <!--<xsl:text>", "documentations": [</xsl:text>-->
    <!--<xsl:apply-templates/>-->
    <xsl:text>"}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:pattern">
    <xsl:text>{ "restriction": "pattern", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:text>", "documentations": [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:fractionDigits">
    <xsl:text>{ "restriction": "fractionDigits", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:text>", "documentations": [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>

  <xsl:template match="*:totalDigits">
    <xsl:text>{ "restriction": "totalDigits", "value": "</xsl:text>
    <xsl:value-of select="./@value"/>
    <xsl:text>", "documentations": [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
</xsl:stylesheet>