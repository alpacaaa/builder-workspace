<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml">


<xsl:import href="../utilities/master.xsl" />


<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/data">

<xsl:variable name="selected" select="//store/key[@handle = 'symphony-version']" />

<form action="{$root}/choose-extensions/" method="post" class="start">

	<label for="store[symphony-version]">Choose a Symphony version</label>
	<select name="store[symphony-version]" id="store[symphony-version]">
	
		<xsl:variable name="download-links" select="//xhtml:li//xhtml:dt/xhtml:a" />
		
		<optgroup label="Official Releases">
		<xsl:for-each select="$download-links">
			<option value="Release|{@href}">
				<xsl:if test="$selected = concat('Release','|', @href)">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
			
				<xsl:value-of select="." />
			</option>
		</xsl:for-each>
	
		</optgroup>
		
		<xsl:variable name="github" select="document(concat($root, '/github-api/symphonycms/symphony-2/'))" />
	
		<xsl:call-template name="options">
			<xsl:with-param name="label" select="'Tags'" />
			<xsl:with-param name="nodes" select="$github//tags//ref" />
			<xsl:with-param name="user" select="$github//user" />
			<xsl:with-param name="path" select="$github//path" />
			<xsl:with-param name="selected" select="$selected" />
		</xsl:call-template>
	
		<xsl:call-template name="options">
			<xsl:with-param name="label" select="'Branches'" />
			<xsl:with-param name="nodes" select="$github//branches//ref" />
			<xsl:with-param name="user" select="$github//user" />
			<xsl:with-param name="path" select="$github//path" />
			<xsl:with-param name="selected" select="$selected" />
		</xsl:call-template>
	</select>
	
	<input type="submit" value="Go" />

</form>
</xsl:template>
</xsl:stylesheet>
