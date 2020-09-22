<%--
  Created by IntelliJ IDEA.
  User: lenovo1
  Date: 2020/8/19
  Time: 8:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <%
        String contextPath = request.getContextPath();
        pageContext.setAttribute("APP_PATH", contextPath);
    %>
    <%--不以/开头的相对路径找资源是以当前资源为基准，容易出问题
    以/开头的相对路径找资源以服务器的根路径为标准
    例如https://localhost:3306/crud是服务器路径--%>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}static/bootstrap-3.3.7/js/bootstrap.min.js" rel="stylesheet"></script>
    <%--引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}static/js/jquery-3.5.1.min.js"></script>
</head>
<body>
    <%--搭建显示页面--%>
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-9">
                <button class="btn btn-danger">删除</button>
                <button class="btn btn-primary">添加</button>
            </div>
        </div>
        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>员工邮件</th>
                        <th>员工部门</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emps">
                        <tr>
                            <td>${emps.empId}</td>
                            <td>${emps.empName}</td>
                            <td>${emps.gender}</td>
                            <td>${emps.email}</td>
                            <td>${emps.department.deptName}</td>
                            <td>
                                <button type="button" class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button type="button" class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

        </div>
         <%--显示分页数据--%>
        <div class="row">
            <div class="col-md-6">
                当前第${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="${APP_PATH}/emps?pageNo=1">首页</a>
                        </li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pageNo=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                            <c:if test="${pageNum == pageInfo.pageNum}">
                                <li class="active"><a href="#">${pageNum}</a></li>
                            </c:if>
                            <c:if test="${pageNum != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pageNo=${pageNum}">${pageNum}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pageNo=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li>
                            <a href="${APP_PATH}/emps?pageNo=${pageInfo.pages}">末页</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
