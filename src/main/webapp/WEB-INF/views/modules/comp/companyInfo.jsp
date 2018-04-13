<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>企业信息查询</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
           // $('#compTab a:first').tab("show");
/*            $('#compTab a').click(function (e){
                e.preventDefault();
                $(this).tab('show');
            });*/

            $("#param").focus();
            $("#searchForm").validate({
                submitHandler: function(form){
                    loading('正在查询，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });

        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#cpForm").submit();
            return false;
        }
    </script>
    <style type="text/css">
        #company .label {
            background: #bfd5ff;
            font-size: 14px;
            color: #333333;
            font-family: '黑体';
            font-weight: normal;
            line-height: 20px;
            text-align: right;
        }
    </style>
</head>
<body>
<%--<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/comp/company/">企业信息</a></li>
    <shiro:hasPermission name="comp:company:edit"><li><a href="${ctx}/comp/company/form">企业添加</a></li></shiro:hasPermission>
</ul>--%>
<form:form id="searchForm" modelAttribute="company" action="${ctx}/comp/company/" method="post" class="breadcrumb form-search">
    <shiro:hasPermission name="${fns:getUser().userCompany} eq null">

    <label class="control-label" for="queryType">查询方式 ：</label>

    <form:select id="queryType" path="queryType" class="input-medium"><form:options items="${fns:getDictList('comp_query_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
    <input type="text" id="param" name="param" class="required" value="${params.param}">
<%--
    <label>企业名称 ：</label><form:input path="companyName" htmlEscape="false" maxlength="50" class="input-small"/>
    <label>组织机构登记号 ：</label><form:input path="orgCode" htmlEscape="false" maxlength="50" class="input-small"/>
--%>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
    </shiro:hasPermission>
</form:form>
<%--<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/comp/company/">企业基本信息</a></li>
    <li><a href="${ctx}/cp/personnel?companyId=${company.companyId}">三类人员信息</a></li>
</ul>--%>

<ul class="nav nav-tabs" id="compTab">
    <li class="active"><a href="#company" data-toggle="tab">企业基本信息</a></li>
    <li><a href="#personnel" data-toggle="tab">三类人员信息</a></li>
    <li><a href="#eqpage" data-toggle="tab">企业资质</a></li>
    <li><a href="#acPersonPage" data-toggle="tab">二级建造师信息</a></li>
<%--
    <li><a href="#acMajorPage" data-toggle="tab">二级建造师专业信息</a></li>
--%>
    <li><a href="#sepage" data-toggle="tab">企业安全生存许可</a></li>

</ul>

<tags:message content="${message}"/>
<%--<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr><th>名称</th><th>备注</th><shiro:hasPermission name="comp:company:edit"><th>操作</th></shiro:hasPermission></tr></thead>
    <tbody>
    <c:forEach items="${page.list}" var="company">
        <tr>
            <td><a href="${ctx}/comp/company/form?id=${company.id}">${company.name}</a></td>
            <td>${company.remarks}</td>
            <shiro:hasPermission name="comp:company:edit"><td>
                <a href="${ctx}/comp/company/form?id=${company.id}">修改</a>
                <a href="${ctx}/comp/company/delete?id=${company.id}" onclick="return confirmx('确认要删除该企业吗？', this.href)">删除</a>
            </td></shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>--%>
<div class="tab-content">
    <div class="tab-pane active" id="company">
        <fieldset>
            <legend>企业基本信息</legend>
            <div class="row control-group">
                <div class="span4">
                    <label class="control-label label">企业名称：</label>
                    ${company.companyName}
                </div>
                <div class="span4">
                    <label class="control-label label">企业所属省份：</label>
                    ${fns:getDictLabel(company.provinceId, 'PROVINCE', '')}
                </div>
                <div class="span4">
                    <label class="control-label label">企业所属地市：</label>
                    ${fns:getDictLabel(company.localId, 'LOCAL_ID', '')}
                </div>
            </div>
            <div class="row control-group">
                <div class="span4">
                    <label class="control-label label">组织机构代码：</label>
                    ${company.orgCode}
                </div>
                <div class="span4">
                    <label class="control-label label">税务登记证：</label>
                    ${company.taxNo}
                </div>
                <div class="span4">
                    <label class="control-label label">营业执照号：</label>
                    ${company.licenceNo}
                </div>
            </div>
            <div class="row control-group">
                <div class="span4">
                    <label class="control-label label">企业人数：</label>

                </div>
                <div class="span4">
                    <label class="control-label label">注册资金：</label>
                    ${company.registerCapital}
                </div>
                <div class="span4">
                    <label class="control-label label">企业状态：</label>
                    ${fns:getDictLabel(company.sts, 'STS', '')}
                </div>
            </div>
            <div class="row control-group">

                <div class="span4">
                    <label class="control-label label">注册日期：</label>
                    ${company.effDate}
                </div>
                <div class="span4">
                    <label class="control-label label">企业类型：</label>
                    ${company.companyType}
                </div>
                <div class="span4">
                    <label class="control-label label">企业经济性质：</label>
                    ${company.economicType}
                </div>
            </div>
            <div class="row control-group">
                <div class="span12">
                    <label class="control-label label">注册地址：</label>
                    ${company.registerAddr}
                </div>
            </div>
            <div class="row control-group">
                <div class="span12">
                    <label class="control-label label">企业概况：</label>
                    ${company.profile}
                </div>
            </div>
            <div class="row control-group">
                <div class="span12">
                    <label class="control-label label">企业网址：</label>
                    ${company.portalCode}
                </div>
            </div>

            <%--    <table class="table table-bordered">
                    <tr>
                        <td>企业名称</td>
                        <td>${company.companyName}</td>
                        <td>所属省份</td>
                        <td>${company.provinceId}</td>
                        <td>所属地市</td>
                        <td>${company.localId}</td>
                    </tr>
                </table>--%>
        </fieldset>
        <fieldset>
            <legend>企业法定代表人基本信息</legend>
            <div class="row control-group">
                <div class="span4">
                    <label class="control-label label">企业法定代表人：</label>
                    ${company.legPerson}
                </div>
                <div class="span4">
                    <label class="control-label label">证件类型：</label>
                    ${company.legIdType}
                </div>
                <div class="span4">
                    <label class="control-label label">证件号码：</label>
                    ${company.legNo}
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend>企业联系人基本信息</legend>
            <div class="row control-group">
                <div class="span4">
                    <label class="control-label label">企业联系人：</label>
                    ${company.contactPerson}
                </div>
                <div class="span4">
                    <label class="control-label label">证件类型：</label>
                    ${company.legIdType}
                </div>
                <div class="span4">
                    <label class="control-label label">证件号码：</label>
                    ${company.legNo}
                </div>
            </div>
            <div class="row control-group">
                <div class="span4">
                    <label class="control-label label">邮箱：</label>
                    ${company.email}
                </div>
                <div class="span4">
                    <label class="control-label label">联系电话：</label>
                    ${company.contactPhone}
                </div>
            </div>
        </fieldset>
    </div>
    <!-- 三类人员-->
    <div class="tab-pane" id="personnel">
        <iframe id="cpFrame" name="cpFrame" src="${ctx}/comp/company/cppage?companyId=${company.companyId}" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
    </div>

    <!-- 企业资质-->
    <div class="tab-pane" id="eqpage">
        <iframe id="eqFrame" name="eqFrame" src="${ctx}/comp/company/eqpage?companyId=${company.companyId}" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
    </div>

    <!-- 二级建造师信息-->
    <div class="tab-pane" id="acPersonPage">
        <iframe id="acPersonFrame" name="acPersonFrame" src="${ctx}/comp/company/acpersonpage?companyId=${company.companyId}" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
    </div>

<%--
    <!-- 二级建造师-专业信息-->
    <div class="tab-pane" id="acMajorPage">
        <iframe id="acMajorFrame" name="acMajorFrame" src="${ctx}/comp/company/acmajorpage?companyId=${company.companyId}" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
    </div>
--%>

    <!-- 企业安全生产许可-->
    <div class="tab-pane" id="sepage">
        <iframe id="seFrame" name="seFrame" src="${ctx}/comp/company/sepage?companyId=${company.companyId}" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
    </div>
</div>
</body>
</html>
