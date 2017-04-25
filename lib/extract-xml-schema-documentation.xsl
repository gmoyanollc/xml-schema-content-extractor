<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:oxd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:output indent="yes" method="text"/>
  
  <oxd:doc scope="stylesheet">
    <oxd:desc>
      <oxd:p><oxd:b>name: </oxd:b>extract-xml-schema-documentation</oxd:p>
      <oxd:p><oxd:b>version: </oxd:b>0.1.1</oxd:p>
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
  
  <xsl:template match="*:schema">
    <xsl:text>{ "schemaUri": "</xsl:text>
    <xsl:value-of select="//@targetNamespace"/>
    <!--<xsl:text>", "documentations": [</xsl:text>-->
    <xsl:text>", "documentation": [</xsl:text>
    <xsl:apply-templates select="*:annotation/*:documentation"/>
    <xsl:text>],</xsl:text>
    <!--<xsl:text>"components": [</xsl:text>-->
    <xsl:text>"components": {</xsl:text>
    <xsl:apply-templates select="*:element"/>
    <xsl:text>,</xsl:text>
    <xsl:apply-templates select="*:complexType"/>
    <!--<xsl:text>]}</xsl:text>-->
    <xsl:text>}}</xsl:text>
    </xsl:template>

  <xsl:template match="*:documentation">
    <!--<xsl:text>{"documentation": "</xsl:text>-->
    <xsl:text>"</xsl:text>
    <xsl:value-of select="normalize-space(.)" />
    <xsl:text>"</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:element">
    <!--<xsl:text>{ "name": "</xsl:text>-->
    <xsl:text>"</xsl:text>
    <xsl:value-of select="./@name"/>
    <!--<xsl:text>", "type": "element", "documentations": [</xsl:text>-->
    <xsl:text>": { "type": "element", "documentation": [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]}</xsl:text>
    <xsl:if test="following-sibling::*">,</xsl:if>
  </xsl:template>
  
  <xsl:template match="*:complexType">
    <!--<xsl:text>{ "name": "</xsl:text>-->
    <xsl:text>"</xsl:text>
    <xsl:value-of select="./@name"/>
    <!--<xsl:text>", "type": "complexType", "documentations": [</xsl:text>-->
    <xsl:text>": { "type": "complexType", "documentation": [</xsl:text>
    <xsl:apply-templates select="./*:annotation/*:documentation"/>
    <xsl:text>]}</xsl:text>
    <xsl:if test="following-sibling::*:complexType">,</xsl:if>
  </xsl:template>

</xsl:stylesheet>