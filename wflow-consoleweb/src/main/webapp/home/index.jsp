<%@page import="org.joget.workflow.util.WorkflowUtil"%>
<%@ page import="org.joget.apps.app.service.MobileUtil"%>
<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="0; url=../web/desktop">
        <link rel="shortcut icon" href="../images/v3/joget.ico"/>
        <c:set var="mobileDisabled" value="<%= MobileUtil.isMobileDisabled() %>"/>
        <c:if test="${!mobileDisabled}">
        <script src="../mobile/mobile.js"></script>
        <script>
            var url = "../web/mobile";
            Mobile.directToMobileSite(url);
        </script>
        </c:if>
    </head>
    <body id="splash">
    </body>
</html>
