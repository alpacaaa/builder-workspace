<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />



<xsl:template match="/data">
	<div class="content">
		<table class="listing">
			<thead>
			<tr>
				<th>Fav</th>
				<th>Name</th>
				<th>Author</th>
				<th>Description</th>
				<th>Install</th>
			</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="//objects-extensions-favourited/entry" />
			</tbody>
		</table>
	</div>
</xsl:template>


<xsl:template match="//objects-extensions-favourited/entry">

	<xsl:variable name="name" select="name" />
	<xsl:variable name="description" select="description" />
	<xsl:variable name="author" select="author" />
	
	<xsl:variable name="web-id" select="web-id" />
	
	<xsl:variable name="to-be-installed"
	select="//store/key[@handle = 'Extension']/key[@handle = $web-id] != ''" />
	
	<xsl:variable name="id" select="@id" />
	
		<xsl:call-template name="show-list">
		<xsl:with-param name="name" select="$name" />
		<xsl:with-param name="author" select="$author" />
		<xsl:with-param name="description" select="$description" />
		<xsl:with-param name="favourited" select="'Yes'" />
		<xsl:with-param name="web-id" select="$web-id" />
		<xsl:with-param name="id" select="$id" />
		<xsl:with-param name="type" select="'Extension'" />
		<xsl:with-param name="to-be-installed" select="$to-be-installed" />
	</xsl:call-template>
</xsl:template>
</xsl:stylesheet>
