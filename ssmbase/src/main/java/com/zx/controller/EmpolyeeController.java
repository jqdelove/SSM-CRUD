package com.zx.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zx.model.Employee;
import com.zx.model.Msg;
import com.zx.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * 处理员工增删改查请求
 */
@Controller
public class EmpolyeeController {


    @Autowired
    EmployeeService employeeService;


    /**
     * 员工单个删除、批量删除合并
     * 批量删除：1-2-3
     * 单个删除：1
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            //批量删除
            //因为生成的xml文件中的andEmpIdIn方法需要传入的就是list集合，所以我们在这边将String数组中的元素加到list中去
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //遍历String数组，将数组中的每个元素加入到list中去
            for (String string: str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deletBatch(del_ids);
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }






    /**
     *前端如果直接发送ajax=PUT的请求，Tomcat就不会将请求体中的数据进行封装，发送到Tomcat的数据就都为空
     *
     * Tomcat:
     *      1、将请求体中的数据，封装成一个map
     *      2、request.getParameter("empName")就会从这个map中取值
     *      3、SpringMVC封装POJO对象时
     *              会把POJO中每个属性的值，request.getParameter("email")
     *
     * AJAX直接发送PUT请求引发的问题：
     *      PUT请求，请求体中的数据，request.getParameter("empName")是拿不到的
     *      Tomcat源码中规定了只有POST请求形式的请求才会封装成map，除此之外均不会进行封装
     *
     * 源码：
     *      org.apache.catalina.connector.Request
     *
     * protected String parseBodyMethods = "POST";
     *
     *
     *
     * 解决办法：
     * 需要能够支持直接发送PUT之类请求，还要封装请求体中的数据
     * 1、配置HttpPutFormContentFilter
     * 2、作用是：将请求体中的数据解析包装成一个map
     * 3、request被重新包装，request.getParameter()方法被重写，从新封装的map中拿到数据
     *
     *
     * 员工更新
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }




    /**
     * 根据id查询员工信息，和查询所有的员工信息不同，这个查询是条件查询
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }



    /**
     * 检验用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名应为2-5位中文或者6-16位英文数字组合");
        }
        //数据库用户名是否重复的校验
        boolean b = employeeService.checkUser(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名已经存在");
        }

    }


    /**
     * 员工保存
     * 1、支持JSR303校验
     * 2、导入Hibernate-Validator包
     *
     *
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError: errors
                 ) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return  Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }



    /**
     * 导入jackson包
     * 这种方式属于前后端分离的方式
     * @param pn
     * @return
     */

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //这不是一个分页查询
        //引入pageHelper分页插件
        //在查询之前调用，传入页码
        PageHelper.startPage(pn,5);
        //startPage后紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将PageInfo交给页面就行
        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);

    }

    @RequestMapping("/index")
    public String index(){
        return  "index";
    }





    /**
     * 查询员工数据（分页查询）
     * @return
     */
    //@RequestMapping("/emps")
    public  String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){

        //这不是一个分页查询
        //引入pageHelper分页插件
        //在查询之前调用，传入页码
        PageHelper.startPage(pn,5);
        //startPage后紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将PageInfo交给页面就行
        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }

}
