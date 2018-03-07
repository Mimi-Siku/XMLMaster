all: dtd xsd web tidy xq

dtd:
	xmllint --valid --noout master.xml

xsd:
	xmllint --schema master.xsd --noout master.xml

web:
	mkdir -p www
	java -jar saxon9/saxon9he.jar -xsl:xsl/master.xsl master.xml -o:www/master.html

tidy:
	tidy -im -asxhtml -indent www/*.html

xq:
	java -cp saxon9/saxon9he.jar net.sf.saxon.Query "-q:xq.txt" -o:www/xq.html

java:
	java -classpath java/MasterUE.class
	java MasterUE

.PHONY :
