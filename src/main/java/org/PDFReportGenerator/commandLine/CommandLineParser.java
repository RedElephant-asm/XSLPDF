package org.PDFReportGenerator.commandLine;

import org.PDFReportGenerator.commandLine.throwable.CommandLineArgumentsException;

import java.util.*;

/**
 * @author Savchenko Kirill
 * @version 1.0
 *
 * Класс, содержащий логику для обработки аргументов командной строки.
 */
public class CommandLineParser {

    /**
     * Указатель на Map, содержащий проверенные параметры, полученные из массива значений, полученного вызывающим кодом из командной строки.
     */
    private Map<Parameter, List<String>> parsedCommandLineArguments;

    /**
     * Указатель на массив возможных параметров, полученный от вызывающего когда.
     */
    private final Parameter[] existingParameters;

    /**
     * Указатель на текущий параметров. Используется для упрощения доступа к текущему параметру, при переборе массива значений,
     * полученного вызывающим кодом из командной строки.
     */
    private Parameter currentParameter;

    public CommandLineParser(Parameter[] existingParameters) {
        this.existingParameters = existingParameters;
    }

    /**
     * Назначением функции является проверка на правильность полученных вызывающим кодом параметров командной строки.
     * @param commandLineParts
     * Массив значений, полученных вызывающим кодов при вызове из командной строки.
     * @return
     * Возвращает Map, который содержит пары "параметр-группа значений".
     * @throws CommandLineArgumentsException
     */
    public Map<Parameter, List<String>> parseCommandLineArguments(String[] commandLineParts) throws CommandLineArgumentsException {
        parsedCommandLineArguments = new LinkedHashMap<>();
        if(commandLineParts[0].charAt(0) != '-') {
            throw new CommandLineArgumentsException("Nameless arguments not allowed.");
        }

        for (int partCounter = 0; partCounter < commandLineParts.length; partCounter++) {
            if (commandLineParts[partCounter].charAt(0) == '-') {
                addNewParameter(commandLineParts[partCounter]);
                if (commandLineParts[partCounter + 1].charAt(0) == '-' && !this.isCurrentParameterValuesCountAcceptable()){

                    throw new CommandLineArgumentsException(
                            String.format("Wrong values count for \"%s\". Expected : more than %d & less than %d. Received : %d.",
                                    currentParameter.getName(), currentParameter.getMaximalCountOfValues(), currentParameter.getMinimalCountOfValues(), this.parsedCommandLineArguments.get(currentParameter).size()));
                }
            } else {
                this.parsedCommandLineArguments.get(currentParameter).add(commandLineParts[partCounter]);
                if ( (partCounter == commandLineParts.length - 1 || commandLineParts[partCounter + 1].charAt(0) == '-') && !this.isCurrentParameterValuesCountAcceptable()){

                    throw new CommandLineArgumentsException(
                            String.format("Wrong values count for \"%s\". Expected : more than %d & less than %d. Received : %d.",
                                    currentParameter.getName(), currentParameter.getMaximalCountOfValues(), currentParameter.getMinimalCountOfValues(), this.parsedCommandLineArguments.get(currentParameter).size()));
                }
            }
        }

        if (isMinimalParameterSet()){
            return parsedCommandLineArguments;
        }

        throw new CommandLineArgumentsException("Three argument required.");
    }

    /**
     * Назначением функции является добавление параметра в Map, содержащий уже проверенные параметры.
     * @param parameterName
     * Имя добавляемого параметра.
     * @throws CommandLineArgumentsException
     */
    private void addNewParameter(String parameterName) throws CommandLineArgumentsException {
        currentParameter = getParameterByName(parameterName.substring(1));
        if (parsedCommandLineArguments.containsKey(currentParameter)){
            throw new CommandLineArgumentsException(String.format("Multiple -%s parameter not allowed.", parameterName));
        }
        parsedCommandLineArguments.put(currentParameter, new ArrayList<>());
    }

    /**
     * Назначением функции является проверка на правильность количества значений для текущего параметра.
     * @return
     * true, если количество параметров соответствует предусмотреному для того или иному параметру.
     */
    private boolean isCurrentParameterValuesCountAcceptable(){
        List<String> currentParameterValues = this.parsedCommandLineArguments.get(this.currentParameter);
        return currentParameterValues.size() >= currentParameter.getMinimalCountOfValues() && currentParameterValues.size() <= currentParameter.getMaximalCountOfValues();
    }

    /**
     * Назначением функции является проверка наличия всех обязательных параметров в списке параметров,
     * полученных вызывающим кодом параметров командной строки.
     * @return
     * true, если подтверждено наличие всех обязательных параметров.
     */
    private boolean isMinimalParameterSet(){
        for (Parameter parameter : existingParameters) {
            if (parameter.isRequired() && !this.parsedCommandLineArguments.containsKey(parameter)){
                return false;
            }
        }
        return true;
    }

    /**
     * Назначением функции является поиск параметра в массиве возможных параметров,
     * полученном от вызывающего кода.
     * @param parameterName
     * Имя параметра.
     * @return
     * Указатель на объект класса Parameter, если таковой существует в массиве возможных параметров.
     * @throws CommandLineArgumentsException
     */
    private Parameter getParameterByName(String parameterName) throws CommandLineArgumentsException{
        for (Parameter parameter : existingParameters) {
            if (parameterName.equalsIgnoreCase(parameter.getName())){
                return parameter;
            }
        }
        throw new CommandLineArgumentsException(String.format("Unknown parameter : %s.", parameterName));
    }
}