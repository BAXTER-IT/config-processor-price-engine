<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cidt="http://baxter-it.com/config/component/id-template"
    xmlns:snmp="http://baxter-it.com/price-engine/conf/snmp"
    xmlns:udpp="http://baxter-it.com/price-engine/conf/udp-price"
    xmlns:c="http://baxter-it.com/config/component"
    xmlns="http://baxter-it.com/price-engine/conf/properties" exclude-result-prefixes="xs c cidt snmp udpp"
    version="2.0">

    <xsl:import href="../udp-price.xsl" />

    <xsl:param name="configurationComponentId" />

    <xsl:template match="cidt:price-engine-admintool">
        <xsl:apply-templates select="/snmp:configuration/snmp:snmp[c:component[@id=$configurationComponentId]]" />
        <xsl:apply-templates select="/udpp:configuration" />
    </xsl:template>

    <xsl:template match="snmp:ip">
        <xsl:text>"</xsl:text>
        <xsl:apply-templates />
        <xsl:text>"</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="snmp:snmp">
        <group key="snmp">
            <entry key="StorageWarningLevel">
                <xsl:value-of select="@storageWarningLevel" />
            </entry>
            <entry key="Interval">
                <xsl:value-of select="@interval" />
            </entry>
            <entry key="IPsComponents">
                <xsl:apply-templates select="snmp:components/snmp:ip" />
            </entry>
            <entry key="IPsHardwares">
                <xsl:apply-templates select="snmp:hardwares/snmp:ip" />
            </entry>
        </group>
    </xsl:template>

</xsl:stylesheet>
