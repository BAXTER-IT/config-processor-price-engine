<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cidt="http://baxter-it.com/config/component/id-template"
    xmlns:c="http://baxter-it.com/config/component"
    xmlns:curr="http://baxter-it.com/price-engine/conf/currencies" 
    xmlns:udpp="http://baxter-it.com/price-engine/conf/udp-price"
    xmlns="http://baxter-it.com/price-engine/conf/properties"
    exclude-result-prefixes="xs cidt curr c" version="2.0">

    <xsl:import href="../udp-price.xsl" />

    <xsl:param name="configurationComponentId" />

    <xsl:template match="cidt:price-engine-validator">
	<xsl:apply-templates select="/udpp:configuration" />
    </xsl:template>

</xsl:stylesheet>
