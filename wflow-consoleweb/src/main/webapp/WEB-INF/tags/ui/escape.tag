<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>

<%@ tag import="org.joget.commons.util.StringUtil"%>
<%@ tag trimDirectiveWhitespaces="true" %>

<%@ attribute name="value" required="true" %>
<%@ attribute name="format" required="true" %>

<%= StringUtil.escapeString(value, format, null) %>
