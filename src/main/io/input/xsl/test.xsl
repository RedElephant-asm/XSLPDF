<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
    <xsl:template match="document">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simpleA4" page-height="29.7cm" page-width="21cm" margin-top="2cm" margin-bottom="2cm" margin-left="2cm" margin-right="2cm">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="simpleA4">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="page"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="page">
        <xsl:apply-templates select="article"/>
        <xsl:apply-templates select="filling-form"/>
        <xsl:apply-templates select="header"/>
    </xsl:template>

    <xsl:template match="article">
        <fo:block font-size="12pt" font-weight="bold" space-after="5mm">Text : <xsl:value-of select="text"/></fo:block>
    </xsl:template>

    <xsl:template match="filling-form">
        <xsl:apply-templates select="field"/>
    </xsl:template>

    <xsl:template match="field">
        <fo:block font-size="12pt" font-weight="bold" space-after="5mm" align="left"><xsl:value-of select="text"/></fo:block>
    </xsl:template>

    <xsl:template match="header">
        <xsl:template match="header-line">
            <fo:block font-size="12pt" font-weight="bold" space-after="5mm"><xsl:value-of select="text"/></fo:block>
        </xsl:template>

    </xsl:template>

</xsl:stylesheet>