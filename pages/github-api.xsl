<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/helper.xsl" />

<xsl:output method="xml"
	omit-xml-declaration="no"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/data">
<repo>
	
	
	<user><xsl:value-of select="$user" /></user>
	<path><xsl:value-of select="$repo" /></path>
	
	<tags>
	<xsl:for-each select="//github-info/key[@handle='tags']/*">
			<xsl:call-template name="flatten">
				<xsl:with-param name="nodes" select="." />
			</xsl:call-template>
	</xsl:for-each>
	</tags>
	
	<branches>
	<xsl:for-each select="//github-info/key[@handle='branches']/*">
			<xsl:call-template name="flatten">
				<xsl:with-param name="nodes" select="." />
			</xsl:call-template>
	</xsl:for-each>
	</branches>
	
</repo>
</xsl:template>
</xsl:stylesheet>
