package com.zhongxin.cims.common.listener;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class StartupListener implements ServletContextListener {


    @Override
    public void contextInitialized(ServletContextEvent sce) {
        sce.getServletContext().setAttribute("Constants", new JspConstants());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
