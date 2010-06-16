<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:str="http://exslt.org/strings"
	xmlns:exsl="http://exslt.org/common">



<xsl:template match="//github-info">
<repo>
	<xsl:copy-of select="user" />
	<xsl:copy-of select="repo" />
	
	<tags>
	<xsl:for-each select="key[@handle='tags']/*">
		<xsl:call-template name="flatten">
			<xsl:with-param name="nodes" select="." />
		</xsl:call-template>
	</xsl:for-each>
	</tags>
	
	<branches>
	<xsl:for-each select="key[@handle='branches']/*">
		<xsl:call-template name="flatten">
			<xsl:with-param name="nodes" select="." />
		</xsl:call-template>
	</xsl:for-each>
	</branches>
	
</repo>
</xsl:template>




<xsl:template match="//objects-extensions-details">
	<xsl:choose>
		<xsl:when test="@valid = 'false'"></xsl:when>
		
		<xsl:otherwise>
		<xsl:variable name="info" select="//xhtml:div[@class='section base-4 entry-view']" />
		<xsl:variable name="web-download"
		select="//xhtml:div[@id='pagehead']//xhtml:a[@class='action download']" />
		
		<details web-id="{$url-show}">
			<overview>
				<xsl:copy-of select="$info//xhtml:div[@class='subsection compound']" />
			</overview>
			<versions>
				
				<xsl:if test="$web-download">
					<web-download>
						<xsl:value-of select="$web-download/@href" />
					</web-download>
				</xsl:if>
				
				<xsl:if
				test="$info//xhtml:div[@class='subsection compound']/xhtml:h3[text() = 'Repository']">
					<xsl:variable name="github-repo">
					
						<xsl:call-template name="get-repo-info">
							<xsl:with-param name="url"
							select="$info//xhtml:div[@class='subsection compound']/xhtml:p[last() -1]/xhtml:a/text()" />
						</xsl:call-template>
					
					</xsl:variable>
					
					<xsl:variable name="repo" select="exsl:node-set($github-repo)" />
					
					<xsl:if test="not($repo/repo-info/error)">
						<xsl:copy-of
						select="document(
							concat($root, '/github-api/', $repo/repo-info/user, '/', $repo/repo-info/path, '/')
							)" />
					</xsl:if>
					
				</xsl:if>
			</versions>
		</details>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>




<xsl:template match="//objects-utilities-details">
	<xsl:choose>
		<xsl:when test="@valid = 'false'"></xsl:when>
		
		<xsl:otherwise>
		<xsl:variable name="info" select="//xhtml:div[@class='section base-4 entry-view']" />
		
		<details web-id="{$url-show}">
			<overview>
				<xsl:copy-of select="$info//xhtml:div[@class='subsection complex']" />
			</overview>
		</details>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>





<xsl:template name="build-url">
	<xsl:param name="show" select="''" />
	<xsl:param name="what" select="''" />
	<xsl:param name="shown" select="false()" />
	<xsl:param name="web-id" select="''" />
	<xsl:param name="msg-show" select="'Show Me!'" />
	<xsl:param name="msg-hide" select="'Hide Me!'" />

	<a>
	<xsl:attribute name="href">
		<xsl:value-of select="concat($root,'/')"/>
		
		<xsl:if test="$root-page != $current-page">
		<xsl:value-of select="$root-page" />/</xsl:if>
		
		<xsl:value-of select="concat($current-page,'/')"/>
		
		<xsl:if test="$category"><xsl:value-of select="$category" />/</xsl:if>
		<xsl:if test="$page"><xsl:value-of select="$page" />/</xsl:if>
		
		<xsl:if test="not($shown) or $url-query">?</xsl:if>
	
		<xsl:if test="not($shown)">
			<xsl:text>show=</xsl:text>
			<xsl:value-of select="$web-id" />
			<xsl:text>&amp;what=</xsl:text>
			<xsl:value-of select="$what" />
			
			<xsl:if test="$url-query">&amp;</xsl:if>
		</xsl:if>
		
		<xsl:if test="$url-query">
			<xsl:text>query=</xsl:text>
			<xsl:value-of select="$url-query" />
		</xsl:if>
		
		<xsl:text>#</xsl:text>
		<xsl:value-of select="$web-id" />
		
	</xsl:attribute>

	<xsl:choose>
		<xsl:when test="$shown">
			<xsl:value-of select="$msg-hide" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$msg-show" />
		</xsl:otherwise>
	</xsl:choose>
	</a>
</xsl:template>





<xsl:template name="get-repo-info">
	<xsl:param name="url" />
	
	<repo-info>
	<!-- <xsl:variable name="repo"
			select="regexp:match($url, '(.*)github.com\/([a-zA-Z0-9_\-\.]+)\/([a-zA-Z0-9_\-\.]+)')" />
			-->
	<xsl:choose>
		<xsl:when test="contains($url, 'github.com')">
			<xsl:variable name="temp" select="str:split($url, 'ithub.com/')[2]" />
			<xsl:variable name="repo" select="str:split($temp, '/')" />
			
			<user><xsl:value-of select="$repo[1]" /></user>
			<path><xsl:value-of select="str:replace($repo[2], '.git', '')" /></path>
		</xsl:when>
		
		<xsl:otherwise>
			<error>Not a github repo</error>
		</xsl:otherwise>
	</xsl:choose>
	
	</repo-info>

</xsl:template>





<xsl:template name="get-web-id">
	<xsl:param name="url" />
	<xsl:value-of select="str:split($url, '/')[last()]" />
</xsl:template>



<xsl:template name="flatten">
	<xsl:param name="nodes" />
	
	<xsl:for-each select="$nodes" >
		<ref label="{@handle}" commit="{.}">
			<xsl:value-of select="@handle" />
		</ref>
	</xsl:for-each>
</xsl:template>




<xsl:template name="options">
	<xsl:param name="label" />
	<xsl:param name="nodes" />
	<xsl:param name="user" select="''" />
	<xsl:param name="path" select="''" />
	<xsl:param name="selected" select="''" />
	
	<optgroup label="{$label}">
	
	<xsl:for-each select="$nodes">
		<option value="{$label}|{$user}|{$path}|{.}">
			<xsl:if test="$selected = concat($label,'|',$user,'|',$path,'|',.)">
				<xsl:attribute name="selected">selected</xsl:attribute>
			</xsl:if>
			
			<xsl:value-of select="." />
		</option>
	</xsl:for-each>
	
	</optgroup>

</xsl:template>

<xsl:template name="version">
	<xsl:param name="string" />
	
	<xsl:variable name="tokens" select="str:split($string, '|')" />
	<xsl:choose>
		<xsl:when test="count($tokens) = 0">No source selected</xsl:when>
		<xsl:otherwise>
			
			<xsl:choose>
				<xsl:when test="$tokens[1] = 'Website'">Website Download</xsl:when>
				<xsl:otherwise>
					
					<xsl:value-of select="$tokens[4]" />
					<xsl:text>@github</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
</xsl:stylesheet>
