<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:apps="http://baxter-it.com/price-engine/conf/applications"
    xmlns:gui="http://baxter-it.com/price-engine/conf/gui" xmlns:c="http://baxter-it.com/config/component"
    xmlns:genp="http://baxter-it.com/price-engine/conf/generic-properties"
    xmlns:conf="http://baxter-it.com/config"
    xmlns="http://baxter-it.com/price-engine/conf/properties" exclude-result-prefixes="xs apps gui genp conf" version="2.0">

    <xsl:import href="./group-container.xsl" />
    <xsl:import href="baxterxsl:conf-reference.xsl" />

    <xsl:param name="configurationComponentId" />

    <!-- Renders the common settings for applciations -->
    <xsl:template name="apps-common-settings">
        <xsl:apply-templates
            select="/apps:configuration/c:component[@id=$configurationComponentId]/apps:port[@id='uniqueApp']"
            mode="unique-app-port" />
        <xsl:apply-templates
            select="/genp:configuration/genp:property[c:component[@id=$configurationComponentId]]" />
        <xsl:apply-templates
            select="/genp:configuration/conf:reference[c:component[@id=$configurationComponentId]]" />
    </xsl:template>

    <!-- Renders the GUI applciation config -->
    <xsl:template name="apps-common-gui-settings">
        <xsl:apply-templates select="/gui:configuration/gui:window[c:component[@id=$configurationComponentId]]"
            mode="writeable-import" />
        <xsl:apply-templates select="/gui:configuration/gui:window[c:component[@id=$configurationComponentId]]"
            mode="bounds" />
        <xsl:apply-templates select="/gui:configuration/gui:flag[c:component[@id=$configurationComponentId]]" />
    </xsl:template>
    
    <xsl:template match="genp:configuration/conf:reference">
        <xsl:param name="path" select="@id" />
        <xsl:choose>
            <xsl:when test="contains($path,'.')">
                <xsl:call-template name="in-container">
                    <xsl:with-param name="path" select="$path" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <entry>
                    <xsl:attribute name="key">
                        <xsl:value-of select="$path" />
                    </xsl:attribute>
                    <xsl:apply-templates select="." mode="url" />
                </entry>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="genp:property">
        <xsl:param name="path" select="@id" />
        <xsl:choose>
            <xsl:when test="contains($path,'.')">
                <xsl:call-template name="in-container">
                    <xsl:with-param name="path" select="$path" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <entry>
                    <xsl:attribute name="key">
                        <xsl:value-of select="$path" />
                    </xsl:attribute>
                    <xsl:value-of select="@value" />
                </entry>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="gui:flag">
        <xsl:param name="path" select="@id" />
        <xsl:choose>
            <xsl:when test="contains($path,'.')">
                <xsl:call-template name="in-container">
                    <xsl:with-param name="path" select="$path" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <entry>
                    <xsl:attribute name="key">
                        <xsl:value-of select="$path" />
                    </xsl:attribute>
                    <xsl:value-of select="@value" />
                </entry>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="apps:port" mode="unique-app-port">
        <entry key="applicationUniquePort">
            <xsl:apply-templates />
        </entry>
    </xsl:template>

    <xsl:template match="gui:window" mode="writeable-import">
        <import writeable="true">
            <xsl:attribute name="resource">
                <xsl:text>./conf/</xsl:text>
                <xsl:value-of select="$configurationComponentId" />
                <xsl:if test="/conf:request/conf:variant">
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="/conf:request/conf:variant/@id" separator="," />
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:text>_local.xml</xsl:text>
            </xsl:attribute>
        </import>
    </xsl:template>

    <xsl:template match="gui:window" mode="bounds">
        <group key="bounds">
            <entry key="X">
                <xsl:value-of select="@left" />
            </entry>
            <entry key="Y">
                <xsl:value-of select="@top" />
            </entry>
            <entry key="W">
                <xsl:value-of select="@width" />
            </entry>
            <entry key="H">
                <xsl:value-of select="@height" />
            </entry>
        </group>
    </xsl:template>

</xsl:stylesheet>
