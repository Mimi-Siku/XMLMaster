<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

  <xsl:output
    method="xml"
    version="1"
    encoding="iso-8859-1"
    indent="yes"
    xml-declaration="no"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  />

	<xsl:template match="//enseignant" mode="ref">
		<ul>
			<li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
		</ul>
	</xsl:template>

	<xsl:template match="//UE" mode="ref">
		<ul>
			<li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
		</ul>
	</xsl:template>

</xsl:stylesheet>
