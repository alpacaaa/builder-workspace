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
				<xsl:for-each select="//store/key[@handle = 'Extension']/key">
					<xsl:call-template name="show-install">
						<xsl:with-param name="nodes" select="." />
						<xsl:with-param name="type" select="'Extension'" />
						<xsl:with-param name="objects" select="//objects-extensions" />
					</xsl:call-template>
				</xsl:for-each>
			</tbody>
		</table>
	</div>

</xsl:template>
</xsl:stylesheet>
