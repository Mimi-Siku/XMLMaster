declare option saxon:output "indent=yes";

<resultat>
{
    for
        $annee in doc("master.xml")//annee
        for
			$mois in $annee/mois
			for
				$jour in $mois/jour

    let $numero := ($jour/numero - 1)
    let $nom := $jour/nom
    let $numAnnee := $annee/numero
    let $nomMois := $mois/nom
    let $moisNum := $mois/numero
    where ($moisNum = (1, 2))
    return
		<enseignant>
			{attribute id {$jour/@id}}
      <nom>
				{$numAnnee}
			</nom>
			<UE>
        {attribute id {$jour/@id}}
        <nom>
          {$moisNum}
        </nom>
			</UE>
			<parcours>
        <nom>
          {$nom}
        </nom>
		  </parcours>
    </enseignant>

}
</resultat>
