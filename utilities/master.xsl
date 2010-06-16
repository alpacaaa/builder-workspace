<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common">

<xsl:import href="../utilities/lists.xsl" />
<xsl:import href="../utilities/forms.xsl" />
<xsl:import href="../utilities/helper.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />
	

<xsl:variable name="github-info">
		<xsl:apply-templates select="//github-info" />
</xsl:variable>

<xsl:variable name="objects-details">
		<xsl:apply-templates select="//objects-extensions-details" />
		<xsl:apply-templates select="//objects-utilities-details" />
</xsl:variable>

<xsl:variable name="details" select="exsl:node-set($objects-details)" />

<xsl:template match="/">
<html>
<head>
	<title><xsl:value-of select="$page-title" /> – Builder</title>
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/style.css" />
</head>

<body>
	<h1>Builder</h1>
	<xsl:apply-templates select="data/navigation" />
	
	
	<div class="main">
	<h3><xsl:value-of select="$page-title" /></h3>
	
	
	<xsl:variable name="nav" select="data/navigation" />
	
	<xsl:if test="
		($nav//page[@id = $current-page-id]/ancestor::page)
		or ($nav/page[@id = $current-page-id]/page)
	">
		<ul class="tabs">
			<li>
				<a>
					<xsl:if test="not($nav/page/page[@id = $current-page-id])">
						<xsl:attribute name="class">active</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="href">
						<xsl:value-of select="$root" />
						<xsl:text>/</xsl:text>
						
						<xsl:value-of select="$nav//page[@id = $current-page-id]/ancestor::page/@handle" />
						<xsl:value-of select="$nav/page[@id = $current-page-id]/@handle" />
					</xsl:attribute>
				
					<xsl:text>View all</xsl:text>
				</a>
			</li>
			
			<xsl:apply-templates
			select="$nav//page[@id = $current-page-id]/ancestor::page/page" />
			
			<xsl:apply-templates
			select="$nav/page[@id = $current-page-id]/page" />
		</ul>
	</xsl:if>
	
	<xsl:apply-templates select="data" />
	</div>
</body>
</html>
</xsl:template>



<xsl:template match="data/navigation">
	<ul class="navigation">
		<xsl:apply-templates select="page[.//type/text() = 'step']"/>
	</ul>
</xsl:template>


<xsl:template match="navigation/page">
	<li>
		<a>
			<xsl:if test="(@id = $current-page-id) or (.//page[@id = $current-page-id])">
				<xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:value-of select="$root" />/<xsl:value-of select="@handle" />
			</xsl:attribute>
			<xsl:value-of select="name" />
		</a>
	</li>
</xsl:template>

<xsl:template match="navigation/page/page">
	<li>
		<a>
			<xsl:if test="@id = $current-page-id">
				<xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:value-of select="$root" />
				<xsl:text>/</xsl:text>
				
				<xsl:choose>
					<xsl:when test="$root-page">
						<xsl:value-of select="$root-page" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$current-page" />
					</xsl:otherwise>
				</xsl:choose>				
				<xsl:text>/</xsl:text>
				
				<xsl:value-of select="@handle" />
			</xsl:attribute>
			
			<xsl:value-of select="name" />
		</a>
	</li>
</xsl:template>

</xsl:stylesheet>
