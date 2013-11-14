<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs j c conf"
	xmlns:j="http://baxter-it.com/config/jvm" xmlns:c="http://baxter-it.com/config/component"
	xmlns:conf="http://baxter-it.com/config" version="2.0">

	<xsl:output method="xml" encoding="UTF-8" indent="yes"
		omit-xml-declaration="no" />

	<xsl:template match="/">
		<xsl:apply-templates
			select="conf:configuration-source/conf:sources/conf:source" />
	</xsl:template>
	
	<xsl:template match="conf:source">
	
	</xsl:template>

</xsl:stylesheet>