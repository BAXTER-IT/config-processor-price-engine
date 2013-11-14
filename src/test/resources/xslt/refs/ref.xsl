<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:saxon="http://saxon.sf.net/" 
    xmlns:i1="http://my.input1"
    xmlns:i2="http://my.input2"
    exclude-result-prefixes="xs saxon" version="2.0">

    <xsl:output method="xml" indent="yes" />

    <xsl:template match="/">
        <xsl:variable name="root">
            <xsl:copy-of select="doc('input1.xml')/i1:input1" />
            <xsl:copy-of select="doc('input2.xml')/i2:input2" />
        </xsl:variable>
        <output>
            <xsl:apply-templates select="$root/i2:input2/i2:ref" />
        </output>
    </xsl:template>

    <xsl:template match="i2:ref">
        <result>
            <xsl:attribute name="from">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:value-of select="saxon:evaluate(i2:reference/@xpath)" />
        </result>
    </xsl:template>

</xsl:stylesheet>
