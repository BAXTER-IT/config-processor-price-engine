<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:bcl="http://baxter-it.com/config/log"
    xmlns:c="http://baxter-it.com/config/component" xmlns:log4j="http://jakarta.apache.org/log4j/" xmlns:conf="http://baxter-it.com/config"
        xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs bcl c conf" version="2.0">

<xsl:import href="baxterxsl:log4j.xsl" />

<xsl:template match="bcl:threshold">
  <param name="Threshold">
    <xsl:attribute name="value">
      <xsl:value-of select="." />
    </xsl:attribute>
  </param>
</xsl:template>

</xsl:stylesheet>
