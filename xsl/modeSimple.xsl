<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	version="2.0">

	<xsl:template match="//UE">
		<xsl:for-each select=".">
			<xsl:result-document href="{@id}.html" format="general">
				<html>
					<xsl:call-template name="head"/>
					<body>
						<xsl:call-template name="menu"/>
						<xsl:call-template name="fiches_UE">
							<xsl:with-param name="idUE">
								<xsl:value-of select="@id"/>
							</xsl:with-param>
						</xsl:call-template>
					</body>
				</html>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="//enseignant">
		<xsl:for-each select=".">
			<xsl:result-document href="{@id}.html" format="general">
				<html>
					<xsl:call-template name="head"/>
					<body>
						<xsl:call-template name="menu"/>
						<xsl:call-template name="fiches_enseignants">
							<xsl:with-param name="idEns">
								<xsl:value-of select="@id"/>
							</xsl:with-param>
						</xsl:call-template>
					</body>
				</html>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="//parcours">
		<xsl:for-each select=".">
			<xsl:result-document href="{@id}.html" format="general">
				<html>
					<xsl:call-template name="head"/>
					<body>
						<xsl:call-template name="menu"/>
						<xsl:call-template name="fiches_parcours">
							<xsl:with-param name="idParc">
								<xsl:value-of select="@id"/>
							</xsl:with-param>
						</xsl:call-template>
					</body>
				</html>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
