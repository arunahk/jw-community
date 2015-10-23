<%@ tag import="org.joget.commons.util.StringUtil"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>
<%@ attribute name="html" required="true" %>
<%@ attribute name="relaxed" required="false" %>

<%= (!"true".equals(relaxed)) ? StringUtil.stripAllHtmlTag(html) : StringUtil.stripHtmlRelaxed(html) %>
