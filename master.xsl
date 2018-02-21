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

<!--<xsl:preserve-space elements="*"/>-->

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
		<xsl:call-template name="generate-intervenants"/>
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

	<xsl:template name="generate-intervenants">
		<xsl:for-each select="//enseignant">
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




	<xsl:template match="//enseignant">
		<xsl:call-template name="fiches_enseignants">
			<xsl:with-param name="idEns">
				<xsl:value-of select="@id"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

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







	<xsl:template name="fiches_enseignants">
		<xsl:param name="idEns"/>
		<html><body>
			<h3 id="{$idEns}"><xsl:value-of select="nom"/></h3>
			<ul>
				<li><xsl:value-of select="adrElec"/></li>
				<li><xsl:value-of select="adrSite"/></li>
			</ul>
			<h2>Unités d'enseignement</h2>
			<ul>
				<xsl:for-each select="key('ueParInterv', $idEns)">
					<li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
				</xsl:for-each>
			</ul>
			<h2>Parcours</h2>
			<ul>
				<xsl:for-each select="key('parcParInterv', $idEns)">
					<li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
				</xsl:for-each>
			</ul>
		</body></html>
	</xsl:template>

	<xsl:template name="fiches_UE">
		<xsl:param name="idUE"/>
		<html><body>
			<h3 id="{$idUE}">Unités d'enseignement : <xsl:value-of select="nom"/></h3>
			<p><xsl:value-of select="resume"/></p>
			<p>
				<ul>
					<li><b>Responsable : </b><a href="{ref-responsable/@ref}.html"><xsl:value-of select="id(ref-responsable/@ref)/nom"/></a></li>
					<li><b>Nombre de crédits </b><xsl:value-of select="nbCredits"/></li>
					<li><b>Plan </b><xsl:value-of select="plan"/></li>
					<li><b>Lieu d'enseignement </b><xsl:value-of select="lieu"/></li>
				</ul>
			</p>
			<h2>Parcours</h2>
			<ul>
				<xsl:for-each select="key('parcParUE', $idUE)">
					<li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
				</xsl:for-each>
			</ul>
		</body></html>
	</xsl:template>

	<xsl:template name="fiches_parcours">
		<xsl:param name="idParc"/>
		<html><body>
			<h3 id="{$idParc}">Parcours : <xsl:value-of select="nom"/></h3>
			<p>
				<ul>
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
					<ul>
						<li><b>Role : </b><xsl:value-of select="role"/></li>
						<xsl:variable name="idUE" select="ref-UE/@ref"/>
						<li><b>UE </b><a href="{$idUE}.html"><xsl:value-of select="id(ref-UE/@ref)/nom"/></a></li>
					</ul>
				</p>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

<!--eviter les call template, faire plutot des apply template avec mode-->
	<!--
	<a href="#bla">Johan</a>
	<p id="bla">kfjkjkdjfkd</p>
	-->

</xsl:stylesheet>
