<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:l="http://baxter-it.com/config/log"
    exclude-result-prefixes="xs l"
    version="2.0">
    
    <xsl:output method="xml" indent="yes" />
    
    <xsl:template match="/">
        <xsl:for-each select="l:configuration/l:*">
            <xsl:if test="count(../l:*[local-name()=local-name(current())][@id=current()/@id]) != 1">
                <xsl:copy>
                    <xsl:value-of select="@id" />
                </xsl:copy>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>