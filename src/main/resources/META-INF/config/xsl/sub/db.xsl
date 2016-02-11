<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:db="http://baxter-it.com/price-engine/conf/db"
	xmlns="http://baxter-it.com/price-engine/conf/properties"
	exclude-result-prefixes="xs db" version="2.0">

	<xsl:import href="./group-container.xsl" />

    <xsl:template match="db:connection" mode="entries-only">
        <xsl:param name="suffix" select="''" />
	<xsl:if test="@driver = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'">
	    <entry>
	    <xsl:attribute name="key">
	        <xsl:text>msSQL2005</xsl:text>
	        <xsl:value-of select="$suffix" />
	    </xsl:attribute>
	    <xsl:value-of select="@msSQL2005" />
	    </entry>
	</xsl:if>
	<entry>
            <xsl:attribute name="key">
                <xsl:text>dbDriver</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
			<xsl:value-of select="@driver" />
		</entry>
		<entry>
			<xsl:attribute name="key">
                <xsl:text>dbAddress</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
			<xsl:value-of select="@url" />
		</entry>

	    <entry>
                <xsl:attribute name="key">
                	<xsl:text>dbValidationQuery</xsl:text>
                        <xsl:value-of select="$suffix" />
                </xsl:attribute>
                <xsl:value-of select="@dbValidationQuery" />
            </entry>
	    <entry>
                <xsl:attribute name="key">
                	<xsl:text>dbValidationQueryInterval</xsl:text>
                        <xsl:value-of select="$suffix" />
                </xsl:attribute>
                <xsl:value-of select="@dbValidationQueryInterval" />
            </entry>

		<xsl:choose>
			<xsl:when test="@credentials">
				<entry>
					<xsl:attribute name="key">
                        <xsl:text>dbCredentials</xsl:text>
                        <xsl:value-of select="$suffix" />
                    </xsl:attribute>
					<xsl:value-of select="@credentials" />
				</entry>
			</xsl:when>
			<xsl:otherwise>
				<entry>
					<xsl:attribute name="key">
                        <xsl:text>password</xsl:text>
                        <xsl:value-of select="$suffix" />
                    </xsl:attribute>
					<xsl:value-of select="@password" />
				</entry>
				<entry>
					<xsl:attribute name="key">
                        <xsl:text>username</xsl:text>
                        <xsl:value-of select="$suffix" />
                    </xsl:attribute>
					<xsl:value-of select="@username" />
				</entry>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="db:connection">
		<xsl:param name="path" select="@id" />
		<xsl:choose>
			<xsl:when test="contains($path,'.')">
				<xsl:call-template name="in-container">
					<xsl:with-param name="path" select="$path" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<group>
					<xsl:attribute name="key">
                        <xsl:value-of select="$path" />
                    </xsl:attribute>
					<xsl:apply-templates select="." mode="entries-only" />
				</group>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
