<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cidt="http://baxter-it.com/config/component/id-template"
    xmlns:udpp="http://baxter-it.com/price-engine/conf/udp-price" xmlns:db="http://baxter-it.com/price-engine/conf/db"
    xmlns:gprop="http://baxter-it.com/price-engine/conf/generic-properties"
    xmlns="http://baxter-it.com/price-engine/conf/properties" xmlns:c="http://baxter-it.com/config/component"
    exclude-result-prefixes="xs cidt db udpp c" version="2.0">

    <xsl:import href="../udp-price.xsl" />
    <xsl:import href="../db.xsl" />

    <xsl:param name="configurationComponentId" />

    <xsl:template match="cidt:price-engine-blotterserver">
        <xsl:apply-templates select="/db:configuration/db:connection[@id='mmm.dbConnection']" />
        <group key="mmm">
            <group key="broadcastMMM">
                <xsl:apply-templates select="/udpp:configuration/udpp:connection[@id='mmm.broadcast.1']"
                    mode="connection-keys" />
                <xsl:apply-templates select="/udpp:configuration/udpp:connection[@id='mmm.broadcast.2']"
                    mode="connection-keys">
                    <xsl:with-param name="suffix">2</xsl:with-param>
                </xsl:apply-templates>
            </group>
        </group>
    </xsl:template>

    <xsl:template
        match="gprop:property[@id='ALGOEngineClassName'][$configurationComponentId='price-engine-blotterserver']">
        <group key="positionManager">
            <entry key="aLGOEngineClassName">
                <xsl:value-of select="@value" />
            </entry>
        </group>
    </xsl:template>

</xsl:stylesheet>
