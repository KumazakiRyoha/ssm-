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
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-3.5.1.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7/js/bootstrap.min.js">

    </script>

</head>
<body>

<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="employee_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">员工邮件</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工性别</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender1_update_input" value="男"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender2_update_input" value="女"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update">保存修改</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">员工添加</h4>
        </div>
        <div class="modal-body">
            <form class="form-horizontal" id="emp_info">
                <div class="form-group">
                    <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                    <div class="col-sm-10">
                        <input type="text" name="empName" class="form-control" id="empName_add_input">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email_add_input" class="col-sm-2 control-label">员工邮件</label>
                    <div class="col-sm-10">
                        <input type="text" name="email" class="form-control" id="email_add_input">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">员工性别</label>
                    <label class="radio-inline">
                        <input type="radio" name="gender" id="gender1_add_input" value="男"> 男
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="gender" id="gender2_add_input" value="女"> 女
                    </label>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">员工部门</label>
                    <div class="col-sm-4">
                        <select class="form-control" name="dId" id="dept_add_select"></select>
                    </div>
                </div>
            </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
          <button type="button" class="btn btn-primary" id="emp_save">保存添加</button>
        </div>
      </div>
    </div>
  </div>

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
            <button class="btn btn-danger" id="emp_delete_all_bnt">删除</button>
            <button class="btn btn-primary" id="emp_add_model" data-target="#empAddModel">添加</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>员工邮件</th>
                        <th>员工部门</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>

    </div>
    <%--显示分页数据--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">
    //1.页面加载完成，直接去发送ajax请求，要到分页数据
    let totalRecord, currentPage;
    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function(){
        //去首页
        to_page(1);
    });

    function to_page(pageNo){
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pageNo="+pageNo,
            type:"GET",
            success:function(result){
                //console.log(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        /** @namespace result.extend.pageInfo.list*/
        /** @namespace item.empName*/
        $("#emps_table tbody").empty();
        let emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            const checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            const empIdTd = $("<td></td>").append(item.empId);
            const empNameTd = $("<td></td>").append(item.empName);
            const genderTd = $("<td></td>").append(item.gender);
            const emailTd = $("<td></td>").append(item.email);
            const deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             <button type="button" class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
             编辑
             </button>
             **/
            const deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_bnt")
            .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除")
            const editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_bnt")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑")
            editBtn.attr("edit-id",item.empId);
            deleteBtn.attr("del-id",item.empId);
            const btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            //append执行后还是返回原来的元素，故可以进行链式操作
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                .append(emailTd).append(deptNameTd).append(btnTd)
                .appendTo("#emps_table tbody");
        })

    }
    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+ result.extend.pageInfo.pageNum +"页， 总共"
        + result.extend.pageInfo.pages +"页， 总共"
        + result.extend.pageInfo.total +"条记录")

        totalRecord = result.extend.pageInfo.pages;
        currentPage = result.extend.pageInfo.pageNum;
    }
    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result){
        //page_nav_area
        $("#page_nav_area").empty();
        const ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        const firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        const prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum -1);
            });
        }

        const nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        const lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

            const numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //为添加按钮绑定单击事件
    $("#emp_add_model").click(function(){
        //清除表单数据
        reset_form("#empAddModel form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        $("#dept_add_select").empty();
        getDept("#dept_add_select");
        //弹出模态框
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });

    //查出所有部门信息并显示在下拉列表中
    function getDept(ele) {
        //清空下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                $.each(result.extend.depts,function () {
                    const optionEle = $("<option></option>")
                        .append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        });
    }

    //校验表单数据
    function validate_add_from(){
        //1.拿到要校验的数据，使用正则表达式
        let empName = $("#empName_add_input").val();
        const regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)){
            show_validate_msg("#empName_add_input","error","用户名必须是2-2为中文名或5-16位英文名");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
        }
        //2.校验邮箱
        const email = $("#email_add_input").val();
        const regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    function show_validate_msg(ele,status,msg){
        //清楚当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#empName_add_input").change(function(){
        //发送ajax请求验证用户名是否可用
        let empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.status==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save").attr("ajax-va","success");
                } else {
                    show_validate_msg("#empName_add_input","error",result.extend.msg_va);
                    $("#emp_save").attr("ajax-va","error");
                }
            }
        })
    })

    //为添加保存员工添加点击事件
    //点击保存，保存员工。
    $("#emp_save").click(function(){
        //1、模态框中填写的表单数据提交给服务器进行保存
        //1、先对要提交给服务器的数据进行校验
        if(!validate_add_from()){
            return false;
        };
        // 1、判断之前的ajax用户名校验是否成功。如果成功。
        if($("#emp_save").attr("ajax-va")=="error"){
            return false;
        }
        //2、发送ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModel form").serialize(),
            success:function(result){
                //alert(result.msg);
                if(result.status == 100){
                    //员工保存成功；
                    //1、关闭模态框
                    $("#empAddModel").modal('hide');
                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalRecord);
                } else {
                    //显示失败信息
                    //console.log(result);
                    //有哪个字段的错误信息就显示哪个字段的；
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //因为是按钮创建之前就绑定了click，所以绑不上
    //1.可以在按钮创建绑定方法；2.绑定点击.live
    $(document).on("click",".edit_bnt",function () {
        //0.查出员工信息
        getEmp($(this).attr("edit-id"));
        //1.查出部门信息
        //将员工id传递给模态框
        $("#emp_update").attr("edit-id",$(this).attr("edit-id"));
        getDept("#dept_update_select");
        $("#empUpdateModel").modal({
            backdrop:"static"
        })
    })

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                const empEle = result.extend.emp;
                $("#employee_update_static").text(empEle.empName);
                $("#email_update_input").val(empEle.email);
                $("#empUpdateModel input[name=gender]").val([empEle.gender])
                $("#dept_update_select").val([empEle.dId]);
            }
        });
    }

    //点击保存修改，更新员工信息
    $("#emp_update").click(function () {
        //验证邮箱是否合法
        const email = $("#email_update_input").val();
        const regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_update_input", "success", "");
        }

        //发送Ajax请求
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModel form").serialize(),
            success:function (result) {
                //1、关闭对话框
                $("#empUpdateModel").modal('hide');
                //2、来到最后一页，显示刚才保存的数据
                //发送ajax请求显示最后一页数据即可
                to_page(currentPage);
            }
        })
    })

    $(document).on("click",".delete_bnt",function () {
         //取到员工id
        let name = $(this).parents("tr").find("td:eq(1)").text();
        const empId = $(this).attr("del-id");
        if (confirm("确认删除【"+name+"】吗？")){
            //确认后，可发送ajax

            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function () {
                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(currentPage);
                }
            })
        }
    })

    //完成全选全不选功能
    $("#check_all").click(function () {
        //attr用来获取自定义属性的值，prop用来获取其原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    })

    $(document).on("click",".check_item",function () {
        const flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    })

    //点击全部删除，就批量删除
    $("#emp_delete_all_bnt").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function(){
            //this
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames多余的,
        empNames = empNames.substring(0, empNames.length-1);
        //去除删除的id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function(result){
                    to_page(currentPage);
                }
            });
        }
    })
</script>
</body>
</html>
