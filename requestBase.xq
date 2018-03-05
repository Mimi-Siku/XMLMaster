declare option saxon:output "indent=yes";

<resultat>
{
    for
        $jour in doc("siecle.xml")//jour,
        $y in (3,2,1)
    let $numero := ($jour/numero - 1)
    let $nom := $jour/nom
    let $annee := $jour/../../numero
    where ($numero < 2) and ($annee = (1910, 1930, 1999))
    order by $numero, $nom
    return
        <item>
            {attribute id {$jour/@id}}
            {$nom}
        </item>
}
</resultat>
