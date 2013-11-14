<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:curr="http://baxter-it.com/price-engine/conf/currencies"
    xmlns:c="http://baxter-it.com/config/component" xmlns:conf="http://baxter-it.com/config"
    exclude-result-prefixes="xs curr c conf" version="2.0">

    <xsl:import href="baxterxsl:repo-base.xsl"/>
    <xsl:import href="baxterxsl:text-fmt.xsl"/>

    <xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:param name="configurationComponentId"/>

    <xsl:template match="/">
        <xsl:variable name="root">
            <xsl:copy-of select="conf:configuration-source/conf:request"/>
            <xsl:apply-templates select="conf:configuration-source/conf:request"
                mode="load-document-with-variants">
                <xsl:with-param name="prefix" select="'currencies'"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:apply-templates
            select="$root/curr:configuration/curr:*/c:component[@id=$configurationComponentId]/curr:port[@id='default']"
        />
    </xsl:template>

    <xsl:template match="curr:port">
        <xsl:value-of select="../../@id"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="."/>
        <xsl:if test="$configurationComponentId = 'price-engine-twserver'">
            <xsl:text> </xsl:text>
            <xsl:value-of select="../curr:port[@id = 'logServer']/."/>
        </xsl:if>
        <xsl:if test="$configurationComponentId = 'price-engine-vdtws'">
            <xsl:text> </xsl:text>
            <xsl:value-of select="../curr:port[@id = 'logServer']/."/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="../curr:epp[@id = 'enabled']/."/>
        </xsl:if>
        <xsl:if test="position() != last()">
            <xsl:call-template name="CRLF"/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
