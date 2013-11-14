<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cidt="http://baxter-it.com/config/component/id-template"
    xmlns="http://baxter-it.com/price-engine/conf/properties"
    xmlns:curr="http://baxter-it.com/price-engine/conf/currencies"
    xmlns:gui="http://baxter-it.com/price-engine/conf/gui" xmlns:c="http://baxter-it.com/config/component"
    exclude-result-prefixes="xs cidt curr c gui" version="2.0">

    <xsl:param name="configurationComponentId" />

    <xsl:template match="cidt:price-engine-trackwheel">
        <xsl:apply-templates select="/curr:configuration" mode="TW-UDBPorts" />
        <group key="colors">
            <xsl:apply-templates select="/gui:configuration/gui:color[c:component[@id=$configurationComponentId]]" />
        </group>
    </xsl:template>

    <xsl:template match="gui:flag[@id='twFifty'][@value='false']">
        <entry key="type">nontable</entry>
    </xsl:template>

    <xsl:template match="gui:flag[@id='twFifty'][@value='true']">
        <entry key="type">table</entry>
    </xsl:template>

    <xsl:template match="gui:color">
        <group>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <entry key="red">
                <xsl:value-of select="@red" />
            </entry>
            <entry key="green">
                <xsl:value-of select="@green" />
            </entry>
            <entry key="blue">
                <xsl:value-of select="@blue" />
            </entry>
        </group>
    </xsl:template>

    <xsl:template match="curr:configuration" mode="TW-UDBPorts">
        <group key="uDBPort">
            <xsl:apply-templates select="curr:currencyPair/c:component[@id=$configurationComponentId]/curr:port"
                mode="TW-UDBPorts" />
        </group>
    </xsl:template>

    <xsl:template match="curr:port" mode="TW-UDBPorts">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="../../@id" />
            </xsl:attribute>
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

</xsl:stylesheet>
