<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://baxter-it.com/price-engine/conf/properties" exclude-result-prefixes="xs" version="2.0">

    <xsl:template name="in-container">
        <xsl:param name="path" />
        <group>
            <xsl:attribute name="key">
                <xsl:value-of select="substring-before($path,'.')" />
            </xsl:attribute>
            <xsl:apply-templates select="." mode="#current">
                <xsl:with-param name="path" select="substring-after($path,'.')" />
            </xsl:apply-templates>
        </group>
    </xsl:template>

</xsl:stylesheet>
