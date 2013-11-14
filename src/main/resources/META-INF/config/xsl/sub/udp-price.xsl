<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:udpp="http://baxter-it.com/price-engine/conf/udp-price" xmlns:c="http://baxter-it.com/config/component"
    xmlns:broadcast="http://baxter-it.com/price-engine/conf/broadcast" exclude-result-prefixes="xs udpp c broadcast"
    xmlns="http://baxter-it.com/price-engine/conf/properties" version="2.0">

    <xsl:import href="baxterxsl:repo-base.xsl" />
    <xsl:import href="./group-container.xsl" />
    <xsl:import href="./params.xsl" />

    <xsl:param name="configurationComponentId" />

    <xsl:template match="udpp:configuration">
        <xsl:apply-templates select="udpp:connection[c:component[@id=$configurationComponentId]]" />
    </xsl:template>

    <xsl:template match="udpp:connection" mode="connection-keys">
        <xsl:param name="suffix" select="@case" />
        <entry>
            <xsl:attribute name="key">
                <xsl:text>ClientPort</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
            <xsl:call-template name="parameter">
                <xsl:with-param name="name">port</xsl:with-param>
            </xsl:call-template>
        </entry>
        <xsl:apply-templates select="udpp:server">
            <xsl:with-param name="suffix" select="$suffix" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="udpp:connection">
        <xsl:param name="path" select="@id" />
        <xsl:choose>
            <xsl:when test="contains($path,'.')">
                <xsl:call-template name="in-container">
                    <xsl:with-param name="path" select="$path" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <group>
                    <xsl:attribute name="key">
                        <xsl:value-of select="$path" />
                    </xsl:attribute>
                    <xsl:apply-templates select="." mode="connection-keys" />
                </group>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="udpp:server[@broadcastId][@broadcastMode='price']" mode="broadcast-port">
        <xsl:value-of select="/broadcast:configuration/broadcast:node[@id=current()/@broadcastId]/@pricePort" />
    </xsl:template>

    <xsl:template match="udpp:server[@broadcastId][@broadcastMode='channel' or not(exists(@broadcastMode))]" mode="broadcast-port">
        <xsl:value-of select="/broadcast:configuration/broadcast:node[@id=current()/@broadcastId]/@channelPort" />
    </xsl:template>
    
    <xsl:template match="udpp:server[@broadcastId]">
        <xsl:param name="suffix" select="../@case" />
        <entry>
            <xsl:attribute name="key">
                <xsl:text>ServerHost</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
            <xsl:value-of select="/broadcast:configuration/broadcast:node[@id=current()/@broadcastId]/@host" />
        </entry>
        <entry>
            <xsl:attribute name="key">
                <xsl:text>ServerPort</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
            <xsl:apply-templates select="." mode="broadcast-port" />
        </entry>
    </xsl:template>

    <xsl:template match="udpp:server">
        <xsl:param name="suffix" select="../@case" />
        <entry>
            <xsl:attribute name="key">
                <xsl:text>ServerHost</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
            <xsl:call-template name="parameter">
                <xsl:with-param name="name">host</xsl:with-param>
            </xsl:call-template>
        </entry>
        <entry>
            <xsl:attribute name="key">
                <xsl:text>ServerPort</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
            <xsl:call-template name="parameter">
                <xsl:with-param name="name">port</xsl:with-param>
            </xsl:call-template>
        </entry>
    </xsl:template>

</xsl:stylesheet>
