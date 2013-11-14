<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:saxon="http://saxon.sf.net/" xmlns:c="http://baxter-it.com/config/component"
    xmlns:broadcast="http://baxter-it.com/price-engine/conf/broadcast" exclude-result-prefixes="xs saxon c broadcast"
    version="2.0">

    <!-- Here are the namespaces to be used for references in configuration <c:param reference="..." /> -->
    <!-- broadcast : http://baxter-it.com/config/pe/broadcast -->

    <!-- Priorities of evaluation -->
    <!-- 1. if there is a nested 'param' element with @reference attribute, then evaluate it for result -->
    <!-- 2. If there is a nested 'param' element with @id = $name then use its @value as result -->
    <!-- 3. otherwise use attribute (with name specified as $name) value for result -->
    <xsl:template name="parameter">
        <xsl:param name="name" />
        <xsl:choose>
            <xsl:when test="c:param[@id=$name][@reference]">
                <xsl:value-of select="saxon:evaluate(c:param[@id=$name]/@reference)" />
            </xsl:when>
            <xsl:when test="c:param[@id=$name][@value]">
                <xsl:value-of select="c:param[@id=$name]/@value" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@*[name()=$name]" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
