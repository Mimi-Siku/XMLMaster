<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	version="2.0">

	<xsl:template name="fiches_enseignants">
		<xsl:param name="idEns" as="xs:string" required="yes"/>
		<h1 id="{$idEns}"><xsl:value-of select="nom"/></h1>
		<ul class="info">
			<li><xsl:value-of select="adrElec"/></li>
			<li><xsl:value-of select="adrSite"/></li>
		</ul>
		<h2>Unités d'enseignement</h2>
		<ul class="info">
			<xsl:for-each select="key('ueParInterv', $idEns)">
				<li><a class="infoLink" href="{@id}.html"><xsl:value-of select="nom"/></a></li>
			</xsl:for-each>
		</ul>
		<h2>Parcours</h2>
		<ul class="info">
			<xsl:for-each select="key('parcParInterv', $idEns)">
			<li><a class="infoLink" href="{@id}.html"><xsl:value-of select="nom"/></a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>

  <xsl:template name="fiches_UE">
		<xsl:param name="idUE" as="xs:string" required="yes"/>
	  <h1 id="{$idUE}">Unités d'enseignement : <xsl:value-of select="nom"/></h1>
		<xsl:variable name="resume" select="resume"/>
	  <p><xsl:copy-of select="resume/node()"/></p>
	  <p>
			<ul class="info">
			  <li><b>Responsable : </b><a class="infoLink" href="{ref-responsable/@ref}.html"><xsl:value-of select="id(ref-responsable/@ref)/nom"/></a></li>
			  <li><b>Nombre de crédits : </b><xsl:value-of select="nbCredits"/></li>
			  <li><b>Plan : </b><xsl:value-of select="plan"/></li>
			  <li><b>Lieu d'enseignement : </b><xsl:value-of select="lieu"/></li>
			</ul>
	  </p>
	  <h2>Parcours</h2>
	  <ul class="info">
		<xsl:for-each select="key('parcParUE', $idUE)">
		  <li><a class="infoLink" href="{@id}.html"><xsl:value-of select="nom"/></a></li>
		</xsl:for-each>
	  </ul>
  </xsl:template>

  <xsl:template name="fiches_parcours">
		<xsl:param name="idParc" as="xs:string" required="yes"/>
	  <h1 id="{$idParc}">Parcours : <xsl:value-of select="nom"/></h1>
	  <p>
			<ul class="info">
			  <li><b>Responsable : </b><a class="infoLink" href="{ref-responsable/@ref}.html"><xsl:value-of select="id(ref-responsable/@ref)/nom"/></a></li>
			  <li><b>Description : </b><xsl:value-of select="description"/></li>
			  <li><b>Debouches : </b><xsl:value-of select="debouches"/></li>
			</ul>
	  </p>
	  <div class="decalage">
			<xsl:apply-templates select="semestre"/>
		</div>
  </xsl:template>

  <xsl:template match="semestre">
	<xsl:for-each select=".">
	  <h2>Semestre<xsl:value-of select="nom"/></h2>
	  <xsl:for-each select="bloc">
		<div class="decalage">
			<h3>Bloc</h3>
			<p><b>Role : </b><xsl:value-of select="role"/></p>
			<h4>Unités d'enseignement</h4>
			<p>
			  <ul class="info">
					<xsl:for-each select="ref-UE">
					  <xsl:variable name="idUE" select="@ref" as="xs:string"/>
					  <li><a class="infoLink" href="{$idUE}.html"><xsl:value-of select="id(@ref)/nom"/></a></li>
					</xsl:for-each>
			  </ul>
			</p>
		</div>
	  </xsl:for-each>
	</xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
