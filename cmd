xmllint --valid --noout master.xml

xsltproc -o master.html master.xsl master.xml

rm *.html

saxon -xsl:siecle.xsl siecle/siecle.xml

java -cp $HOME/saxon9/saxon9he.jar net.sf.saxon.Query "-q:requete.xq"
