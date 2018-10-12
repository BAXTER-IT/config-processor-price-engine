<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:qfix="http://baxter-it.com/price-engine/conf/qfix" xmlns:c="http://baxter-it.com/config/component"
    xmlns:conf="http://baxter-it.com/config" exclude-result-prefixes="xs" version="2.0">

    <xsl:import href="baxterxsl:repo-base.xsl" />
    <xsl:import href="baxterxsl:text-fmt.xsl" />
    <xsl:import href="baxterxsl:conf-reference.xsl" />

    <xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" />

    <xsl:param name="configurationProductId" />
    <xsl:param name="configurationComponentId" />

    <xsl:template match="/">
        <xsl:variable name="root">
            <xsl:copy-of select="conf:configuration-source/conf:request" />
            <xsl:apply-templates select="conf:configuration-source/conf:request" mode="load-document-with-variants">
                <xsl:with-param name="prefix" select="'qfix'" />
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:apply-templates select="$root/qfix:configuration" />
    </xsl:template>

    <xsl:template match="qfix:configuration">
        <xsl:text>#################################</xsl:text>
        <xsl:call-template name="CRLF" />
        <xsl:text># QuickFix related Parameters!!!#</xsl:text>
        <xsl:call-template name="CRLF" />
        <xsl:text># Generated by BaxterConfig  :) #</xsl:text>
        <xsl:call-template name="CRLF" />
        <xsl:text>#################################</xsl:text>
        <xsl:call-template name="CRLF" />
        <xsl:call-template name="CRLF" />
        <xsl:call-template name="render-default-section" />
        <xsl:call-template name="CRLF" />
        <xsl:apply-templates select="qfix:session[@id=/conf:request/conf:parameter[@id='session']/text()]" />
    </xsl:template>


    <xsl:template match="qfix:default[text()='true'] | qfix:option[text()='true']">
        <xsl:value-of select="@id" />
        <xsl:text>=Y</xsl:text>
        <xsl:call-template name="CRLF" />
    </xsl:template>

    <xsl:template match="qfix:default[text()='false'] | qfix:option[text()='false']">
        <xsl:value-of select="@id" />
        <xsl:text>=N</xsl:text>
        <xsl:call-template name="CRLF" />
    </xsl:template>

    <xsl:template match="qfix:default | qfix:option">
        <xsl:value-of select="@id" />
        <xsl:text>=</xsl:text>
        <xsl:value-of select="." />
        <xsl:call-template name="CRLF" />
    </xsl:template>

    <xsl:template match="qfix:defaults">
        <xsl:apply-templates select="../qfix:connection[@id=current()/qfix:connection-ref/@id]" />
        <xsl:apply-templates select="../qfix:time[@id=current()/qfix:time-ref/@id]" />
        <xsl:apply-templates select="qfix:default" />
        <xsl:for-each select="conf:reference">
            <xsl:value-of select="@id" />
            <xsl:text>=</xsl:text>
            <xsl:apply-templates select="." mode="url" />
            <xsl:call-template name="CRLF" />
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="render-default-section">
        <xsl:text>[DEFAULT]</xsl:text>
        <xsl:call-template name="CRLF" />
        <xsl:apply-templates select="qfix:defaults[@id=/conf:request/conf:parameter[@id='defaults']/text()]" />
    </xsl:template>

    <xsl:template match="qfix:session">
        <xsl:text>[SESSION]</xsl:text>
        <xsl:call-template name="CRLF" />
        <xsl:text>BeginString=</xsl:text>
        <xsl:value-of select="@beginString" />
        <xsl:call-template name="CRLF" />
		<xsl:text>SenderCompID=</xsl:text>
        <xsl:value-of select="@sender" />
        <xsl:call-template name="CRLF" />
        <xsl:text>TargetCompID=</xsl:text>
        <xsl:value-of select="@target" />
        <xsl:call-template name="CRLF" />
        <xsl:apply-templates select="../qfix:time[@id=current()/@time]" />
        <xsl:text>HeartBtInt=</xsl:text>
        <xsl:value-of select="@heartbeatInterval" />
        <xsl:call-template name="CRLF" />
        <xsl:text>DataDictionary=</xsl:text>
        <xsl:apply-templates select="conf:reference[@id='DataDictionary']" mode="url" />
        <xsl:call-template name="CRLF" />
        <xsl:apply-templates select="../qfix:connection[@id=current()/@connection]" />
    </xsl:template>

   <xsl:template match="qfix:connection">
   		<xsl:text>ConnectionType=</xsl:text>
        <xsl:value-of select="@type" />
        <xsl:call-template name="CRLF" />
		<xsl:if test="@type = 'initiator'">
			<xsl:text>SocketConnectPort=</xsl:text>
			<xsl:value-of select="@port" />
			<xsl:call-template name="CRLF" />
			<xsl:text>SocketConnectHost=</xsl:text>
			<xsl:value-of select="@host" />
			<xsl:call-template name="CRLF" />
		</xsl:if>
		<xsl:if test="@type = 'acceptor'">
			<xsl:text>SocketAcceptPort=</xsl:text>
			<xsl:value-of select="@port" />
			<xsl:call-template name="CRLF" />
		</xsl:if>
        <xsl:if test="@resetOnLogon = 'true'">
            <xsl:text>ResetOnLogon=Y</xsl:text>
            <xsl:call-template name="CRLF" />
        </xsl:if>
        <xsl:apply-templates select="qfix:ssl" />
    </xsl:template>
   
    <xsl:template match="qfix:time">
        <xsl:text>StartTime=</xsl:text>
        <xsl:value-of select="@start" />
        <xsl:call-template name="CRLF" />
        <xsl:text>EndTime=</xsl:text>
        <xsl:value-of select="@end" />
        <xsl:call-template name="CRLF" />
        <xsl:if test="@startDay">
            <xsl:text>StartDay=</xsl:text>
            <xsl:value-of select="@startDay" />
            <xsl:call-template name="CRLF" />
        </xsl:if>
        <xsl:if test="@endDay">
            <xsl:text>EndDay=</xsl:text>
            <xsl:value-of select="@endDay" />
            <xsl:call-template name="CRLF" />
        </xsl:if>
    </xsl:template>

    <xsl:template match="qfix:ssl">
        <xsl:text>SocketUseSSL=Y</xsl:text>
        <xsl:call-template name="CRLF" />
        <xsl:text>SocketKeyStore=</xsl:text>
        <xsl:apply-templates select="conf:reference[@id='SocketKeyStore']" mode="url" />
        <xsl:call-template name="CRLF" />
        <xsl:text>SocketKeyStorePassword=</xsl:text>
        <xsl:value-of select="@password" />
        <xsl:call-template name="CRLF" />
    </xsl:template>

</xsl:stylesheet>
