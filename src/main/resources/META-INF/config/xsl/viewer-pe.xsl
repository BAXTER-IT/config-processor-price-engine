<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:c="http://baxter-it.com/config/component" xmlns:conf="http://baxter-it.com/config" xmlns:log="http://baxter-it.com/config/log"
    xmlns:j="http://baxter-it.com/config/jvm" xmlns:sc="http://baxter-it.com/config/source-catalogue"
    exclude-result-prefixes="xs c conf log j sc" version="2.0">

    <xsl:import href="baxterxsl:repo-base.xsl" />
    <xsl:import href="baxterxsl:viewer.xsl" />
    <xsl:import href="baxterxsl:conf-reference.xsl" />

    <xsl:template name="product-title">
        <xsl:text>Price Engine</xsl:text>
    </xsl:template>

    <xsl:template name="load-sources">
        <xsl:apply-templates select="conf:configuration-source/conf:request" mode="load-document-with-variants">
            <xsl:with-param name="prefix" select="'jvm'" />
        </xsl:apply-templates>
        <xsl:apply-templates select="conf:configuration-source/conf:request" mode="load-document-with-variants">
            <xsl:with-param name="prefix" select="'log'" />
        </xsl:apply-templates>
        <xsl:call-template name="load-repo-document">
            <xsl:with-param name="prefix" select="'component-sources'" />
        </xsl:call-template>
        <conf:samples>
            <conf:reference id="jvmConfigUnix" type="jvm">
                <conf:parameter name="osfamily">unix</conf:parameter>
            </conf:reference>
            <conf:reference id="jvmConfigWindows" type="jvm">
                <conf:parameter name="osfamily">windows</conf:parameter>
            </conf:reference>
            <conf:reference id="propertiesXml" type="propertiesxml">
            </conf:reference>
        </conf:samples>
        <j:clients>
            <c:component id="price-engine-admintool" name="AdminTool" />
            <c:component id="price-engine-blotter" name="Blotter" />
            <c:component id="price-engine-fwdmonitor" name="Forwards Monitor" />
            <c:component id="price-engine-trackwheel" name="TrackWheel" />
        </j:clients>
        <j:servers>
            <c:component id="price-engine-dbserver" name="DBServer" />
            <c:component id="price-engine-broadcast" name="Broadcast" />
            <c:component id="price-engine-blotterserver" name="Blotter Server" />
            <c:component id="price-engine-twserver" name="TrackWheel Server" />
            <c:component id="price-engine-validator" name="Validator" />
            <c:component id="price-engine-fwdcontroller" name="Forwards Controller" />
            <c:component id="price-engine-fwdircontroller" name="Fwd. with IR Controller" />
            <c:component id="price-engine-servlet" name="Servlet" />
            <c:component id="price-engine-vdtws" name="Validator with TrackWheel Server" />
        </j:servers>
    </xsl:template>

    <xsl:template name="styles">
        <style type="text/css">
            table.list {
            border: none;
            background-color: #010101;
            border-spacing:0;
            border-collapse:collapse;
            }
            table.list th {
            background-color: #080808;
            color: #FFFFFF;
            }
            table.list tr.odd td {
            background-color: #CFCFCF;
            }
            table.list tr.even td {
            background-color: #AFAFAF;
            }
        </style>
    </xsl:template>

    <xsl:template match="conf:request">
        <xsl:apply-imports />

        <xsl:call-template name="styles" />

        <h5>Java Virtual Machine Configuration</h5>

        <p>
            PriceEngine Client Applications are designed to run on Windows platform. Every application when starts uses
            JVM settings provided by:
            <br />
            <table class="list">
                <thead>
                    <tr>
                        <th>Client</th>
                        <th>JVM Config</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="/j:clients/c:component">
                        <tr>
                            <xsl:call-template name="decorate-row" />
                            <td>
                                <xsl:value-of select="@name" />
                            </td>
                            <td>
                                <xsl:apply-templates select="/conf:samples/conf:reference[@id='jvmConfigWindows']"
                                    mode="anchor">
                                    <xsl:with-param name="componentId" select="@id" />
                                </xsl:apply-templates>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </p>

        <p>
            As opposite to the client applications the PriceEngine Servers would typically run on linux platform with
            following java settings:
            <br />
            <table class="list">
                <thead>
                    <tr>
                        <th>Server</th>
                        <th>JVM Config</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="/j:servers/c:component">
                        <tr>
                            <xsl:call-template name="decorate-row" />
                            <td>
                                <xsl:value-of select="@name" />
                            </td>
                            <td>
                                <xsl:apply-templates select="/conf:samples/conf:reference[@id='jvmConfigUnix']"
                                    mode="anchor">
                                    <xsl:with-param name="componentId" select="@id" />
                                </xsl:apply-templates>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </p>

        <p>
            Some customers, however, still run the PriceEngine servers on Windows. They are using JVM settings below:
            <br />
            <table class="list">
                <thead>
                    <tr>
                        <th>Server</th>
                        <th>JVM Config</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="/j:servers/c:component">
                        <tr>
                            <xsl:call-template name="decorate-row" />
                            <td>
                                <xsl:value-of select="@name" />
                            </td>
                            <td>
                                <xsl:apply-templates select="/conf:samples/conf:reference[@id='jvmConfigWindows']"
                                    mode="anchor">
                                    <xsl:with-param name="componentId" select="@id" />
                                </xsl:apply-templates>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </p>

        <h5>Logging Configuration</h5>

        <p>
            PriceEngine components use following logging frameworks and configurations:
            <br />
            <table class="list">
                <thead>
                    <tr>
                        <th>Component</th>
                        <th>Framework</th>
                        <th>Configuration</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="/j:configuration/j:logging/c:component">
                        <tr>
                            <xsl:call-template name="decorate-row" />
                            <td>
                                <xsl:apply-templates select="." mode="component-name" />
                            </td>
                            <td>
                                <xsl:value-of select="../conf:reference/@type" />
                            </td>
                            <td>
                                <xsl:apply-templates select="../conf:reference" mode="anchor">
                                    <xsl:with-param name="componentId" select="@id" />
                                </xsl:apply-templates>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </p>

        <h4>Bulk Configuration</h4>

        <p>
            For historical reasons all PriceEngine components use the bulk configuration in custom propertiesXML format,
            which contains different kinds of configuration (JMS, Windowing, generic properties etc). That is going to
            be changed in nearest future, for now you can check configurations of individual components below:
            <br />
            <table class="list">
                <thead>
                    <tr>
                        <th>Component</th>
                        <th>Properties URL</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each-group select="/sc:configuration/sc:source/c:component" group-by="@id">
                        <tr>
                            <xsl:call-template name="decorate-row" />
                            <td>
                                <xsl:apply-templates select="." mode="component-name" />
                            </td>
                            <td>
                                <xsl:apply-templates select="/conf:samples/conf:reference[@id='propertiesXml']"
                                    mode="anchor">
                                    <xsl:with-param name="componentId" select="@id" />
                                </xsl:apply-templates>
                            </td>
                        </tr>
                    </xsl:for-each-group>
                </tbody>
            </table>
        </p>

    </xsl:template>

    <xsl:template match="c:component" mode="component-name">
        <xsl:choose>
            <xsl:when test="/(j:clients|j:servers)/c:component[@id=current()/@id]">
                <xsl:value-of select="/(j:clients|j:servers)/c:component[@id=current()/@id]/@name" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@id" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="decorate-row">
        <xsl:attribute name="class">
            <xsl:choose>
            <xsl:when test="position() mod 2 = 0">even</xsl:when>
            <xsl:otherwise>odd</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>
