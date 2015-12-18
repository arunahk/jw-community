package org.joget.commons.util;

import java.io.File;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

/**
 * Utility methods used by the system to manage cloud profile
 * 
 */
@Service
public class HostManager implements ApplicationContextAware {

    public static final String SYSTEM_PROPERTY_VIRTUALHOST = "wflow.virtualhost";

    protected static final ThreadLocal currentHost = new ThreadLocal();
    protected static final ThreadLocal currentProfile = new ThreadLocal();
    protected static String contextPath;

    /**
     * Sets the Host of current HTTP request.
     * This method is security protected in Cloud installation.
     * @param hostname 
     */
    public static void setCurrentHost(String hostname) {
        currentHost.set(hostname);
    }

    /**
     * Gets the current Host of HTTP request
     * @return 
     */
    public static String getCurrentHost() {
        if (isVirtualHostEnabled()) {
            String hostname = (String)currentHost.get();
            return hostname;
        }
        else {
            return null;
        }
    }

    /**
     * Sets the profile of current HTTP request.
     * This method is security protected in Cloud installation.
     * @param profile 
     */
    public static void setCurrentProfile(String profile) {
        currentProfile.set(profile);
        setCurrentHost(null);
    }

    /**
     * Gets the current cloud profile of HTTP request
     * @return 
     */
    public static String getCurrentProfile() {
        String profile = (String) currentProfile.get();
        return profile;
    }

    /**
     * Flag to indicate it is a Cloud installation
     * @return 
     */
    public static boolean isVirtualHostEnabled() {
        boolean enabled = Boolean.valueOf(System.getProperty(SYSTEM_PROPERTY_VIRTUALHOST));
        return enabled;
    }

    /**
     * Gets the context path of the HTTP request
     * @return 
     */
    public static String getContextPath() {
        return contextPath;
    }

    /**
     * Method used by system to set Application Context. 
     * This method is security protected in Cloud installation.
     * @param appContext
     * @throws BeansException 
     */
    public void setApplicationContext(ApplicationContext appContext) throws BeansException {
        if (appContext instanceof WebApplicationContext) {
            String realContextPath = ((WebApplicationContext)appContext).getServletContext().getRealPath("/");
            String cPath = "/jw";
            if (realContextPath != null) {
                File contextPathFile = new File(realContextPath);
                cPath = contextPathFile.getName();
                if (!cPath.startsWith("/")) {
                    cPath = "/" + cPath;
                }
            }
            HostManager.contextPath = cPath;
        }
    }

}
