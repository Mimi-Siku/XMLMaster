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


  	<xsl:template name="generate-UE">
  		<xsl:for-each select="//UE">
  			<xsl:document href="{@id}.html" method="xml" indent="yes" xml-declaration="no" encoding="iso-8859-1">
  				<xsl:call-template name="fiches_UE">
  					<xsl:with-param name="idUE">
  						<xsl:value-of select="@id"/>
  					</xsl:with-param>
  				</xsl:call-template>
  			</xsl:document>
  		</xsl:for-each>
  	</xsl:template>

  	<xsl:template match="//enseignant">
  		<xsl:for-each select=".">
  			<xsl:document href="{@id}.html" method="xml" indent="yes" xml-declaration="no" encoding="iso-8859-1">
  				<xsl:call-template name="fiches_enseignants">
  					<xsl:with-param name="idEns">
  						<xsl:value-of select="@id"/>
  					</xsl:with-param>
  				</xsl:call-template>
  			</xsl:document>
  		</xsl:for-each>
  	</xsl:template>

  		<xsl:template name="generate-parcours">
  			<xsl:for-each select="//parcours">
  				<xsl:document href="{@id}.html" method="xml" indent="yes" xml-declaration="no" encoding="iso-8859-1">
  					<xsl:call-template name="fiches_parcours">
  						<xsl:with-param name="idParc">
  							<xsl:value-of select="@id"/>
  						</xsl:with-param>
  					</xsl:call-template>
  				</xsl:document>
  			</xsl:for-each>
  		</xsl:template>


    </xsl:stylesheet>
