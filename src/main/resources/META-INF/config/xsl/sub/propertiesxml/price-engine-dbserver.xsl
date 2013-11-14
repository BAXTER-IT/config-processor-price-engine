<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cidt="http://baxter-it.com/config/component/id-template"
    xmlns:jaas="http://baxter-it.com/price-engine/conf/jaas"
    xmlns:c="http://baxter-it.com/config/component"
    xmlns:db="http://baxter-it.com/price-engine/conf/db" xmlns="http://baxter-it.com/price-engine/conf/properties"
    exclude-result-prefixes="xs cidt db jaas c" version="2.0">

    <xsl:import href="../db.xsl" />
    
    <xsl:param name="configurationComponentId" />

    <xsl:template match="cidt:price-engine-dbserver">
        <group key="dbConnection">
            <xsl:apply-templates select="/db:configuration/db:connection[@id='dbConnection']" mode="entries-only" />
            <xsl:apply-templates select="/db:configuration/db:connection[@id='dbConnection2']" mode="entries-only">
                <xsl:with-param name="suffix">2</xsl:with-param>
            </xsl:apply-templates>
        </group>
        <xsl:apply-templates select="/jaas:configuration/jaas:authenticator[c:component[@id=$configurationComponentId]]" mode="ldap-connection"/>
    </xsl:template>

    <xsl:template match="jaas:ace" mode="ldap-connection">
        <group>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:apply-templates select="@*[name()!='id']" mode="ldap-connection"/>
        </group>
    </xsl:template>

    <xsl:template match="jaas:authenticator" mode="ldap-connection">
        <group>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <entry key="loginModule">
                <xsl:value-of select="@class" />
            </entry>
            <entry key="controlFlag">
                <xsl:value-of select="@controlFlag" />
            </entry>
            <xsl:apply-templates select="jaas:ace" mode="ldap-connection"/>
        </group>
    </xsl:template>

    <xsl:template match="jaas:ace/@*" mode="ldap-connection">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="name()" />
            </xsl:attribute>
            <xsl:value-of select="." />
        </entry>
    </xsl:template>
    
</xsl:stylesheet>
