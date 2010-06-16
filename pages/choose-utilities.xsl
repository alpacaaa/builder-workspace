<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:str="http://exslt.org/strings">

<xsl:import href="../utilities/master.xsl" />


<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/data">
	<!-- <xsl:copy-of select="/" /> -->
	
	
	<div class="content">
	<xsl:apply-templates select="//xhtml:div[@id='top-pagination']//xhtml:ul[@class='pagination']" />
	
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
				<xsl:apply-templates select="//xhtml:ul[@class='listings-row']/xhtml:li" />
			</tbody>
		</table>
	
	
	<xsl:apply-templates select="//xhtml:div[@id='top-pagination']//xhtml:ul[@class='pagination']" />
	</div>
</xsl:template>

<xsl:template match="//xhtml:ul[@class='pagination']">
	
	<ul class="pagination">
	<xsl:for-each select="xhtml:li/xhtml:a">
		<li>
			<xsl:if test="ancestor::xhtml:li/@class">
				<xsl:attribute name="class"><xsl:value-of select="ancestor::xhtml:li/@class" /></xsl:attribute>
			</xsl:if>
			
			<a>
			<xsl:if test="@class">
				<xsl:attribute name="class"><xsl:value-of select="@class" /></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:value-of select="concat($root,'/',$current-page,'/')"/>			
				<xsl:value-of select="str:replace(@href, '/download/xslt-utilities/', '')" />
			</xsl:attribute>
				<xsl:value-of select="." />
			</a>
		</li>
	</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="//xhtml:ul[@class='listings-row']/xhtml:li">
	<xsl:variable name="name" select="xhtml:h4/xhtml:a" />
	<xsl:variable name="description" select="xhtml:h5" />
	<xsl:variable name="author" select="xhtml:ul//xhtml:a[1]" />
	
	<xsl:variable name="web-id">
		<xsl:call-template name="get-web-id">
			<xsl:with-param name="url" select="xhtml:h4/xhtml:a/@href" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="favourited">
		<xsl:choose>
			<xsl:when test="//objects-utilities/web-id[@handle = $web-id] != ''">
				<xsl:value-of select="//objects-utilities/web-id[@handle = $web-id]//favourited" />
			</xsl:when>
			<xsl:otherwise>No</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="to-be-installed"
	select="//store/key[@handle = 'Utility']/key[@handle = $web-id] != ''" />
	
	<xsl:variable name="id">
		<xsl:choose>
			<xsl:when test="//objects-utilities/web-id[@handle = $web-id] != ''">
				<xsl:value-of select="//objects-utilities/web-id[@handle = $web-id]/entry/@id" />
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:call-template name="show-list">
		<xsl:with-param name="name" select="$name" />
		<xsl:with-param name="author" select="$author" />
		<xsl:with-param name="description" select="$description" />
		<xsl:with-param name="favourited" select="$favourited" />
		<xsl:with-param name="web-id" select="$web-id" />
		<xsl:with-param name="id" select="$id" />
		<xsl:with-param name="type" select="'Utility'" />
		<xsl:with-param name="to-be-installed" select="$to-be-installed" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
