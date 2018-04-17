package com.suyin.utils;

import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

import org.springframework.core.io.FileSystemResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;


public class SystemPropertiesHolder{

    public static Resource resource;

    public static Properties props;

    static
    {
        resource = new FileSystemResourceLoader().getResource("classpath:config/system.properties");
        try
        {
            props = PropertiesLoaderUtils.loadProperties(resource);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    public static String get(String key)
    {
        return props.getProperty(key);
    }
	
}
