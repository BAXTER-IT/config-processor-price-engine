<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:c="http://baxter-it.com/config/component"
	xmlns:conf="http://baxter-it.com/config" xmlns:log="http://baxter-it.com/config/log"
	xmlns:j="http://baxter-it.com/config/jvm" xmlns:sc="http://baxter-it.com/config/source-catalogue"
	exclude-result-prefixes="xs c conf log j sc" version="2.0">

	<xsl:import href="baxterxsl:repo-base.xsl" />
	<xsl:import href="baxterxsl:viewer.xsl" />
	<xsl:import href="baxterxsl:conf-reference.xsl" />

	<xsl:template name="product-title">
		<xsl:text>Price Engine</xsl:text>
	</xsl:template>

	<xsl:template name="load-sources">
		<xsl:apply-templates select="conf:configuration-source/conf:request"
			mode="load-document-with-variants">
			<xsl:with-param name="prefix" select="'jvm'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="conf:configuration-source/conf:request"
			mode="load-document-with-variants">
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
			<c:component id="price-engine-liquidity-selector" name="Liquidity Selector" />
			<c:component id="price-engine-trackwheel" name="TrackWheel" />
		</j:clients>
		<j:servers>
			<c:component id="price-engine-authserver" name="Authentication Server" />
			<c:component id="price-engine-blotterserver" name="Blotter Server" />
			<c:component id="price-engine-broadcast" name="Broadcast" />
			<c:component id="price-engine-broadcast-plugin" name="Broadcast Plugin" />
			<c:component id="price-engine-comprehensive-stp" name="Comprehensive STP" />
			<c:component id="price-engine-stp-abos" name="Comprehensive STP Abos" />
			<c:component id="price-engine-stp-kondor" name="Comprehensive STP Kondor" />
			<c:component id="price-engine-stp-mifid" name="Comprehensive STP Mifid" />
			<c:component id="price-engine-dbserver" name="DB Server" />
			<c:component id="price-engine-fwdcontroller" name="Forwards Controller" />
			<c:component id="price-engine-fwdircontroller" name="Fwd. with IR Controller" />
			<c:component id="price-engine-liquidity-provider-aggregator"
				name="Liquidity Provider Aggregator" />

			<c:component id="price-engine-liquidity-provider" name="Liquidity Provider" />
			<c:component id="price-engine-liquidity-provider-BAML" name="Liquidity Provider BAML" />
			<c:component id="price-engine-liquidity-provider-BlueFire"
				name="Liquidity Provider BlueFire" />
			<c:component id="price-engine-liquidity-provider-CantorFX"
				name="Liquidity Provider Cantor" />
			<c:component id="price-engine-liquidity-provider-CDLP" name="Liquidity Provider CD" />
			<c:component id="price-engine-liquidity-provider-Commerz"
				name="Liquidity Provider Commerz" />
			<c:component id="price-engine-liquidity-provider-DV" name="Liquidity Provider DV" />
			<c:component id="price-engine-liquidity-provider-DV_REST"
				name="Liquidity Provider DV REST" />
			<c:component id="price-engine-liquidity-provider-GenericFIX"
				name="Liquidity Provider Generic" />
			<c:component id="price-engine-liquidity-provider-IBAN" name="Liquidity Provider IBAN" />
			<c:component id="price-engine-liquidity-provider-MorganStanley"
				name="Liquidity Provider Morgan" />
			<c:component id="price-engine-liquidity-provider-NTPro"
				name="Liquidity Provider NTPro" />
			<c:component id="price-engine-liquidity-provider-SK4" name="Liquidity Provider SK4" />
			<c:component id="price-engine-liquidity-provider-Sucden"
				name="Liquidity Provider Sucden" />

			<c:component id="price-engine-posmanserver" name="Position Manager" />
			<c:component id="rate-engine" name="Rate Engine" />
			<c:component id="price-engine-restfulservice" name="Restful Service" />
			<c:component id="reuters-rfa-fwd" name="Reuters RFA FWD" />
			<c:component id="reuters-rfa-spot" name="Reuters RFQ Spot" />
			<c:component id="price-engine-servlet" name="Servlet" />
			<c:component id="price-engine-streaming-servlet" name="Streaming Servlet" />
			<c:component id="price-engine-twserver" name="TrackWheel Server" />
			<c:component id="price-engine-validator" name="Validator" />
			<c:component id="price-engine-vdtws" name="Validator with TrackWheel Server" />



		</j:servers>
		<j:tools>
			<c:component id="price-engine-argon-updater" name="Argon Updater" />
			<c:component id="price-engine-tenor-group-configurator"
				name="Tenor Group Configurator" />
		</j:tools>
		<j:testerTools>
			<c:component id="credit-check" name="Credit Check" />
			<c:component id="demo-vendor" name="Demo Vendor" />
			<c:component id="di-upstream" name="DI Upstream Tester" />
			<c:component id="external-permission-system" name="External Permission System" />
			<c:component id="handoff-tester" name="Handoff Tester" />
			<c:component id="price-engine-aat" name="Price Engine AAT" />
			<c:component id="trading-tool" name="Trading Tool" />
		</j:testerTools>
	</xsl:template>

	<xsl:template name="styles">
		<style type="text/css">
			table.list {
			font-family: Arial, Helvetica, sans-serif;
			border-collapse: collapse;
			width: 100%;
			}

			table.list td, table.list th {
			border: 1px solid #ddd;
			padding: 8px;
			}

			table.list
			tr:nth-child(even){background-color: #f2f2f2;}

			table.list tr:hover {background-color: #ddd;}

			table.list th {
			padding-top: 12px;
			padding-bottom: 12px;
			text-align: left;
			background-color: #04AA6D;
			color: white;
			}
			h3 {
			margin-bottom: 0;
			margin-top: 30;
			}
		</style>
	</xsl:template>

	<xsl:template match="conf:request">
		<xsl:call-template name="styles" />
		<xsl:apply-imports />
		<xsl:variable name="variants1" select="conf:variant/@id"></xsl:variable>
		<p>
			<h3>Client side components</h3>

			<br />
			<table class="list">
				<thead>
					<tr>
						<th>Client</th>
						<th>JVM config</th>
						<th>Logging configuration</th>
						<th>Properties</th>
						<xsl:call-template name="debug_header">
							<xsl:with-param name="variants" select="$variants1" />
						</xsl:call-template>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each
						select="/sc:configuration/sc:source[@prefix='applications']/c:component">
						<xsl:variable name="x" select="@id"></xsl:variable>
						<xsl:for-each select="/j:clients/c:component">
							<xsl:if test="@id = $x">
								<tr>
									<xsl:call-template name="decorate-row" />
									<td>
										<xsl:apply-templates select="." mode="component-name" />
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigUnix']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../unix.png'" />
										</xsl:apply-templates>
										<xsl:value-of select="'&#xA0;'" />
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigWindows']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../windows.png'" />
										</xsl:apply-templates>
									</td>
									<td>
										<xsl:call-template name="logging-setup">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:call-template>
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='propertiesXml']" mode="anchor">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:apply-templates>
									</td>
									<xsl:call-template name="debug_data">
										<xsl:with-param name="variants" select="$variants1" />
										<xsl:with-param name="componentId" select="@id" />
									</xsl:call-template>
								</tr>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
				</tbody>
			</table>
		</p>

		<p>
			<h3>Server side components</h3>
			<br />
			<table class="list">
				<thead>
					<tr>
						<th>Server</th>
						<th>JVM config</th>
						<th>Logging configuration</th>
						<th>Properties</th>
						<xsl:call-template name="debug_header">
							<xsl:with-param name="variants" select="$variants1" />
						</xsl:call-template>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="/j:servers/c:component">
						<xsl:variable name="x" select="@id"></xsl:variable>
						<xsl:for-each
							select="/sc:configuration/sc:source[@prefix='applications']/c:component">
							<xsl:if test="@id = $x">
								<tr>
									<xsl:call-template name="decorate-row" />
									<td>
										<xsl:apply-templates select="." mode="component-name" />
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigUnix']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../unix.png'" />
										</xsl:apply-templates>
										<xsl:value-of select="'&#xA0;'" />
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigWindows']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../windows.png'" />
										</xsl:apply-templates>
									</td>
									<td>
										<xsl:call-template name="logging-setup">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:call-template>
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='propertiesXml']" mode="anchor">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:apply-templates>
									</td>
									<xsl:call-template name="debug_data">
										<xsl:with-param name="variants" select="$variants1" />
										<xsl:with-param name="componentId" select="@id" />
									</xsl:call-template>
								</tr>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
				</tbody>
			</table>
		</p>

		<p>
			<h3>Price Engine Tools</h3>
			<br />
			<table class="list">
				<thead>
					<tr>
						<th>Tool</th>
						<th>JVM config</th>
						<th>Logging configuration</th>
						<th>Properties</th>
						<xsl:call-template name="debug_header">
							<xsl:with-param name="variants" select="$variants1" />
						</xsl:call-template>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="/j:tools/c:component">
						<xsl:variable name="x" select="@id"></xsl:variable>
						<xsl:for-each
							select="/sc:configuration/sc:source[@prefix='applications']/c:component">
							<xsl:if test="@id = $x">
								<tr>
									<xsl:call-template name="decorate-row" />
									<td>
										<xsl:apply-templates select="." mode="component-name" />
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigUnix']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../unix.png'" />
										</xsl:apply-templates>
										<xsl:value-of select="'&#xA0;'" />
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigWindows']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../windows.png'" />
										</xsl:apply-templates>
									</td>
									<td>
										<xsl:call-template name="logging-setup">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:call-template>
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='propertiesXml']" mode="anchor">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:apply-templates>
									</td>
									<xsl:call-template name="debug_data">
										<xsl:with-param name="variants" select="$variants1" />
										<xsl:with-param name="componentId" select="@id" />
									</xsl:call-template>
								</tr>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
				</tbody>
			</table>
		</p>

		<p>
			<h3>Price Engine Tester Tools</h3>
			<br />
			<table class="list">
				<thead>
					<tr>
						<th>Tester Tool</th>
						<th>JVM config</th>
						<th>Logging configuration</th>
						<th>Properties</th>
						<xsl:call-template name="debug_header">
							<xsl:with-param name="variants" select="$variants1" />
						</xsl:call-template>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="/j:testerTools/c:component">
						<xsl:variable name="x" select="@id"></xsl:variable>
						<xsl:for-each
							select="/sc:configuration/sc:source[@prefix='applications']/c:component">
							<xsl:if test="@id = $x">
								<tr>
									<xsl:call-template name="decorate-row" />
									<td>
										<xsl:apply-templates select="." mode="component-name" />
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigUnix']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../unix.png'" />
										</xsl:apply-templates>
										<xsl:value-of select="'&#xA0;'" />
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigWindows']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../windows.png'" />
										</xsl:apply-templates>
									</td>
									<td>
										<xsl:call-template name="logging-setup">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:call-template>
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='propertiesXml']" mode="anchor">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:apply-templates>
									</td>
									<xsl:call-template name="debug_data">
										<xsl:with-param name="variants" select="$variants1" />
										<xsl:with-param name="componentId" select="@id" />
									</xsl:call-template>
								</tr>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
				</tbody>
			</table>
		</p>

		<p>
			<h3>Other</h3>
			<br />
			<table class="list">
				<thead>
					<tr>
						<th>Name</th>
						<th>JVM config</th>
						<th>Logging configuration</th>
						<th>Properties</th>
						<xsl:call-template name="debug_header">
							<xsl:with-param name="variants" select="$variants1" />
						</xsl:call-template>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each
						select="/sc:configuration/sc:source[@prefix='applications']/c:component">
						<xsl:choose>
							<xsl:when
								test="/(j:clients|j:servers|j:tools|j:testerTools)/c:component[@id=current()/@id]">
							</xsl:when>
							<xsl:otherwise>
								<tr>
									<xsl:call-template name="decorate-row" />
									<td>
										<xsl:apply-templates select="." mode="component-name" />
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigUnix']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../unix.png'" />
										</xsl:apply-templates>
										<xsl:value-of select="'&#xA0;'" />
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='jvmConfigWindows']" mode="picture">
											<xsl:with-param name="componentId" select="@id" />
											<xsl:with-param name="picture-path" select="'../windows.png'" />
										</xsl:apply-templates>
									</td>
									<td>
										<xsl:call-template name="logging-setup">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:call-template>
									</td>
									<td>
										<xsl:apply-templates
											select="/conf:samples/conf:reference[@id='propertiesXml']" mode="anchor">
											<xsl:with-param name="componentId" select="@id" />
										</xsl:apply-templates>
									</td>
									<xsl:call-template name="debug_data">
										<xsl:with-param name="variants" select="$variants1" />
										<xsl:with-param name="componentId" select="@id" />
									</xsl:call-template>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</tbody>
			</table>
		</p>

	</xsl:template>

	<xsl:template name="logging-setup">
		<xsl:param name="componentId" />
		<xsl:for-each select="/j:configuration/j:logging/c:component">
			<xsl:if test="@id = $componentId">
				<xsl:apply-templates select="../conf:reference" mode="anchor">
					<xsl:with-param name="componentId" select="@id" />
					<xsl:with-param name="link-message" select="../conf:reference/@type" />
				</xsl:apply-templates>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="debug_header">
		<xsl:param name="variants"></xsl:param>
		<xsl:for-each select="$variants">
			<xsl:if test="current() = 'devel'">
				<th>Debug port</th>
				<th>Suspend</th>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="debug_data">
		<xsl:param name="variants"></xsl:param>
		<xsl:param name="componentId"></xsl:param>
		<xsl:for-each select="$variants">
			<xsl:if test="current() = 'devel'">
				<td>
					<xsl:value-of select="/j:configuration/j:debug/c:component[@id=$componentId]" />
				</td>
				<td>
					<xsl:for-each select="/j:configuration/j:debug">
						<xsl:if test="./c:component/@id = $componentId">
							<xsl:value-of select="current()/@suspend" />
						</xsl:if>
					</xsl:for-each>
				</td>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="c:component" mode="component-name">
		<xsl:choose>
			<xsl:when
				test="/(j:clients|j:servers|j:tools|j:testerTools)/c:component[@id=current()/@id]">
				<xsl:value-of
					select="/(j:clients|j:servers|j:tools|j:testerTools)/c:component[@id=current()/@id]/@name" />
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
