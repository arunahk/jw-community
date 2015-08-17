<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>

<c:set var="appUrl" value="${param.url}"/>
<c:set var="appName" value="${param.name}"/>
<c:set var="appId" value="${param.appId}"/>
<c:set var="downloadUrl" value="${param.download}"/>

<commons:popupHeader />

    <div id="main-body-header">
        <fmt:message key="appCenter.label.marketplace"/>: <c:out value="${appName}"/>
    </div>

    <div id="main-body-actions">
        <button id="installApp" style="display:none"><fmt:message key="appCenter.label.installApp"/></button>
    </div>
    
    <div id="main-body-content">
        <iframe id="marketplaceAppFrame" src='<c:url value="${appUrl}"/>' width="99%" height="98%"></iframe>
    </div>    

    <script>
        $(function() {
            var downloadUrl = "<c:url value="${downloadUrl}"/>";
            if (downloadUrl === null || downloadUrl === "") {
                downloadUrl = "<fmt:message key="appCenter.link.marketplace.downloadUrl"/>";
                if (downloadUrl === null || downloadUrl === "" || downloadUrl === "???appCenter.link.marketplace.downloadUrl???") {
                    downloadUrl = "https://marketplace.joget.org/downloads/app/";
                }
                downloadUrl += "<c:out value="${appId}"/>.zip";
            }
            var verifyUrl = "${pageContext.request.contextPath}/web/json/apps/verify?url=" + encodeURIComponent(downloadUrl);
            $.ajax({
                type: 'HEAD',
                url: verifyUrl,
                success: function(data) {
                    $("#installApp").show();
                },
                error: function(data) {
                    $("#installApp").hide();
                }
            });            
            $("#installApp").on("click", function() {
                var installUrl = "${pageContext.request.contextPath}/web/json/apps/install";
                if (confirm("<fmt:message key="appCenter.label.confirmInstallation"/>")) {
                    var installCallback = {
                        success: function(data) {
                            $("#installApp").html('<fmt:message key="appCenter.label.installApp"/>');
                            $("#installApp").removeAttr("disabled");
                            var app = JSON.parse(data);
                            var appId = app.appId;
                            if (appId && appId !== "") {
                                alert("<fmt:message key="appCenter.label.appInstalled"/>");
                                PopupDialog.closeDialog();                                
                                parent.loadPublishedApps();
                            } else {
                                alert("<fmt:message key="appCenter.label.appNotInstalled"/>");
                            }
                        },
                        error: function(data) {
                            $("#installApp").html('<fmt:message key="appCenter.label.installApp"/>');
                            $("#installApp").removeAttr("disabled");
                            alert("<fmt:message key="appCenter.label.appNotInstalled"/>");
                        }
                    };
                    // show loading icon
                    $("#installApp").html('<i class="icon-spinner icon-spin"></i> <fmt:message key="appCenter.label.installingApp"/>');
                    $("#installApp").attr("disabled", "disabled");
        
                    // invoke installation
                    var installParams = "url=" + encodeURIComponent(downloadUrl);
                    ConnectionManager.post(installUrl, installCallback, installParams);
                }
            })
        });
    </script>
    
<commons:popupFooter />
