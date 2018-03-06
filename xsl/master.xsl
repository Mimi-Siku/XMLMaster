<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	version="2.0">

	<xsl:include href="modeRef.xsl"/>
	<xsl:include href="modeSimple.xsl"/>
	<xsl:include href="fiches.xsl"/>

	<xsl:output
 		name="general"
		method="xml"
		version="1.1"
		encoding="iso-8859-1"
		indent="yes"
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
		<xsl:apply-templates select="//UE"/>
		<xsl:apply-templates select="//enseignant"/>
		<xsl:apply-templates select="//parcours"/>
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
		<xsl:param name="page-name" as="xs:string" required="yes" />
		<xsl:result-document href="{$page-name}.html" format="general">
			<html>
				<xsl:call-template name="head"/>
				<body>
					<xsl:call-template name="menu"/>
					<xsl:choose>
						<xsl:when test="$page-name = 'unites'">
								<div class="belowMenu"><xsl:apply-templates select="//UE" mode="ref"/></div>
						</xsl:when>
						<xsl:when test="$page-name = 'intervenants'">
								<div class="belowMenu"><xsl:apply-templates select="//enseignant" mode="ref"/></div>
						</xsl:when>
						<xsl:when test="$page-name = 'index'">
								<div class="belowMenu">Bonjour ! <br/> Vous voulez des renseignements sur le master informatique de l'université d'Aix-Marseille ? Vous voilà au bon endroit !</div>
						</xsl:when>
						<xsl:otherwise>
							<div class="belowMenu">I'm sorry but this page should not be called "<xsl:value-of select="$page-name"/>".</div>
						</xsl:otherwise>
					</xsl:choose>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>

	<xsl:template name="menu">
		<ul id="menu">
			<li><a class="menuLink" href="index.html">Accueil</a></li>
			<li><a class="menuLink" href="unites.html">Unités d'enseignements</a></li>
			<li><a class="menuLink" href="intervenants.html">Intervenants</a></li>
		</ul>
	</xsl:template>

	<xsl:template name="head">
		<head>
			<title>Master informatique Aix-Marseille Université</title>
			<link rel="stylesheet" href="master.css" />
		</head>
	</xsl:template>

</xsl:stylesheet>
