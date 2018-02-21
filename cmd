xmllint --valid --noout master.xml

xsltproc -o master.html master.xsl master.xml

rm *.html
