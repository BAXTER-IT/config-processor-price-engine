<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cidt="http://baxter-it.com/config/component/id-template"
    xmlns:servlet="http://baxter-it.com/price-engine/conf/servlet"
    xmlns="http://baxter-it.com/price-engine/conf/properties"
    xmlns:curr="http://baxter-it.com/price-engine/conf/currencies" xmlns:c="http://baxter-it.com/config/component"
    exclude-result-prefixes="xs cidt servlet curr c" version="2.0">

    <xsl:param name="configurationComponentId" />

    <xsl:template match="cidt:trading-tool">
        <xsl:apply-templates select="/servlet:configuration/servlet:servlet[@id='servlet1']" />
        <xsl:apply-templates select="/servlet:configuration/servlet:servlet[@id='servlet2']">
            <xsl:with-param name="suffix">2</xsl:with-param>
        </xsl:apply-templates>
        <xsl:if test="/curr:configuration/curr:currencyPair6[c:component[@id=$configurationComponentId]]">
            <group key="userData">
                <entry key="cps">
                    <xsl:apply-templates mode="userData"
                        select="/curr:configuration/curr:currencyPair6[c:component[@id=$configurationComponentId]]" />
                </entry>
            </group>
        </xsl:if>
    </xsl:template>

    <xsl:template match="servlet:servlet">
        <xsl:param name="suffix" select="''" />
        <entry>
            <xsl:attribute name="key">
                <xsl:text>ServletUrl</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
            <xsl:value-of select="@url" />
        </entry>
    </xsl:template>

    <xsl:template match="curr:currencyPair6" mode="userData">
        <xsl:value-of select="@id" />
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
