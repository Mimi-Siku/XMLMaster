<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	version="2.0">

	<xsl:template name="fiches_enseignants">
		<xsl:param name="idEns" as="xs:string" required="yes"/>
		<h3 id="{$idEns}"><xsl:value-of select="nom"/></h3>
		<ul class="info">
			<li><xsl:value-of select="adrElec"/></li>
			<li><xsl:value-of select="adrSite"/></li>
		</ul>
		<h2>Unités d'enseignement</h2>
		<ul class="info">
			<xsl:for-each select="key('ueParInterv', $idEns)">
				<li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
			</xsl:for-each>
		</ul>
		<h2>Parcours</h2>
		<ul class="info">
			<xsl:for-each select="key('parcParInterv', $idEns)">
			<li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>

  <xsl:template name="fiches_UE">
	<xsl:param name="idUE" as="xs:string" required="yes"/>
	<html><body>
	  <h3 id="{$idUE}">Unités d'enseignement : <xsl:value-of select="nom"/></h3>
	  <p><xsl:value-of select="resume"/></p>
	  <p>
		<ul class="info">
		  <li><b>Responsable : </b><a href="{ref-responsable/@ref}.html"><xsl:value-of select="id(ref-responsable/@ref)/nom"/></a></li>
		  <li><b>Nombre de crédits </b><xsl:value-of select="nbCredits"/></li>
		  <li><b>Plan </b><xsl:value-of select="plan"/></li>
		  <li><b>Lieu d'enseignement </b><xsl:value-of select="lieu"/></li>
		</ul>
	  </p>
	  <h2>Parcours</h2>
	  <ul class="info">
		<xsl:for-each select="key('parcParUE', $idUE)">
		  <li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
		</xsl:for-each>
	  </ul>
	</body></html>
  </xsl:template>

  <xsl:template name="fiches_parcours">
	<xsl:param name="idParc" as="xs:string" required="yes"/>
	<html><body>
	  <h3 id="{$idParc}">Parcours : <xsl:value-of select="nom"/></h3>
	  <p>
		<ul class="info">
		  <li><b>Responsable : </b><a href="{ref-responsable/@ref}.html"><xsl:value-of select="id(ref-responsable/@ref)/nom"/></a></li>
		  <li><b>Description </b><xsl:value-of select="description"/></li>
		  <li><b>Debouches </b><xsl:value-of select="debouches"/></li>
		</ul>
	  </p>
	  <xsl:apply-templates select="semestre"/>
	</body></html>
  </xsl:template>

  <xsl:template match="semestre">
	<xsl:for-each select=".">
	  <h3>Semestre : <xsl:value-of select="nom"/></h3>
	  <xsl:for-each select="bloc">
		<p>
		  <ul class="info">
			<li><b>Role : </b><xsl:value-of select="role"/></li>
			<xsl:for-each select="ref-UE">
			  <xsl:variable name="idUE" select="@ref" as="xs:string"/>
			  <li><b>UE </b><a href="{$idUE}.html"><xsl:value-of select="id(@ref)/nom"/></a></li>
			</xsl:for-each>
		  </ul>
		</p>
	  </xsl:for-each>
	</xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
