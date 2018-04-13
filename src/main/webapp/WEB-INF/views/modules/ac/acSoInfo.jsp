<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>申请培训</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">

        function setMinHouts(obj,fee,planId) {
            $("#minHours").val(obj);
            $("#fee").val(fee);
            $("#planId").val(planId);
        }

        function dealHours(obj,hours){
            if(obj.checked){
                $("#totalHours").val(parseInt($("#totalHours").val()) + hours);
            }else{
                $("#totalHours").val(parseInt($("#totalHours").val()) - hours);
            }
        }



    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#courseArea" data-toggle="tab">专业课程</a></li>
    <li><a href="#pay" data-toggle="tab">支付信息</a></li>
    <li><a href="#invoice" data-toggle="tab">发票信息</a></li>

</ul>




 <div class="tab-content">
<%--
    <div style="float: right">最少学时：<input type="text" id="minHours" disabled value="0" style="width: 30px"/> &nbsp;已选择学时： <input id="totalHours" type="text" disabled value="0" style="width: 30px"></div>
--%>
<!-- 课程信息-->
    <div class="tab-pane active" id="courseArea">

           <table id="lessonTable" class="table table-striped table-bordered table-condensed">
            <thead><tr><th>课程名称</th><th>课程类型</th><th>讲师</th><th>学时</th><%--<th>状态</th>--%><th>操作</th></tr></thead><tbody>

            <c:forEach items="${soPlanEntity.courses}" var="course">
                <tr>
                    <td><a href="${ctx}/course/detail?courseId=${course.courseId}">${course.courseName}</a></td>
                   <td>${fns:getDictLabel(course.courseType, 'COURSE_TYPE', '')}</td>
                    <td>${course.teacherName}</td>
                    <td>${course.courseHours}</td>
<%--
                    <td>${fns:getDictLabel(course.sts, 'COURSE_STS', '')}</td>
--%>
                    <td> <a href="${ctx}/course/detail?courseId=${course.courseId}" >课程介绍</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>


    </div>
<!-- 支付信息-->
     <div class="tab-pane"  id="pay">
    <table id="payTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr align="center">
            <td colspan="6" style="text-align: center">填写发票信息</td>
        </tr>
        </thead>
        <tbody>
       <%-- <tr>
            <td class="span1"><label class="control-label">发票抬头</label></td>
            <td><form:input path="soInvoice.title" htmlEscape="false"  class="required input-block-level"/></td>
            <td class="span1"><label class="control-label">金额</label></td>
            <td><form:input id="fee" path="soInvoice.fee" htmlEscape="false"  class="required input-block-level number" readonly="true"/></td>
        </tr>
        <tr>
            <td><label class="control-label">联系人</label></td>
            <td><form:input path="soInvoice.contactName" htmlEscape="false"  class="required input-block-level realName"/></td>
            <td><label class="control-label">联系电话</label></td>
            <td><form:input path="soInvoice.contactPhone" htmlEscape="false"  class="required input-block-level phone"/></td>
        </tr>
        <tr>
            <td><label class="control-label">邮编</label></td>
            <td><form:input path="soInvoice.postCode" htmlEscape="false"  class="required input-block-level zipCode"/></td>
            <td><label class="control-label">公司名称</label></td>
            <td><form:input id="companyName" path="soInvoice.companyName" htmlEscape="false"  class="required input-block-level" /></td>
       </tr>
        <tr>
            <td><label class="control-label">邮寄地址</label> </td>
            <td colspan="5"><form:input path="soInvoice.postAddress" htmlEscape="false"  class="required input-block-level"/></td>
        </tr>
        <tr>
            <td><label class="control-label">内容</label></td>
            <td colspan="5">
                <form:textarea path="soInvoice.remark" htmlEscape="false" Class="input-block-level" rows="3"/>
            </td>
        </tr>--%>
        </tbody>
    </table>
</div>
<!-- 发票信息-->
     <div class="tab-pane"  id="invoice">
         <table id="invoiceTable" class="table table-striped table-bordered table-condensed">
             <thead>
             <tr align="center">
                 <td colspan="6" style="text-align: center">发票信息</td>
             </tr>
             </thead>
             <tbody>
              <tr>
                  <td class="span1"><label class="control-label">发票抬头</label></td>
                  <td>${soPlanEntity.soInvoice.title}</td>
                  <td class="span1"><label class="control-label">金额</label></td>
                  <td>${soPlanEntity.soInvoice.fee}</td>
              </tr>
              <tr>
                  <td><label class="control-label">联系人</label></td>
                  <td>${soPlanEntity.soInvoice.contactName}</td>
                  <td><label class="control-label">联系电话</label></td>
                  <td>${soPlanEntity.soInvoice.contactPhone}</td>
              </tr>
              <tr>
                  <td><label class="control-label">邮编</label></td>
                  <td>${soPlanEntity.soInvoice.postCode}</td>
                  <td><label class="control-label">公司名称</label></td>
                  <td>${soPlanEntity.soInvoice.companyName}</td>
             </tr>
              <tr>
                  <td><label class="control-label">邮寄地址</label> </td>
                  <td colspan="5">${soPlanEntity.soInvoice.postAddress}</td>
              </tr>
              <tr>
                  <td><label class="control-label">电子发票接收邮箱</label></td>
                  <td colspan="5">
                      ${soPlanEntity.soInvoice.remark}
                  </td>
              </tr>
             </tbody>
         </table>
     </div>

</div>
</body>
</html>