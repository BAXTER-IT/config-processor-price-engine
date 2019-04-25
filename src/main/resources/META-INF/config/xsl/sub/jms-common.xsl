<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:conf="http://baxter-it.com/config"
    xmlns:c="http://baxter-it.com/config/component" xmlns:jms="http://baxter-it.com/price-engine/conf/jms" xmlns="http://baxter-it.com/price-engine/conf/properties"
    exclude-result-prefixes="xs jms c" version="2.0">

    <xsl:import href="./group-container.xsl" />

    <!-- Renders the common JMS settings -->
    <xsl:template name="jms-common">
        <xsl:apply-templates select="/jms:configuration" mode="jms-common" />
    </xsl:template>

    <xsl:template match="jms:configuration" mode="jms-common">
        <xsl:apply-templates select="jms:authentication[@id='global']">
            <xsl:with-param name="prefix">GlobalJMS</xsl:with-param>
        </xsl:apply-templates>
        <xsl:apply-templates select="jms:ssl[@id='jmsSSL']" />
        <xsl:apply-templates select="jms:topic[c:component[@id=$configurationComponentId]]" />
        <xsl:apply-templates select="jms:queue[c:component[@id=$configurationComponentId]]" />
    </xsl:template>

    <xsl:template match="jms:ssl">
        <group>
            <xsl:attribute name="key">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <entry key="TrustStore">
                <xsl:value-of select="@store" />
            </entry>
            <entry key="KeyStorePassword">
                <xsl:value-of select="@storePassword" />
            </entry>
            <entry key="AnonCipher">
                <xsl:value-of select="@anonCipher" />
            </entry>
        </group>
    </xsl:template>

    <xsl:template match="jms:authentication">
        <xsl:param name="prefix" select="''" />
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="$prefix" />
                <xsl:text>UserName</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="@username" />
        </entry>
        <entry>
            <xsl:attribute name="key">
                <xsl:value-of select="$prefix" />
                <xsl:text>Password</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="@password" />
        </entry>
    </xsl:template>

    <xsl:template match="jms:manager">
        <entry key="namingContextFactory">
            <xsl:value-of select="@namingContextFactory" />
        </entry>
        <entry key="providerUrl">
            <xsl:value-of select="@providerUrl" />
        </entry>
        <xsl:if test="@queueConnectionFactory">
            <entry key="queueConnectionFactory">
                <xsl:value-of select="@queueConnectionFactory" />
            </entry>
        </xsl:if>
        <xsl:if test="@topicConnectionFactory">
            <entry key="topicConnectionFactory">
                <xsl:value-of select="@topicConnectionFactory" />
            </entry>
        </xsl:if>
    </xsl:template>

    <xsl:template match="jms:node" mode="jms-reference">
        <xsl:param name="suffix" select="''" />
        <entry>
            <xsl:attribute name="key">
                <xsl:text>Host</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
            <xsl:value-of select="@host" />
        </entry>
        <entry>
            <xsl:attribute name="key">
                <xsl:text>Port</xsl:text>
                <xsl:value-of select="$suffix" />
            </xsl:attribute>
            <xsl:value-of select="@port" />
        </entry>
        <xsl:if test="@providerUrl">
	        <entry>
	            <xsl:attribute name="key">
	                <xsl:text>ProviderUrl</xsl:text>
	            </xsl:attribute>
	            <xsl:value-of select="@providerUrl" />
	        </entry>
        </xsl:if>
        <xsl:if test="@namingContextFactory">
	        <entry>
	            <xsl:attribute name="key">
	                <xsl:text>NamingContextFactory</xsl:text>
	            </xsl:attribute>
	            <xsl:value-of select="@namingContextFactory" />
	        </entry>
        </xsl:if>
        <xsl:if test="@queueConnectionFactory">
	        <entry>
	            <xsl:attribute name="key">
	                <xsl:text>QueueConnectionFactory</xsl:text>
	            </xsl:attribute>
	            <xsl:value-of select="@queueConnectionFactory" />
	        </entry>
        </xsl:if>
        <xsl:if test="@topicConnectionFactory">
	        <entry>
	            <xsl:attribute name="key">
	                <xsl:text>TopicConnectionFactory</xsl:text>
	            </xsl:attribute>
	            <xsl:value-of select="@topicConnectionFactory" />
	        </entry>
        </xsl:if>
    </xsl:template>

    <xsl:template match="jms:queue[@manager]">
        <xsl:param name="path" select="@id" />
        <xsl:choose>
            <xsl:when test="contains($path,'.')">
                <xsl:call-template name="in-container">
                    <xsl:with-param name="path" select="$path" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <entry>
                    <xsl:attribute name="key">
                        <xsl:value-of select="$path" />
                    </xsl:attribute>
                    <xsl:value-of select="@name" />
                </entry>
                <xsl:apply-templates select="/jms:configuration/jms:manager[@id=current()/@manager]" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="channel-jms-reference">
        <xsl:apply-templates select="../jms:node[@id=current()/@node]" mode="jms-reference" />
        <xsl:choose>
            <xsl:when test="@node2">
                <xsl:apply-templates select="../jms:node[@id=current()/@node2]" mode="jms-reference">
                    <xsl:with-param name="suffix">2</xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <entry key="Host2">null</entry>
                <entry key="Port2">0</entry>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="../jms:authentication[@id=current()/@authentication]" />
    </xsl:template>

    <xsl:template match="jms:topic/@compressed">
        <entry key="Compressed">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="jms:queue/@compressed">
        <entry key="Compressed">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="jms:topic/@reconnect">
        <entry key="reconnect">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>
    
    <xsl:template match="jms:queue/@reconnect">
        <entry key="reconnect">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>
    
    <xsl:template match="jms:topic/@ackMode">
        <entry key="AckMode">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>
    
    <xsl:template match="jms:queue/@ackMode">
        <entry key="AckMode">
            <xsl:value-of select="." />
        </entry>
    </xsl:template>

    <xsl:template match="jms:topic">
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
                    <entry key="TName">
                        <xsl:value-of select="@name" />
                    </entry>
                    <xsl:apply-templates select="@reconnect" />
                    <xsl:apply-templates select="@compressed" />
                    <xsl:apply-templates select="@ackMode" />
                    <xsl:call-template name="channel-jms-reference" />
                </group>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="jms:queue">
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
                    <entry key="QName">
                        <xsl:value-of select="@name" />
                    </entry>
                    <entry key="QRouter">
                        <xsl:value-of select="../jms:node[@id=current()/@node]/@router" />
                    </entry>
                    <xsl:apply-templates select="@reconnect" />
                    <xsl:apply-templates select="@compressed" />
                    <xsl:apply-templates select="@ackMode" />
                    <xsl:call-template name="channel-jms-reference" />
                </group>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
