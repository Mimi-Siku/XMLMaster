import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;

public class MasterUE {
	
	boolean inUE = false;
	
	public void parseXmlFile(String fileName) throws Exception
	{
	    // Cr�ation des constructeurs de documents
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder parser = factory.newDocumentBuilder();
		// R�cup�ration des noms des UE
	    Document doc = parser.parse(fileName);
	    Document docUE = parser.newDocument();
	    
	    Element racine = docUE.createElement("UE");
	    printTree(doc, docUE, racine);
	    docUE.appendChild(racine);
		
	    // Cr�ation des transformateurs
	    TransformerFactory myFactory = TransformerFactory.newInstance();
		Transformer transformer = myFactory.newTransformer();
		// S�rialisation du r�sultat sur la sortie standard
		DOMSource ueDOMsrc = new DOMSource(docUE);
		StreamResult ueDOM = new StreamResult(System.out);
        transformer.setOutputProperty(OutputKeys.VERSION, "1.0");
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        transformer.setOutputProperty(OutputKeys.STANDALONE, "yes");
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
		transformer.transform(ueDOMsrc, ueDOM);
		
	}
	
	public void printTree(Node n, Document m, Element racine)
	{		
	    if (n instanceof Element)
	    {
	    	if (n.getNodeName() == "UE")
	    	{
	    		inUE = true;
		        printTrees(n.getChildNodes(), m,racine);
	    	}
	    	else if (inUE && n.getNodeName() == "nom")
	    	{
	    		final Element nom = m.createElement(n.getNodeName());
	    		racine.appendChild(nom);
	    		Text text = m.createTextNode(n.getTextContent());
	    		nom.appendChild(text);
	    		inUE = false;
	    	}
	    	else
	    	{
	    		printTrees(n.getChildNodes(), m,racine);
	    	}
	    }
	    else if (n instanceof Document)
	    {
	        printTrees(n.getChildNodes(), m,racine);
	    }

	}
	
	public void printTrees(NodeList nodes, Document m, Element racine)
	{
	    for (int i = 0; (i < nodes.getLength()); i++)
	    {
	        printTree(nodes.item(i), m, racine);
	    }
	}
	
	public static void main(String[] args) throws Exception
	{
		MasterUE scd = new MasterUE();
		scd.parseXmlFile("../master.xml");
	}
}
