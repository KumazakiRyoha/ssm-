package com.atguigu.crud.test;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.EmployeeMapper;
import com.atguigu.crud.service.EmployeeService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.annotation.Resource;
import java.util.List;

import static org.junit.Assert.*;

public class EmployeeServiceTest {

    @Autowired
    EmployeeService employeeService2;

    ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

    @Test
    public void getALL() {
        EmployeeService employeeService = context.getBean(EmployeeService.class);
        List<Employee> all = employeeService.getALL();
        System.out.println(all);
    }

    @Test
    public void getALL2(){
        List<Employee> all = employeeService2.getALL();
        System.out.println(all);
    }
}