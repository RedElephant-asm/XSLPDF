package org.PDFReportGenerator.configuration.spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

/**
 * @author Savchenko Kirill
 * @version 1.0
 *
 * Класс-контейнер для конфигурации Spring.
 */
@Configuration
@PropertySource(value = "classpath:spring.properties", ignoreResourceNotFound = true)
@PropertySource(value = "classpath:/input/args.properties", ignoreResourceNotFound = true)
@ComponentScan("org.PDFReportGenerator")
public class Main {

    @Autowired
    private Environment environment;

    @Bean(name = "springMainEnvironment")
    public Environment environment(){
        return environment;
    }


}
