<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cidt="http://baxter-it.com/config/component/id-template"
    xmlns="http://baxter-it.com/price-engine/conf/properties"
    exclude-result-prefixes="xs cidt" version="2.0">

    <xsl:import href="./propertiesxml/price-engine-admintool.xsl" />
    <xsl:import href="./propertiesxml/price-engine-dbserver.xsl" />
    <xsl:import href="./propertiesxml/price-engine-broadcast.xsl" />
    <xsl:import href="./propertiesxml/price-engine-blotterserver.xsl" />
    <xsl:import href="./propertiesxml/price-engine-blotter.xsl" />
    <xsl:import href="./propertiesxml/trading-tool.xsl" />
    <xsl:import href="./propertiesxml/price-engine-fwdmonitor.xsl" />
    <xsl:import href="./propertiesxml/price-engine-trackwheel.xsl" />
    <xsl:import href="./propertiesxml/price-engine-validator.xsl" />
    
</xsl:stylesheet>
