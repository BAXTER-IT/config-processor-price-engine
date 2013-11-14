<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cidt="http://baxter-it.com/config/component/id-template" xmlns:broadcast="http://baxter-it.com/price-engine/conf/broadcast"
    xmlns:c="http://baxter-it.com/config/component" xmlns="http://baxter-it.com/price-engine/conf/properties"
    xmlns:conf="http://baxter-it.com/config" exclude-result-prefixes="xs cidt c conf broadcast" version="2.0">

    <xsl:import href="baxterxsl:conf-reference.xsl" />

    <xsl:template match="cidt:price-engine-broadcast">
    	<xsl:if test="/conf:reference[@id='stpConfigFileName']">
            <entry key="stpConfigFileName">
                <xsl:apply-templates select="/conf:reference[@id='stpConfigFileName']" mode="url" />
            </entry>
        </xsl:if>
        <xsl:apply-templates select="/broadcast:configuration/broadcast:node[@id=../broadcast:server[@id='default']/@node]" mode="node-index" />
        <xsl:apply-templates select="/broadcast:configuration/broadcast:node[@id=../broadcast:server[@id='default']/@node]" mode="udp-ports" />
    </xsl:template>
    
    <xsl:template match="broadcast:node" mode="node-index">
        <entry key="broadcastNode">
            <xsl:value-of select="count(preceding::broadcast:node)" />
        </entry>
    </xsl:template>

    <xsl:template match="broadcast:node" mode="udp-ports">
        <entry key="udpPort">
            <xsl:value-of select="@pricePort" />
        </entry>
        <entry key="uDPClientConnectionPort">
            <xsl:value-of select="@channelPort" />
        </entry>
    </xsl:template>

</xsl:stylesheet>
