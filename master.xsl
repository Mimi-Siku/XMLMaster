<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<xsl:include href="generators.xsl"/>
	<xsl:include href="fiches.xsl"/>

	<xsl:output
		method="xml"
		version="1"
		encoding="iso-8859-1"
		indent="yes"
		xml-declaration="no"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	/>

	<xsl:key
		name="ueParInterv"
		match="//UE"
		use="ref-responsable/@ref"
		/>

	<xsl:key
		name="parcParInterv"
		match="//parcours"
		use="ref-responsable/@ref"
		/>

	<xsl:key
		name="parcParUE"
		match="//parcours"
		use="semestre/bloc/ref-UE/@ref"
		/>

	<xsl:template match="/">
		<xsl:call-template name="generate-UE"/>
		<xsl:apply-templates select="//enseignant"/>
		<xsl:call-template name="generate-parcours"/>
		<xsl:call-template name="pages-site">
			<xsl:with-param name="page-name">unites</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pages-site">
			<xsl:with-param name="page-name">intervenants</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pages-site">
			<xsl:with-param name="page-name">index</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="pages-site">
		<xsl:param name="page-name"/>
		<xsl:document href="{$page-name}.html" method="xml" indent="yes" xml-declaration="no" encoding="iso-8859-1">
			<html>
				<head>
					<title>Master informatique Aix-Marseille Université</title>
				</head>
				<body>
					<xsl:call-template name="menu"/>
					<xsl:choose>
						<xsl:when test="$page-name = 'unites'">
								<xsl:apply-templates select="//UE" mode="ref"/>
						</xsl:when>
						<xsl:when test="$page-name = 'intervenants'">
								<xsl:apply-templates select="//enseignant" mode="ref"/>
						</xsl:when>
						<xsl:when test="$page-name = 'index'">
								<p>Bonjour</p>
						</xsl:when>
					</xsl:choose>
				</body>
			</html>
		</xsl:document>
	</xsl:template>

	<xsl:template name="menu">
		<ul>
			<li><a href="index.html">Accueil</a></li>
			<li><a href="unites.html">Unités d'enseignements</a></li>
			<li><a href="intervenants.html">Intervenants</a></li>
		</ul>
	</xsl:template>



<!--
	<xsl:template match="//enseignant">
		<xsl:call-template name="fiches_enseignants">
			<xsl:with-param name="idEns">
				<xsl:value-of select="@id"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
-->
	<xsl:template match="//enseignant" mode="ref">
		<ul>
			<xsl:call-template name="liste_enseignants">
				<xsl:with-param name="href">
					<xsl:value-of select="@id"/>
				</xsl:with-param>
			</xsl:call-template>
		</ul>
	</xsl:template>

	<xsl:template match="//UE">
		<xsl:call-template name="fiches_UE">
			<xsl:with-param name="idUE">
				<xsl:value-of select="@id"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="//UE" mode="ref">
		<ul>
			<xsl:call-template name="liste_UE">
				<xsl:with-param name="href">
					<xsl:value-of select="@id"/>
				</xsl:with-param>
			</xsl:call-template>
		</ul>
	</xsl:template>

	<xsl:template name="liste_enseignants">
		<xsl:param name="href"/>
		<li><a href="{$href}.html"><xsl:value-of select="nom"/></a></li>
	</xsl:template>

	<xsl:template name="liste_UE">
		<xsl:param name="href"/>
		<li><a href="{$href}.html"><xsl:value-of select="nom"/></a></li>
	</xsl:template>


<!--eviter les call template, faire plutot des apply template avec mode-->

</xsl:stylesheet>
