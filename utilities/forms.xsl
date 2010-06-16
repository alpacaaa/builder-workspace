<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">



<xsl:template name="fav-form">
	<xsl:param name="name" />
	<xsl:param name="author" />
	<xsl:param name="web-id" />
	<xsl:param name="description" />
	<xsl:param name="id" select="''" />
	<xsl:param name="favourited" select="'No'" />
	<xsl:param name="type" select="'Extension'" />
	
	<form method="post" action="?#{$web-id}">
		<input type="hidden" name="fields[name]" value="{$name}" />
		<input type="hidden" name="fields[type]" value="{$type}" />
		<input type="hidden" name="fields[author]" value="{$author}" />
		<input type="hidden" name="fields[web-id]" value="{$web-id}" />
		<input type="hidden" name="fields[description]" value="{$description}" />
		
		<input type="hidden" name="fields[favourited]">
			<xsl:attribute name="value">
				<xsl:choose>
					<xsl:when test="$favourited = 'No'">yes</xsl:when>
					<xsl:otherwise>no</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</input>
		
		<xsl:if test="$id != ''">
			<input type="hidden" name="id" value="{$id}" />
		</xsl:if>
		
		<xsl:variable name="msg">
			<xsl:choose>
				<xsl:when test="$favourited = 'No'">
					<xsl:text>Add </xsl:text>
					<xsl:value-of select="$name" />
					<xsl:text> to</xsl:text>
				</xsl:when>
				
				<xsl:otherwise>				
					<xsl:text>Remove </xsl:text>
					<xsl:value-of select="$name" />
					<xsl:text> from</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:text> your favourites</xsl:text>
		</xsl:variable>
		
		<input type="submit" name="action[save-object]" value="{$msg}">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="$favourited = 'No'">unfav</xsl:when>
					<xsl:otherwise>fav</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</input>
	</form>

</xsl:template>

<xsl:template name="install-form">
	<xsl:param name="name" />
	<xsl:param name="author" />
	<xsl:param name="web-id" />
	<xsl:param name="description" />
	<xsl:param name="type" select="'Extension'" />
	<xsl:param name="to-be-installed" select="true()" />
	
	<xsl:variable name="prefix" select="concat('store[', $type, '][', $web-id, ']')" />
	
	<xsl:variable name="bit">
		<xsl:if test="not(contains($current-url, '?'))">?</xsl:if>
	</xsl:variable>
	
	<!-- <form method="post" action="{$bit}#{$web-id}"> -->
	<xsl:variable name="show">
		<xsl:value-of select="$web-id" />
		<xsl:if test="$to-be-installed">*</xsl:if>
	</xsl:variable>
	
	<form method="post" action="?show={$show}&amp;what=install#{$web-id}">
		<xsl:choose>
			<xsl:when test="$to-be-installed = false()">
				<input type="hidden" name="{$prefix}[name]" value="{$name}" />
				<input type="hidden" name="{$prefix}[author]" value="{$author}" />
				<input type="hidden" name="{$prefix}[description]" value="{$description}" />
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="{$prefix}" value="" />
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:variable name="msg">
			<xsl:choose>
				<xsl:when test="$to-be-installed = false()">Install </xsl:when>
				<xsl:otherwise>Do not install </xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="$name" />
		</xsl:variable>
		
		<input type="submit" value="{$msg}">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="$to-be-installed = true()">install</xsl:when>
					<xsl:otherwise>uninstall</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</input>
	</form>
</xsl:template>
</xsl:stylesheet>
