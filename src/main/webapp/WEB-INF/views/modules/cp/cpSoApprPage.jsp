<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>企业资质</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#eqForm").submit();
            return false;
        }
    </script>

    <link href="${ctxStatic}/print/print.css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jqprint/jquery.jqprint-0.3.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            $("input#biuuu_button").click(function(){

                //$("div#myPrintArea").printArea();
                //$("div#myPrintArea").printPage();
                $("div#myPrintArea").jqprint();

            });
        });

    </script>
    <style type="text/css">
        #myPrintArea table td {
        .mine
        font-size: 12px;
            font-family: '仿宋';

            font-size: 13px;
            font-family: '宋体';
            padding: 4px; margin-top: 4px;;
        .r20
        }
    </style>
</head>
<body>
<tags:message content="${message}"/>
<%--
<form:form id="eqFor" modelAttribute="soCpApprove" action="${ctx}/cp/soCp/cpApprPage" method="post"  class="form-horizontal">
--%>


<div id="myPrintArea">
     <table id="contentTable" class="table table-bordered table-condensed table-hover " >
        <thead>
        <tr align="center"><td colspan="8" style="text-align: center"><h4>审 核 信 息</h4></td></tr>
        </thead>
        <tr>
            <td class="span3"><label class="control-label">企业审核意见</label></td>
            <td>
             <c:forEach items="${soCpApproveList}" var="soCpApprove">
                <c:if test="${empty soCpApprove.apprType || soCpApprove.apprType eq '02' }" >
                    ${soCpApprove.content}</br></br>
                    <span style="float: right; margin-right: 50px;">负责人(签字)：${fns:getUserById(soCpApprove.apprUserId).name}</span><br />
                    <br/>
                    <span style='float: right;height: 95px; width: 95px; margin-right: 100px; background:url("${ctxStatic}/images/zyc.png")'> <h6>单 位 (公章)：</h6></span>
                    <br/>
                 </c:if>
              </c:forEach>
            </td>
        </tr>
        <tr>
            <td class="span3"><label class="control-label">省辖市建设行政主管部门</label></td>
            <td>
            <c:forEach items="${soCpApproveList}" var="soCpApprove">
               <c:if test="${empty soCpApprove.apprType || soCpApprove.apprType eq '01' }" >
                    ${soCpApprove.content}</br><span style="float: right; height: 20px;margin-right: 50px;">负责人(签字)：${fns:getUserById(soCpApprove.apprUserId).name}</span><br /><span  style="float: right;">${fns:getYear(soCpApprove.apprDate)}年${fns:getMonth(soCpApprove.apprDate)}月${fns:getDay(soCpApprove.apprDate)}日&nbsp;&nbsp;</span>
               </c:if>
            </c:forEach>

            <c:forEach items="${soCpApproveList}" var="soCpApprove">
                <c:if test="${soCpApprove.taskName eq '盟市分管局长审核'}">
                    <br/>
                    <span style='float: right;height: 95px; width: 95px; margin-right: 50px; background:url("${ctxStatic}/images/zyc.png")'> <h6>单 位 (公章)：</h6></span>
                    <br/>
                </c:if>
             </c:forEach>
            </td>
        </tr>
        <tr>
            <td class="span3"><label class="control-label">建设厅审查意见</label></td>
            <td>
            <c:forEach items="${soCpApproveList}" var="soCpApprove">
                 <c:if test="${empty soCpApprove.apprType || soCpApprove.apprType eq '00' }" >
                    ${soCpApprove.content}
                     <c:if test="${soCpApprove.taskName eq '厅长审核'}">
                         </br><span style="float: right; height: 20px;margin-right: 50px;">负责人(签字)：<img src="${ctxStatic}/images/li.png"/></span>
                     </c:if>
                     <c:if test="${soCpApprove.taskName eq '建设厅分管领导审核'}">
                         </br><span style="float: right; height: 20px;margin-right: 50px;">负责人(签字)：<img src="${ctxStatic}/images/zeng.png"/></span>
                     </c:if>
                     <c:if test="${soCpApprove.taskName eq '建设厅主管领导审核'}">
                         </br><span style="float: right; height: 20px;margin-right: 50px;">负责人(签字)：<img src="${ctxStatic}/images/bai.png"/></span>
                     </c:if>
                          <br><span style="float: right;">${fns:getYear(soCpApprove.apprDate)}年${fns:getMonth(soCpApprove.apprDate)}月${fns:getDay(soCpApprove.apprDate)}日&nbsp;&nbsp;</span>
                 </c:if>
            </c:forEach>
            <c:forEach items="${soCpApproveList}" var="soCpApprove">
                    <c:if test="${soCpApprove.taskName eq '厅长审核'}">
                        <br/>
                        <span style='float: right;height: 95px; width: 95px;margin-right: 50px; background:url("${ctxStatic}/images/jst.png")'> <h6>单 位 (公章)：</h6></span>
                        <br/>
                    </c:if>
            </c:forEach>
          </td>
        </tr>
        <tr>
            <td class="span3"><label class="control-label">备注</label></td>
            <td><%--<form:textarea path="" value="${soCpApprove.remarks}" class=" input-block-level" rows="4" disabled="true" />--%>
                </br></br></br></br>
            </td>
        </tr>
    </table>

   <%-- </c:if>

    </c:forEach>--%>

<%--
</form:form>
--%>
    </div>
<div style="text-align: center;">
    <input id="biuuu_button" type="button" value="打 印" class="btn"/>
    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>
</body>
</html>
