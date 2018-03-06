all: dtd xsd web tidy xq

dtd:
	xmllint --valid --noout master.xml

xsd:
	xmllint --schema master.xsd --noout master.xml

web:
	mkdir -p www
	java -cp saxon9/saxon9he.jar -xsl:xsl/master.xsl master.xml

tidy:
	tidy -im -asxhtml -indent www/*.html

xq:
	java -cp saxon9/saxon9he.jar net.sf.saxon.Query "-q:xq.txt"

java:
	mkdir -p java
	java -jar master.jar
