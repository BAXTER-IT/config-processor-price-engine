<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:j="http://baxter-it.com/config/jvm"
    xmlns:c="http://baxter-it.com/config/component" xmlns:conf="http://baxter-it.com/config"
    xmlns:gui="http://baxter-it.com/price-engine/conf/gui" exclude-result-prefixes="xs j c conf gui"
    version="2.0">

    <xsl:import href="baxterxsl:repo-base.xsl"/>
    <xsl:import href="baxterxsl:jvm.xsl"/>

    <xsl:param name="configurationComponentId"/>

    <xsl:template match="/">
        <xsl:variable name="root">
            <xsl:copy-of select="conf:configuration-source/conf:request"/>
            <xsl:apply-templates select="conf:configuration-source/conf:request"
                mode="load-document-with-variants">
                <xsl:with-param name="prefix" select="'jvm'"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="conf:configuration-source/conf:request"
                mode="load-document-with-variants">
                <xsl:with-param name="prefix" select="'gui'"/>
            </xsl:apply-templates>
            <!--j:system id="javalib" name="java.library.path" var="JAVALIB_PATH"/-->
            <j:system id="translaccel" name="sun.java2d.translaccel" value="true"/>
            <j:system id="ddscale" name="sun.java2d.ddscale" value="true"/>
        </xsl:variable>
        <xsl:apply-templates select="$root/j:configuration"/>
    </xsl:template>

    <xsl:template match="j:configuration">
        <xsl:apply-templates select="." mode="script-start"/>
        <xsl:apply-templates
            select="/gui:configuration/gui:window[c:component[@id=$configurationComponentId]]"
            mode="gui-jvm-opts"/>
        <xsl:apply-templates select="." mode="script-end"/>
    </xsl:template>

    <xsl:template match="gui:window" mode="gui-jvm-opts">
        <xsl:apply-templates select="/j:system[@id='javalib']"/>
        <xsl:apply-templates select="/j:system[@id='translaccel']"/>
        <xsl:apply-templates select="/j:system[@id='ddscale']"/>
    </xsl:template>

</xsl:stylesheet>
