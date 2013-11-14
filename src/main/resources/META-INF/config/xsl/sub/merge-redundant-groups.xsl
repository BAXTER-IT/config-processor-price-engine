<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://baxter-it.com/price-engine/conf/properties" exclude-result-prefixes="xs p" version="2.0"
    xmlns:p="http://baxter-it.com/price-engine/conf/properties">

    <xsl:template name="merge-container">
        <xsl:copy-of select="@*" />
        <xsl:for-each-group select="p:entry" group-by="@key">
            <xsl:sort select="current-grouping-key()" />
            <xsl:copy-of select="current-group()[1]" />
        </xsl:for-each-group>
        <xsl:call-template name="merge-groups" />
    </xsl:template>

    <xsl:template match="p:properties">
        <properties>
            <xsl:call-template name="merge-container" />
            <xsl:copy-of select="p:import" />
        </properties>
    </xsl:template>

    <xsl:template match="p:container">
        <group>
            <xsl:call-template name="merge-container" />
        </group>
    </xsl:template>

    <xsl:template name="merge-groups">
        <xsl:variable name="context" select="." />
        <xsl:variable name="keys">
            <xsl:for-each select="p:group">
                <xsl:sort select="@key" />
                <key>
                    <xsl:attribute name="id" select="@key" />
                </key>
            </xsl:for-each>
        </xsl:variable>
        <xsl:for-each-group select="$keys/p:key" group-by="@id">
            <xsl:variable name="container">
                <container>
                    <xsl:attribute name="key" select="current-group()[1]/@id" />
                    <xsl:copy-of select="$context/p:group[@key=current-group()[1]/@id]/p:group" />
                    <xsl:copy-of select="$context/p:group[@key=current-group()[1]/@id]/p:entry" />
                </container>
            </xsl:variable>
            <xsl:apply-templates select="$container/p:container" />
        </xsl:for-each-group>
    </xsl:template>

</xsl:stylesheet>
