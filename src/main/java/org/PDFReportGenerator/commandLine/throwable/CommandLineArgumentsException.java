package org.PDFReportGenerator.commandLine.throwable;

/**
 * Исключение, генерация которого предполагется при возникновении исключительных
 * ситуаций при работе с аргументами командной строки.
 */
public class CommandLineArgumentsException extends Exception{

    public CommandLineArgumentsException(String message){
        super(message);
    }

}
