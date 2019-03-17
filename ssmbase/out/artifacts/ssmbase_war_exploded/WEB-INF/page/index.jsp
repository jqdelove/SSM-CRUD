<%--
  Created by IntelliJ IDEA.
  User: jinqi
  Date: 2019/3/5
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>

    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>

    <title>员工列表</title>

    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>


<body>

<%--编辑模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" >

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>





<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" >

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>





<div class="container">
    <!-- 标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>CRUD</h1>
        </div>
    </div>
    <!-- 按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>

    </div>
    <%-- 显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页记录信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页导航条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>




    <script type="text/javascript">

        //定义总记录数，方便添加员工数据后到最后一页进行查看，以及当前页面
        var totalRecord,currentPage;
        //1、页面加载完成以后，直接发送ajax请求，要到分页数据
        $(function () {
            //去首页
            to_Page(1);
        });

        //点击哪一页，就发送ajax请求去请求该页面
        function to_Page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function(result){
                    //console.log(result);
                    //1、解析并显示员工数据
                    build_emps_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                    //3、分页条
                    build_page_nav(result);
                }
            });
        }

        //构建员工信息表
        function build_emps_table(result) {
            //清空table表格
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为每一个编辑按钮添加一个自定义的属性，每点击一次编辑按钮，就发送对应的id去请求获取对应的员工信息
                editBtn.attr("edit-id",item.empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加自定义属性，表示当前员工，用来标识要删除的员工
                delBtn.attr("del-id",item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");

            });
        }

        //解析显示分页信息
        function build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，总共"+result.extend.pageInfo.pages+"页，总共"+result.extend.pageInfo.total+"条记录");
            totalRecord = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        //解析显示分页条，点击能够跳转
        function build_page_nav(result) {
            //page_nav_area
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if (result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                //为首页和前一页标签添加点击事件
                firstPageLi.click(function () {
                    to_Page(1);
                });
                prePageLi.click(function () {
                    to_Page(result.extend.pageInfo.pageNum-1);
                });
            }


            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            //如果没有下一页，就不能点击
            if (result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                nextPageLi.click(function () {
                    to_Page(result.extend.pageInfo.pageNum+1);
                });
                lastPageLi.click(function () {
                    to_Page(result.extend.pageInfo.pages);
                });
            }

            //添加首页和前一页
            ul.append(firstPageLi).append(prePageLi);
            //遍历1，2，3，4，5......
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                    if(result.extend.pageInfo.pageNum == item){
                        numLi.addClass("active");
                    }
                //点击数字标签，点哪一页就去哪一页
                numLi.click(function () {
                    to_Page(item);
                });
                ul.append(numLi);
            });
            ul.append(nextPageLi).append(lastPageLi);
            //把ul加入nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }


        function reset_form(ele){
            //reset方法是dom对象的，所以取出dom对象调用
            //清空表单内容
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }


        //新增按钮点击事件
        $("#emp_add_modal_btn").click(function () {
            //清楚表单数据（完整刷新：表单数据、表单样式）
            reset_form("#empAddModal form");
            // $("#empAddModal form")[0].reset();//reset方法是dom对象的，所以取出dom对象调用
            //发送ajax请求，查出部门信息，显示在下拉列表中
            getDepts("#empAddModal select");

            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });


        //查出所有的部门信息并显示在下拉列表中
        function getDepts(ele) {
            //清空查询的下拉列表的值
            $(ele).empty();
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result) {
                    // console.log(result);
                    //显示部门信息
                    // $("#empAddModal select")
                    $.each(result.extend.depts,function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }


        //校验表单数据
        function validate_add_form(){
            //1、拿到要校验的数据，使用正则表达式
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!regName.test(empName)){
                // alert("用户名应为6-16位英文数字组合或者2-5位中文！");
                //应该清空这个元素之前的样式
                show_validate_msg("#empName_add_input","error","用户名应为6-16位英文数字组合或者2-5位中文");
                return false;
            }else {
                show_validate_msg("#empName_add_input","success","用户名可用");
            }

            //2、校验邮箱
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                // alert("邮箱格式不正确！");
                //应该清空这个元素之前的样式
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validate_msg("#email_add_input","success","");
            }
            return true;

        }


        //封装校验方法，因为校验用户名和校验邮箱要做的事情相同，同样是给父元素添加状态类
        function show_validate_msg(ele,status,msg){
            //清空当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");

            if ("success" == status) {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if ("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        $("#empName_add_input").change(function () {
            //发送ajax请求校验用户名是否可用
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"empName="+empName,
                type:"POST",
                success:function (result) {
                    if (result.code==100){
                        show_validate_msg("#empName_add_input","success","用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    } else {
                        show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                }
            });
        });


        //保存按钮点击事件
        $("#emp_save_btn").click(function () {
            //模态框中填写的表单数据提交给服务器并保存

            //要先对提交给服务器的数据进行校验
            if(!validate_add_form()){
                return false;
            }
            //***判断之前的ajax用户名校验是否成功***
            if ($(this).attr("ajax-va")=="error"){
                return false;
            }

            //发送ajax请求保存员工
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    if (result.code == 100){
                        //员工保存成功
                        //1、关闭模态框
                        $("#empAddModal").modal('hide');
                        //2、来到最后一页显示数据
                        //发送ajax请求显示最后一页数据
                        //利用分页插件的会查询到最后一页数据
                        to_Page(totalRecord);
                    } else {
                        //显示失败的信息
                        if (undefined != result.extend.errorFields.email){
                            //显示邮箱错误信息
                            show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                        }
                        if (undefined != result.extend.errorFields.empName){
                            //显示员工姓名的错误信息
                            show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                        }
                    }
                }
            });
        });



        //1、在创建按钮之前就绑定了click事件，所以绑定不上
        //(1)、可以在创建的时候绑定
        //(2)、绑定点击.live()，但是新的jquery取消了live，使用on进行替代
        $(document).on("click",".edit_btn",function () {
            // alert("edit");
            
            //1、查出部门信息，显示部门列表
            getDepts("#empUpdateModal select");

            //2、查出员工信息，显示员工信息
            getEmp($(this).attr("edit-id"));

            //3、把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

            //弹出模态框
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });



        //获取并显示员工信息
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    // console.log(result);
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }



        //点击更新，更新员工信息
        $("#emp_update_btn").click(function () {
            //先对邮箱进行验证
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                // alert("邮箱格式不正确！");
                //应该清空这个元素之前的样式
                show_validate_msg("#email_update_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validate_msg("#email_update_input","success","");
            }

            //发送ajax请求保存更新的信息
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    // alert(result.msg);
                    //关闭模态框
                    $("#empUpdateModal").modal("hide");
                    //回到本页面
                    to_Page(currentPage);
                }
            });

        });


        //删除按钮单击事件，后生成的删除按钮，绑定用on
        $(document).on("click",".delete_btn",function () {
            //弹出是否确认删除
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            //拿到要删除的员工id
            var empId = $(this).attr("del-id");
            if (confirm("确认删除"+empName+"吗？")){
                //确认，发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (resutl) {
                        alert(resutl.msg);
                        to_Page(currentPage);
                    }
                });
            }
        });


        //完成全选、全不选功能
        $("#check_all").click(function () {
            //attr获取checked属性的值是undefined
            //checked是dom原生的属性；而attr获取的是自定义的属性
            //所以使用prop修改和读取dom原生属性的值，让所有check_item的checked属性的值和当前对象的值相同
            $(".check_item").prop("checked",$(this).prop("checked"));


        });
        
        //check_item，因为是后创建的，所以也采用on的方式绑定事件
        $(document).on("click",".check_item",function () {
            //判断当前选中的元素是否是全选
            //使用:checked过滤，判断被选中的个数是否和当前页面checkbox的个数相同
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked",flag);
        });



        //点击最上方的删除，就批量删除
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var del_idstr = "";
            //遍历每个复选框，从checked的复选框的父元素中找第三个name的值
            $.each($(".check_item:checked"),function () {
                //将name拼接
                empNames += $(this).parents("tr").find("td:eq(2)").text()+"，";
                //将id拼接
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //取出empNames后多余的逗号
            empNames = empNames.substring(0,empNames.length-1);
            //去除del_idstr多余的-
            del_idstr = del_idstr.substring(0,del_idstr.length-1);
            if (confirm("确认删除"+empNames+"吗？")){
                //发送ajax请求批量删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //删除完成回到当前页面
                        to_Page(currentPage);
                    }
                });
            }
        });




    </script>

</body>
</html>