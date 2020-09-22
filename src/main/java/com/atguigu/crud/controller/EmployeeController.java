package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired()
    EmployeeService employeeService;

    /**
     *
     * Tomcat 会将请求体中的数据封装成一个 Map，调用 request.getParameter()
     * 会从这个 Map 中取值，Spring MVC 封装 POJO 对象时，对于对象中的每个属性
     * 值也会调用 request.getParameter() 方法去获取，然后赋值给对象相应的属性，
     * 完成属性封装。
     *
     * 2. 但是，对于 PUT 请求，Tomcat 不会封装请求体中的数据为一个 Map，
     * 只会将 POST 请求的请求体中数据封装成 Map；这样的话，无论是直接调用
     * request.getParameter() 方法，还是 Spring MVC 封装对象，肯定都拿不到属性值了。
     *解决方法是再web.xml中配置HttpPutFormContentFilter 过滤器
     *  @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        employeeService.update(employee);
        return Msg.success();
    }


    /**
     * 员工更新
     * @param empId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id")int empId){
        Employee emp = employeeService.getEmp(empId);
        return Msg.success().add("emp", emp);
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkName(@RequestParam("empName") String empName){
        String regRule = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regRule)){
            return Msg.failed().add("msg_va","用户名必须是2-5位中文名或5-16位英文名");
        }
        boolean check = employeeService.check(empName);
        if (check){
            return Msg.success();
        } else {
            return Msg.failed().add("msg_va","用户名不可用");
        }
    }


    /**
     * 欲保障response正常工作，需要引入json依赖包
     * @param pageNo
     * @return
     */
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpWithJson(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo){
        //引入PageHelper分页插件
        //在查询之前需要调用,传入页码和每页数据
        PageHelper.startPage(pageNo, 5);
        //在startPage后面紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getALL();
        //使用pageinfo包装查询结果,只需要将pageinfo交给页面
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo",page);
    }
    /**
     * 员工保存
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //验证失败，返回错误信息
            Map<String,Object> errormap = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors){
                System.out.println("错误的字段:" + fieldError.getField());
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                errormap.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.failed().add("errorFields",errormap);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 单个批量二合一
     * 批量删除1-2-3
     * 单个删除1
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteById(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            String[] str_ids = ids.split("-");
            List<Integer> del_ids = new ArrayList<>();
            for (String str : str_ids){
                del_ids.add(Integer.parseInt(str));
                employeeService.deleteBatch(del_ids);
            }
        } else {
            int id = Integer.parseInt(ids);
            employeeService.deleteById(id);
        }
        return Msg.success();
    }

}
