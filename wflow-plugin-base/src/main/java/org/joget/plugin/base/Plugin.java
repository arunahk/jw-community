package org.joget.plugin.base;

import java.util.Map;

public interface Plugin {

    String getName();
    
    String getI18nLabel();

    String getVersion();

    String getI18nDescription();
    
    String getDescription();

    PluginProperty[] getPluginProperties();

    /**
     * 
     * @param pluginProperties Properties to be used by the plugin during execution
     * @return
     */
    Object execute(Map properties);
}
