<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sc="http://baxter-it.com/config/source-catalogue" xmlns:c="http://baxter-it.com/config/component"
    xmlns:cidt="http://baxter-it.com/config/component/id-template" xmlns:conf="http://baxter-it.com/config"
    xmlns="http://baxter-it.com/price-engine/conf/properties" exclude-result-prefixes="xs sc c cidt conf" version="2.0">

    <xsl:import href="baxterxsl:repo-base.xsl" />
    <xsl:import href="./sub/applications-common.xsl" />
    <xsl:import href="./sub/jms-common.xsl" />
    <xsl:import href="./sub/merge-redundant-groups.xsl" />
    <xsl:import href="./sub/propertiesxml-aggregate.xsl" />
    <xsl:import href="./sub/rate-engine.xsl" />

    <xsl:output method="xml" encoding="UTF-8" indent="yes" />

    <!-- Input parameters from the processor -->
    <xsl:param name="configurationProductId" />
    <xsl:param name="configurationVersion" />
    <xsl:param name="configurationComponentId" />

    <xsl:template match="/">

        <!-- Read properties source descriptor, which contains catalogue for config sources by components -->
        <xsl:variable name="sources">
            <xsl:call-template name="load-repo-document">
                <xsl:with-param name="prefix">component-sources</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <!-- Variable componentTemplate contains the element for requested componentId -->
        <xsl:variable name="componentTemplate">
            <xsl:element name="{$configurationComponentId}"
                namespace="http://baxter-it.com/config/component/id-template" />
        </xsl:variable>

        <xsl:variable name="request">
            <xsl:copy-of select="conf:configuration-source/conf:request" />
        </xsl:variable>

        <!-- Single root of configuration sources -->
        <xsl:variable name="root">

            <!-- Add componentId template to root -->
            <xsl:copy-of select="$componentTemplate" />

            <!-- Copy request to root -->
            <xsl:copy-of select="conf:configuration-source/conf:request" />

            <!-- Now add relevant config sources to root -->
            <xsl:for-each select="$sources/sc:configuration/sc:source[c:component[@id=$configurationComponentId]]">
                <xsl:apply-templates select="$request/conf:request" mode="load-document-with-variants">
                    <xsl:with-param name="prefix" select="@prefix" />
                </xsl:apply-templates>
            </xsl:for-each>

            <xsl:apply-templates
                select="$sources/sc:configuration/sc:embedded[c:component[@id=$configurationComponentId]]/sc:values"
                mode="load-merged" />

        </xsl:variable>

        <!-- Build the inmemory document with redundant groups -->
        <xsl:variable name="redundantProperties">
            <xsl:apply-templates select="$root/cidt:*" mode="build-redundant-root" />
        </xsl:variable>

        <!-- Consolidate the elements within same parent groups and output result -->
        <xsl:apply-templates select="$redundantProperties/*" />

    </xsl:template>

    <xsl:template match="sc:values" mode="load-merged">
        <xsl:copy-of select="*" />
    </xsl:template>

    <xsl:template match="cidt:*" mode="build-redundant-root">

        <properties>
            <xsl:attribute name="version">
                <xsl:value-of select="$configurationVersion" />
            </xsl:attribute>

            <xsl:call-template name="apps-common-settings" />
            <xsl:call-template name="apps-common-gui-settings" />
            <xsl:call-template name="jms-common" />
            <xsl:call-template name="rate-engine" />

            <!-- Each componentId has its own processing. Do it. -->
            <xsl:apply-templates select="." />

        </properties>

    </xsl:template>

</xsl:stylesheet>
