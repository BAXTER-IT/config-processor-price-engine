<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:conf="http://baxter-it.com/config" xmlns:c="http://baxter-it.com/config/component"
    xmlns:re="http://baxter-it.com/price-engine/conf/re" xmlns="http://baxter-it.com/price-engine/conf/properties"
    exclude-result-prefixes="xs re c conf" version="2.0">

    <xsl:import href="baxterxsl:conf-reference.xsl" />

    <xsl:param name="configurationComponentId" />

    <!-- Renders the common Rate Engine settings -->
    <xsl:template name="rate-engine">
        <xsl:apply-templates select="/re:configuration[re:engine]" mode="rate-engines" />
        <xsl:apply-templates select="/re:configuration[re:observer]" mode="observers" />
    </xsl:template>

    <xsl:template match="re:configuration" mode="rate-engines">
        <group key="RateEngines">
            <xsl:apply-templates select="re:engine" />
        </group>
    </xsl:template>

    <xsl:template match="re:engine">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:value-of select="@name" />
        </entry>
    </xsl:template>

    <xsl:template match="re:observer/@pingTimeout" mode="observer-property">
        <entry key="ping_timeout">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="re:observer/@rcsTimeout" mode="observer-property">
        <entry key="remote_component_status_timeout">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="re:observer/@tpTimeout" mode="observer-property">
        <entry key="takeover_process_timeout">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="re:observer/@cssPeriod" mode="observer-property">
        <entry key="component_status_sending_period">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="re:observer/@cccPeriod" mode="observer-property">
        <entry key="component_connection_check_period">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="re:observer/@messageTTL" mode="observer-property">
        <entry key="message_ttl">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="re:component">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:value-of select="@name" />
        </entry>
    </xsl:template>

    <xsl:template match="re:host">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:value-of select="@name" />
        </entry>
    </xsl:template>

    <xsl:template match="re:param[conf:reference]">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:apply-templates select="conf:reference[1]" mode="url" />
        </entry>
    </xsl:template>

    <xsl:template match="re:param">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:value-of select="@value" />
        </entry>
    </xsl:template>

    <xsl:template match="re:observer">
        <group>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:apply-templates select="@*" mode="observer-property" />
            <xsl:if test="re:component">
                <group key="components">
                    <xsl:apply-templates select="re:component" />
                </group>
            </xsl:if>
            <xsl:if test="conf:reference">
                <group key="configs">
                    <xsl:for-each select="conf:reference">
                        <entry>
                            <xsl:attribute name="key">
                                <xsl:value-of select="@id" />
                            </xsl:attribute>
                            <xsl:apply-templates select="." mode="url" />
                        </entry>
                    </xsl:for-each>
                </group>
            </xsl:if>
            <xsl:if test="re:host">
                <group key="hosts">
                    <xsl:apply-templates select="re:host" />
                </group>
            </xsl:if>
            <xsl:apply-templates select="re:param" />
        </group>
    </xsl:template>

    <xsl:template match="re:configuration" mode="observers">
        <group key="observers">
            <xsl:apply-templates select="re:observer[@id='default']/@*" mode="observer-property" />
            <xsl:apply-templates select="re:observer[c:component[@id=$configurationComponentId]]" />
        </group>
    </xsl:template>

</xsl:stylesheet>
