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
     * Фрагменты команндной строки, полученные вызывающим кодом.
     */
    private final String[] commandLineFragments;

    /**
     * Указатель на текущий параметров. Используется для упрощения доступа к текущему параметру, при переборе массива значений,
     * полученного вызывающим кодом из командной строки.
     */
    private Parameter currentParameter;

    public CommandLineParser(Parameter[] existingParameters, String[] commandLineFragments) {
        this.existingParameters = existingParameters;
        this.commandLineFragments = commandLineFragments;
    }

    /**
     * Назначением функции является проверка на правильность полученных вызывающим кодом параметров командной строки.
     * @return
     * Возвращает Map, который содержит пары "параметр-группа значений".
     * @throws CommandLineArgumentsException
     */
    public Map<Parameter, List<String>> parseCommandLineArguments() throws CommandLineArgumentsException {
        parsedCommandLineArguments = new LinkedHashMap<>();
        checkStartingCommandLineFragment();
        for (int commandLineFragmentCounter = 0; commandLineFragmentCounter < commandLineFragments.length;) {
            commandLineFragmentCounter = parseCommandLineFragmentAsParameterAndGetNextIndex(commandLineFragmentCounter);
            if (!this.isCurrentParameterValuesCountAcceptable()){
                throw new CommandLineArgumentsException(String.format("Wrong values count for \"%s\". Expected : more or equal than %d & less or equal than %d. Received : %d.", currentParameter.getName(), currentParameter.getMaximalCountOfValues(), currentParameter.getMinimalCountOfValues(), this.parsedCommandLineArguments.get(currentParameter).size()));
            }
        }
        if (isMinimalParameterSet()){
            return parsedCommandLineArguments;
        }
        throw new CommandLineArgumentsException("Insufficient parameter set.");
    }

    public boolean isCommandLineFragmentAParameter(String commandLineFragment){
        return commandLineFragment.charAt(0) == '-';
    }

    public void checkStartingCommandLineFragment() throws CommandLineArgumentsException {
        if(!isCommandLineFragmentAParameter(commandLineFragments[0])) {
            throw new CommandLineArgumentsException("Values without a parameter are not allowed.");
        }
    }

    public int parseCommandLineFragmentAsParameterAndGetNextIndex(int fragmentIndex) throws CommandLineArgumentsException {
        addNewParameter(commandLineFragments[fragmentIndex]);
        for (int commandLineFragmentCounter = fragmentIndex + 1; commandLineFragmentCounter < commandLineFragments.length; commandLineFragmentCounter++){
            if (isCommandLineFragmentAParameter(commandLineFragments[commandLineFragmentCounter])){
                return commandLineFragmentCounter;
            }
            addValueToCurrentParameter(commandLineFragments[commandLineFragmentCounter]);
        }
        return commandLineFragments.length;
    }

    public void addValueToCurrentParameter(String value){
        this.parsedCommandLineArguments.get(currentParameter).add(value);
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