<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cidt="http://baxter-it.com/config/component/id-template"
    xmlns:c="http://baxter-it.com/config/component"
    xmlns:curr="http://baxter-it.com/price-engine/conf/currencies" 
    xmlns="http://baxter-it.com/price-engine/conf/properties"
    exclude-result-prefixes="xs cidt curr c" version="2.0">

    <xsl:param name="configurationComponentId"/>

    <xsl:template match="cidt:price-engine-fwdmonitor">
        <xsl:apply-templates
            select="/curr:configuration[curr:*[c:component[@id=$configurationComponentId][curr:port]]]"
            mode="fwdmonitor-udp-ports"/>
    </xsl:template>
    
    <xsl:template match="curr:configuration" mode="fwdmonitor-udp-ports">
        <group key="uDPPortForMon">
            <xsl:apply-templates select="curr:*/c:component[@id=$configurationComponentId]/curr:port"
                mode="fwdmonitor-udp-ports"/>
        </group>
    </xsl:template>

    <xsl:template match="curr:port" mode="fwdmonitor-udp-ports">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="../../@id"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </entry>
    </xsl:template>

</xsl:stylesheet>
