package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/**
 * 测试dao层的方法
 * 推荐spring项目使用spring的单元测试
 * 首先需要导入SpringTest
 *ContextConfiguration注解指定spring配置文件的位置
 * 然后Autowired需要使用的注解
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})

public class MapperTest {

        @Autowired
        DepartmentMapper departmentMapper;
        @Autowired
        EmployeeMapper employeeMapper;

        @Autowired
        SqlSession sqlSession;

    /**
     * 测试EmployeeMapper
     */
    @Test
    public void testCRUD(){
        //创建SpringIOC容器
//        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
//        //从容器中获取mapper
//        DepartmentMapper departmentMapper = applicationContext.getBean(DepartmentMapper.class);
//        Employee employee = new Employee(null,"黎明","男","185693@qq.com",1);
//        Department department = new Department(1,"销售部");
//        System.out.println(departmentMapper);
        //1.插入
//        Department department = new Department(2,"销售部");
//        departmentMapper.insertSelective(department);

        //插入员工
        Employee employee = new Employee(null,"DAGU","男","atguigu@qq.com",1);
        employeeMapper.insertSelective(employee);
    }

    @Test
    public void test2(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<50;i++){
            String uuid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@atguigu.com",1));
        }
        System.out.println("批量完成");
    }

    @Test
    public void testSelect(){
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        for (Employee employee : employees){
            System.out.println(employee);
        }
    }

}
