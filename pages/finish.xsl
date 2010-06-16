<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml">


<xsl:import href="../utilities/master.xsl" />


<xsl:param name="url-build"/>

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/data">
	<xsl:choose>
		<xsl:when test="$url-build = 'complete'">
			<div class="build">
				<p>Your build should be completed.</p>
				<p><em>No</em> money back guarantee.</p>
			</div>
		</xsl:when>
		
		<xsl:otherwise>
		<form action="?save-queue" method="post">
			<div class="what-to-install">
				<h3>What will be installed</h3>
				
				<div class="extensions">
					<h4>Extensions</h4>
					<ul>
						<xsl:apply-templates select="//store/key[@handle = 'Extension']/key" />
					</ul>
				</div>
				<div class="utilities">
					<h4>Utilities</h4>
					<ul>
						<xsl:apply-templates select="//store/key[@handle = 'Utility']/key" />
					</ul>
				</div>
			</div>
			
			<div class="install-settings">
				<!-- <label for="project-name">Project Name</label>
				<input type="text" name="project-name" />-->
			
				<label for="root">Project Root</label>
				<input type="text" name="root" value="{$dirname}" />
			
				<input type="hidden" name="symphony-version" value="{//store/key[@handle = 'symphony-version']}" />
				<input type="submit" name="action[save-queue]" value="Build" />
			</div>
		</form>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="//store/key[@handle = 'Extension']/key">
	<li>
		<h5><xsl:value-of select="key[@handle = 'name']" /></h5>
		<!-- <div><xsl:value-of select="key[@handle = 'description']" /></div> -->
		<div>
			By: <span class="author"><xsl:value-of select="key[@handle = 'author']" /></span>
			<!--<span class="version">
				<xsl:call-template name="version">
					<xsl:with-param name="string" select="key[@handle = 'source']" />
				</xsl:call-template>
			</span>-->
		</div>
		<input type="hidden" name="Extension[{@handle}]" value="{./key[@handle = 'source']}" />
	</li>
</xsl:template>

<xsl:template match="//store/key[@handle = 'Utility']/key">
	<li>
		<h5><xsl:value-of select="key[@handle = 'name']" /></h5>
		<!-- <div><xsl:value-of select="key[@handle = 'description']" /></div> -->
		<div>By: <span class="author"><xsl:value-of select="key[@handle = 'author']" /></span></div>
		<input type="hidden" name="Utility[{@handle}]" value="{./key[@handle = 'name']}" />
	</li>
</xsl:template>



</xsl:stylesheet>
