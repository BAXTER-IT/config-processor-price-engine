<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://baxter-it.com/config/pe/properties"
    exclude-result-prefixes="xs p" version="2.0" xmlns:p="http://baxter-it.com/config/pe/properties">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="p:properties"/>
    </xsl:template>

    <xsl:template name="merge-container">
        <xsl:copy-of select="@*"/>
        <xsl:copy-of select="p:entry"/>
        <xsl:call-template name="merge-groups"/>
    </xsl:template>

    <xsl:template match="p:properties">
        <properties>
            <xsl:call-template name="merge-container"/>
        </properties>
    </xsl:template>

    <xsl:template match="p:container">
        <group>
            <xsl:call-template name="merge-container"/>
        </group>
    </xsl:template>

    <xsl:template name="merge-groups">
        <xsl:variable name="context" select="."/>
        <xsl:variable name="keys">
            <xsl:for-each select="p:group">
                <xsl:sort select="@key"/>
                <key>
                    <xsl:attribute name="id" select="@key"/>
                </key>
            </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$keys/p:key">
            <xsl:if test="(preceding-sibling::*[position()=1]/@id != current()/@id) or position()=1">
                <xsl:variable name="container">
                    <container>
                        <xsl:attribute name="key" select="@id"/>
                        <xsl:copy-of select="$context/p:group[@key=current()/@id]/p:group"/>
                        <xsl:copy-of select="$context/p:group[@key=current()/@id]/p:entry"/>
                    </container>
                </xsl:variable>
                <xsl:apply-templates select="$container/p:container"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>
