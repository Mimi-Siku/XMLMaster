<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">

  <xsl:output
 		name="general"
    method="xml"
    version="1.1"
    encoding="iso-8859-1"
    indent="yes"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  />

	<xsl:template match="//UE">
		<xsl:for-each select=".">
			<xsl:result-document href="{@id}.html" format="general">
				<xsl:call-template name="fiches_UE">
					<xsl:with-param name="idUE">
						<xsl:value-of select="@id"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="//enseignant">
		<xsl:for-each select=".">
			<xsl:result-document href="{@id}.html" format="general">
				<xsl:call-template name="fiches_enseignants">
					<xsl:with-param name="idEns">
						<xsl:value-of select="@id"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

		<xsl:template match="//parcours">
			<xsl:for-each select=".">
				<xsl:result-document href="{@id}.html" format="general">
					<xsl:call-template name="fiches_parcours">
						<xsl:with-param name="idParc">
							<xsl:value-of select="@id"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:result-document>
			</xsl:for-each>
		</xsl:template>

</xsl:stylesheet>
