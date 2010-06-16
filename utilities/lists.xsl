<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">


<xsl:param name="url-query"/>
<xsl:param name="url-show"/>
<xsl:param name="category"/>
<xsl:param name="page"/>

<xsl:template name="show-list">
	<xsl:param name="name" />
	<xsl:param name="author" />
	<xsl:param name="web-id" />
	<xsl:param name="description" />
	<xsl:param name="id" select="''" />
	<xsl:param name="favourited" select="'No'" />
	<xsl:param name="type" select="'Extension'" />
	<xsl:param name="to-be-installed" select="true()" />
	
	<xsl:variable name="hidden"
		select="($objects-details = '')
		or not($details/details[@web-id = $web-id])" />
	
	<tr id="{$web-id}">
		<td>
		<xsl:call-template name="fav-form">
			<xsl:with-param name="name" select="$name" />
			<xsl:with-param name="author" select="$author" />
			<xsl:with-param name="description" select="$description" />
			<xsl:with-param name="favourited" select="$favourited" />
			<xsl:with-param name="web-id" select="$web-id" />
			<xsl:with-param name="id" select="$id" />
			<xsl:with-param name="type" select="$type" />
		</xsl:call-template>
		</td>
		
		<td><xsl:value-of select="$name" /></td>
		<td class="author"><xsl:value-of select="$author" /></td>
		<td class="description"><xsl:value-of select="$description" /></td>
		<!--
		<td>
		
		<xsl:if test="$to-be-installed">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when
					test="not(//store/key[@handle=$type]/key[@handle=$web-id]/key[@handle='source'])">source-required</xsl:when>
					<xsl:otherwise>source-selected</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:if>
		
		<xsl:call-template name="build-url">
			<xsl:with-param name="what" select="'overview'" />
			<xsl:with-param name="shown"
			select="($url-show = $web-id) and ($url-what = 'overview')" />
			<xsl:with-param name="web-id" select="$web-id" />
			<xsl:with-param name="msg-show" select="'more information...'" />
			<xsl:with-param name="msg-hide" select="'hide information'" />
		</xsl:call-template>

		<xsl:if test="($type = 'Extension') and ($to-be-installed)">
			<xsl:call-template name="build-url">
				<xsl:with-param name="what" select="'install'" />
				<xsl:with-param name="shown"
				select="($url-show = $web-id) and ($url-what = 'install')" />
				<xsl:with-param name="web-id" select="$web-id" />
				<xsl:with-param name="msg-show" select="'Select install source'" />
				<xsl:with-param name="msg-hide" select="'Hide install source'" />
			</xsl:call-template>
		</xsl:if>
		</td>
		-->
		
		<td>
		
			<xsl:variable name="missing"
			select="not(//store/key[@handle=$type]/key[@handle=$web-id]/key[@handle='source'])" />
			
			<xsl:variable name="shown" select="($url-show = $web-id) and ($url-what = 'install')" />
			
			<xsl:if test="$to-be-installed">
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="$missing and not($shown)">source-required</xsl:when>
						<xsl:otherwise>source-selected</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</xsl:if>

			<xsl:call-template name="install-form">
				<xsl:with-param name="name" select="$name" />
				<xsl:with-param name="author" select="$author" />
				<xsl:with-param name="description" select="$description" />
				<xsl:with-param name="web-id" select="$web-id" />
				<xsl:with-param name="type" select="$type" />
				<xsl:with-param name="to-be-installed" select="$to-be-installed" />
			</xsl:call-template>
			
			<xsl:if test="($type = 'Extension') and ($web-id = $url-show) and ($url-what = 'install')">
	
				<xsl:variable name="versions"
					select="$details/details[@web-id = $url-show]/versions" />
		
				<xsl:variable name="selected"
					select="//store/key[@handle='Extension']/key[@handle=$url-show]/key[@handle='source']" />
		
				<form action="?#{$web-id}" method="post">
					<select name="store[{'Extension'}][{$url-show}][source]">
				
						<xsl:if test="$versions/web-download">
							<option value="Website|{$versions/web-download}">
				
							<xsl:if test="contains($selected, 'Website')">
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
				
							<xsl:text>Website Download</xsl:text>
							</option>
						</xsl:if>
			
			
						<xsl:call-template name="options">
							<xsl:with-param name="label" select="'Tags'" />
							<xsl:with-param name="nodes" select="$versions//tags//ref" />
							<xsl:with-param name="user" select="$versions//user" />
							<xsl:with-param name="path" select="$versions//path" />
							<xsl:with-param name="selected" select="$selected" />
						</xsl:call-template>
			
						<xsl:call-template name="options">
							<xsl:with-param name="label" select="'Branches'" />
							<xsl:with-param name="nodes" select="$versions//branches//ref" />
							<xsl:with-param name="user" select="$versions//user" />
							<xsl:with-param name="path" select="$versions//path" />
							<xsl:with-param name="selected" select="$selected" />
						</xsl:call-template>
			
					</select>
					<button type="submit">Select</button>
				</form>
			</xsl:if>
			
			<xsl:if test="($type = 'Extension') and ($to-be-installed)">
				
				<xsl:call-template name="build-url">
					<xsl:with-param name="what" select="'install'" />
					<xsl:with-param name="shown" select="$shown" />
					<xsl:with-param name="web-id" select="$web-id" />
					<!-- <xsl:with-param name="msg-show" select="'source'" /> -->
					<xsl:with-param name="msg-show">
						<xsl:call-template name="version">
							<xsl:with-param name="string"
							select="//store/key[@handle='Extension']/key[@handle=$web-id]/key[@handle='source']" />
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="msg-hide" select="'hide'" />
				</xsl:call-template>
			</xsl:if>
		</td>
	</tr>
	
</xsl:template>

<xsl:template name="show-install">
	<xsl:param name="nodes" />
	<xsl:param name="type" />
	<xsl:param name="objects" />
	
	<xsl:variable name="name" select="$nodes/key[@handle = 'name']" />
	<xsl:variable name="description" select="$nodes/key[@handle = 'description']" />
	<xsl:variable name="author" select="$nodes/key[@handle = 'author']" />
	
	<xsl:variable name="web-id" select="@handle" />
	<xsl:variable name="to-be-installed" select="true()" />
	
	<xsl:variable name="id">
		<xsl:choose>
			<xsl:when test="$objects/web-id[@handle = $web-id] != ''">
				<xsl:value-of
				select="$objects/web-id[@handle = $web-id]/entry/@id" />
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="favourited">
		<xsl:choose>
			<xsl:when test="$objects/web-id[@handle = $web-id]//favourited != ''">
				<xsl:value-of select="$objects/web-id[@handle = $web-id]//favourited" />
			</xsl:when>
			<xsl:otherwise>No</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	
	<xsl:call-template name="show-list">
		<xsl:with-param name="name" select="$name" />
		<xsl:with-param name="author" select="$author" />
		<xsl:with-param name="description" select="$description" />
		<xsl:with-param name="favourited" select="$favourited" />
		<xsl:with-param name="web-id" select="$web-id" />
		<xsl:with-param name="id" select="$id" />
		<xsl:with-param name="type" select="$type" />
		<xsl:with-param name="to-be-installed" select="$to-be-installed" />
	</xsl:call-template>
</xsl:template>
</xsl:stylesheet>
