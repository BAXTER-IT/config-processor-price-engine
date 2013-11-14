<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cidt="http://baxter-it.com/config/component/id-template" xmlns:conf="http://baxter-it.com/config"
    xmlns:udpp="http://baxter-it.com/price-engine/conf/udp-price"
    xmlns="http://baxter-it.com/price-engine/conf/properties"
    xmlns:curr="http://baxter-it.com/price-engine/conf/currencies" xmlns:c="http://baxter-it.com/config/component"
    xmlns:gui="http://baxter-it.com/price-engine/conf/gui"
    xmlns:gprop="http://baxter-it.com/price-engine/conf/generic-properties"
    exclude-result-prefixes="xs cidt udpp curr c gui gprop" version="2.0">

    <xsl:import href="../udp-price.xsl" />
    <xsl:import href="baxterxsl:conf-reference.xsl" />

    <xsl:param name="configurationComponentId" />

    <xsl:template match="cidt:price-engine-blotter">
        <xsl:apply-templates select="/udpp:configuration" />
        <xsl:apply-templates select="/udpp:configuration" mode="num-connections" />
        <group key="sound">
            <xsl:apply-templates select="/gui:configuration/gui:sound[c:component[@id=$configurationComponentId]]" />
        </group>
        <xsl:apply-templates select="/curr:configuration[curr:currency[c:component[@id='risk-manager']]]"
            mode="risk-manager" />
        <xsl:apply-templates select="/curr:configuration[curr:currencyPair[c:component[@id='price-display']]]"
            mode="price-display" />
    </xsl:template>

    <xsl:template match="udpp:configuration" mode="num-connections">
        <group key="uDPClient2Server">
            <entry key="numberOfUDPConnection">
                <xsl:value-of
                    select="count(udpp:connection[starts-with(@id,'uDPClient2Server.uDPConnectionParam')][c:component[@id=$configurationComponentId]])"
                 />
            </entry>
        </group>
    </xsl:template>

    <xsl:template match="curr:configuration" mode="price-display">
        <group key="pricedisplay">
            <entry key="CurrencyPairs">
                <xsl:apply-templates select="curr:currencyPair[c:component[@id='price-display']]" mode="csv" />
            </entry>
        </group>
    </xsl:template>

    <xsl:template match="curr:configuration" mode="risk-manager">
        <group key="riskManager">
            <entry key="enableRiskManager">true</entry>
            <entry key="currenciesForRiskManager">
                <xsl:apply-templates select="curr:currency[c:component[@id='risk-manager']]" mode="csv" />
            </entry>
        </group>
    </xsl:template>

    <xsl:template match="gui:flag[@id='useDIPanel'][@value='true']">
        <entry key="useDIPanel">YES</entry>
    </xsl:template>

    <xsl:template match="gui:flag[@id='useDIPanel']">
        <entry key="useDIPanel">NO</entry>
    </xsl:template>

    <xsl:template match="gui:flag[@id='tradingTool'][@value='true']">
        <entry key="tradingToolConfig">
            <xsl:apply-templates select="/conf:reference[@id='tradingToolConfig']" mode="url" />
        </entry>
    </xsl:template>

    <xsl:template match="curr:currency | curr:currencyPair" mode="csv">
        <xsl:value-of select="@id" />
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="gui:sound">
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:value-of select="@value" />
        </entry>
    </xsl:template>

    <xsl:template match="gprop:property[@id='failedTradePopupPosition'][@value='off']">
        <entry key="showFailedTradePopup">false</entry>
    </xsl:template>

    <xsl:template match="gprop:property[@id='failedTradePopupPosition']">
        <entry key="showFailedTradePopup">true</entry>
        <entry key="failedTradePopupPosition">
            <xsl:value-of select="@value" />
        </entry>
    </xsl:template>

</xsl:stylesheet>
