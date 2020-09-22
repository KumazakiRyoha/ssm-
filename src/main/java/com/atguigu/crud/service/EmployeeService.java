package com.atguigu.crud.service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getALL(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存
     * @return
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检验用户名是否相同
     * @param empName
     */
    public boolean check(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    /**
     * 按照员工id查找员工
     * @param empId
     * @return
     */
    public Employee getEmp(int empId) {
        Employee employee = employeeMapper.selectByPrimaryKey(empId);
        return employee;
    }

    /**
     * 更新员工
     * @param employee
     */
    public void update(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteById(int id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
