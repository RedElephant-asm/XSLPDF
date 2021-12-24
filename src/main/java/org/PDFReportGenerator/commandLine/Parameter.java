package org.PDFReportGenerator.commandLine;

/**
 * @author Savchenko Kirill
 * @version 1.0
 *
 * Класс является моделью параметра, получемого вызывающим кодом через командную строку.
 */
public class Parameter {

    /**
     * Минимальное количество значний, которое способен содержать данный параметр.
     */
    private final int         minimalCountOfValues;

    /**
     * Максимальное количество значний, которое способен содержать данный параметр.
     */
    private final int         maximalCountOfValues;

    /**
     * Является ли параметр обязательным.
     */
    private final boolean     isRequired;

    /**
     * Имя параметра.
     */
    private final String      name;

    public Parameter(int minimalCountOfValues, int maximalCountOfValues, boolean isRequired, String name){
        this.minimalCountOfValues = minimalCountOfValues;
        this.maximalCountOfValues = maximalCountOfValues;
        this.isRequired = isRequired;
        this.name = name;
    }

    public int getMinimalCountOfValues() {
        return minimalCountOfValues;
    }

    public int getMaximalCountOfValues() {
        return maximalCountOfValues;
    }

    public boolean isRequired() {
        return isRequired;
    }

    public String getName() {
        return name;
    }
}
