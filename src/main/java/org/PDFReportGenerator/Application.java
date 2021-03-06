package org.PDFReportGenerator;

import java.io.*;
import java.util.List;
import java.util.Map;

import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import org.PDFReportGenerator.commandLine.CommandLineParser;
import org.PDFReportGenerator.commandLine.Parameter;
import org.PDFReportGenerator.configuration.spring.Main;
import org.PDFReportGenerator.commandLine.throwable.CommandLineArgumentsException;
import org.apache.fop.apps.*;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.core.env.Environment;
import org.xml.sax.SAXException;


/**
 * @author Savchenko Kirill
 * @version 1.0
 *
 * Класс-контейнер для точки входа программы.
 */
public class Application {

    private final static Parameter[] commandLineParameters =
            {
                    new Parameter(1, 1, true, "ISU"),
                    new Parameter(1, 1, true, "IXU"),
                    new Parameter(1, 1, true, "OU"),
                    new Parameter(1, 3, false, "FCU"),
                    new Parameter(1, 1, false, "f"),
                    new Parameter(0, 2, true, "EM")
            };

    private static final String inputXSLURI;
    private static final String inputXMLURI;
    private static final String outputURI;
    private static final String fopConfigURI;

    private static final Environment springApplicationMainEnvironment;
    private static final AnnotationConfigApplicationContext springApplicationContext;
    private static Map<Parameter, List<String>> parameters;

    static {
        springApplicationContext = new AnnotationConfigApplicationContext(Main.class);
        springApplicationMainEnvironment = (Environment) springApplicationContext.getBean("springApplicationMainEnvironment");
        inputXSLURI = springApplicationMainEnvironment.getProperty("inputXSLURI");
        inputXMLURI = springApplicationMainEnvironment.getProperty("inputXMLURI");
        outputURI = springApplicationMainEnvironment.getProperty("outputURI");
        fopConfigURI = springApplicationMainEnvironment.getProperty("fopConfigURI");
    }


    public static void main(String[] args) throws CommandLineArgumentsException {

        CommandLineParser commandLineParser = new CommandLineParser(commandLineParameters, args);
        parameters = commandLineParser.parseCommandLineArguments();
        for (Parameter parameter : parameters.keySet()) {
            System.out.printf("Parameter : %s, Values : %s\n", parameter.getName(), parameters.get(parameter));
        }

        try {
            convertToPDF();
        } catch (FOPException | IOException | TransformerException exception) {
            exception.printStackTrace();
        }
    }

    /**
     * Method that will convert the given XML to PDF
     *
     * @throws IOException
     * @throws FOPException
     * @throws TransformerException
     */
    private static void convertToPDF() throws IOException, FOPException, TransformerException {

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
        } catch (IOException e) {
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
}