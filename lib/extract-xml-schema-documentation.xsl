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
  
  <xsl:template match="*:schema">
    <xsl:text>{ "schemaUri": "</xsl:text>
    <xsl:value-of select="//@targetNamespace"/>
    <xsl:text>", "documentation": [</xsl:text>
    <xsl:apply-templates select="*:annotation/*:documentation"/>
    <xsl:text>],</xsl:text>
    <xsl:text>"components": {</xsl:text>
    <xsl:if test="*:simpleType">
      <xsl:apply-templates select="*:simpleType"/>
      <xsl:text>, </xsl:text>
    </xsl:if>
    <xsl:if test="*:complexType">
      <xsl:apply-templates select="*:complexType"/>
    </xsl:if>
    <xsl:if test="*:element">
      <xsl:apply-templates select="*:element"/>
    </xsl:if>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match="*:documentation">
    <xsl:choose>
      <xsl:when test="preceding-sibling::*:documentation"/>
      <xsl:otherwise>[ </xsl:otherwise>
    </xsl:choose>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="fn:replace(fn:replace(normalize-space(.),'\\', '\\\\'), '&quot;', '\\&quot;')"/>
    <xsl:text>"</xsl:text>
    <xsl:choose>
      <xsl:when test="following-sibling::*:documentation">, </xsl:when>
      <xsl:otherwise>] </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*:simpleType">
    <xsl:if test="preceding-sibling::*:simpleType">,</xsl:if>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="./@name"/>
    <xsl:text>": { "type": "simpleType", "documentation": </xsl:text>
    <xsl:choose>
      <xsl:when test="*:annotation/*:documentation">
        <xsl:apply-templates select="./*:annotation/*:documentation"/></xsl:when>
      <xsl:otherwise>[] </xsl:otherwise>
    </xsl:choose>
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
    <xsl:text>": { "type": "element", "documentation": </xsl:text>
    <xsl:choose>
      <xsl:when test="*:annotation/*:documentation">
        <xsl:apply-templates select="./*:annotation/*:documentation"/></xsl:when>
      <xsl:otherwise>[] </xsl:otherwise>
    </xsl:choose>
    <xsl:text>} </xsl:text>
  </xsl:template>

</xsl:stylesheet>
