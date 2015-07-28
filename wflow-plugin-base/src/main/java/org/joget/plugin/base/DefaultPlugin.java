package org.joget.plugin.base;

import org.joget.commons.util.ResourceBundleUtil;
import org.joget.plugin.property.model.PropertyEditable;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

public abstract class DefaultPlugin implements Plugin, BundleActivator {

    protected ServiceRegistration registration;

    public void start(BundleContext context) {
        registration = context.registerService(getClass().getName(), this, null);
    }

    public void stop(BundleContext context) {
        registration.unregister();
    }
    
    public String getI18nLabel() {
        String label = ResourceBundleUtil.getMessage(getClass().getName() + ".pluginLabel");
        if (label == null || label.isEmpty()) {
            if (this instanceof PropertyEditable) {
                label = ((PropertyEditable) this).getLabel();
            } else {
                label = getName();
            }
        }
        return label;
    }
    
    public String getI18nDescription() {
        String desc = ResourceBundleUtil.getMessage(getClass().getName() + ".pluginDesc");
        if (desc == null || desc.isEmpty()) {
            desc = getDescription();
        }
        return desc;
    }
}
