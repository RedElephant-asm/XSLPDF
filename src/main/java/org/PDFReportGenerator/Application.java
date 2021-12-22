package org.PDFReportGenerator;

import java.io.*;

import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.PDFReportGenerator.configuration.spring.Main;
import org.apache.fop.apps.*;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.core.env.Environment;
import org.xml.sax.SAXException;

public class Application {

    private static final String     inputXSLURI;
    private static final String     inputXMLURI;
    private static final String     outputURI;
    private static final String     fopConfigURI;

    private static final Environment                            springMainEnvironment;
    private static final AnnotationConfigApplicationContext     springApplicationContext;

    static {
        springApplicationContext = new AnnotationConfigApplicationContext(Main.class);
        springMainEnvironment = (Environment) springApplicationContext.getBean("springMainEnvironment");
        inputXSLURI = springMainEnvironment.getProperty("inputXSLURI");
        inputXMLURI = springMainEnvironment.getProperty("inputXMLURI");
        outputURI = springMainEnvironment.getProperty("outputURI");
        fopConfigURI = springMainEnvironment.getProperty("fopConfigURI");
    }


    public static void main(String[] args) {
        try {
            convertToPDF();
        } catch (FOPException | IOException | TransformerException exception) {
            exception.printStackTrace();
        }
    }

    /**
     * Method that will convert the given XML to PDF
     * @throws IOException
     * @throws FOPException
     * @throws TransformerException
     */
    private static void convertToPDF()  throws IOException, FOPException, TransformerException {

        File fopConfigFile = new File(fopConfigURI);

        // the XSL FO file
        File xsltFile = new File(inputXSLURI);
        StreamSource xmlSource = new StreamSource(new File(inputXMLURI));

        // create an instance of fop factory
        FopFactory fopFactory = null;
        try {
            fopFactory = FopFactory.newInstance(new File(".").toURI(), new FileInputStream(fopConfigFile));
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (IOException e){
            e.printStackTrace();
        }

        // a user agent is needed for transformation
        FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
        // Setup output
        OutputStream out = new FileOutputStream(outputURI + "test.pdf");

        try {
            // Construct fop with desired output format
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);

            // Setup XSLT
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer(new StreamSource(xsltFile));

            // Resulting SAX events (the generated FO) must be piped through to FOP
            Result res = new SAXResult(fop.getDefaultHandler());

            // Start XSLT transformation and FOP processing
            // That's where the XML is first transformed to XSL-FO and then
            // PDF is created
            transformer.transform(xmlSource, res);
        } finally {
            out.close();
        }
    }

//    /**
//     * This method will convert the given XML to XSL-FO
//     * @throws IOException
//     * @throws FOPException
//     * @throws TransformerException
//     */
//    public void convertToFO()  throws IOException, FOPException, TransformerException {
//        // the XSL FO file
//        File xsltFile = new File(inputXSLURI);
//        StreamSource xmlSource = new StreamSource(new File(inputXMLURI));
//
//        /*TransformerFactory factory = TransformerFactory.newInstance();
//        Transformer transformer = factory.newTransformer(new StreamSource
//          ("F:\\Temp\\template.xsl"));*/
//
//        // the XML file which provides the input
//
//        // a user agent is needed for transformation
//        /*FOUserAgent foUserAgent = fopFactory.newFOUserAgent();*/
//        // Setup output
//        OutputStream out;
//
//        out = new java.io.FileOutputStream("temp.fo");
//
//        try {
//            // Setup XSLT
//            TransformerFactory factory = TransformerFactory.newInstance();
//            Transformer transformer = factory.newTransformer(new StreamSource(xsltFile));
//
//            // Resulting SAX events (the generated FO) must be piped through to FOP
//            //Result res = new SAXResult(fop.getDefaultHandler());
//
//            Result res = new StreamResult(out);
//
//            //Start XSLT transformation and FOP processing
//            transformer.transform(xmlSource, res);
//
//
//            // Start XSLT transformation and FOP processing
//            // That's where the XML is first transformed to XSL-FO and then
//            // PDF is created
//            transformer.transform(xmlSource, res);
//        } finally {
//            out.close();
//        }
//    }
}