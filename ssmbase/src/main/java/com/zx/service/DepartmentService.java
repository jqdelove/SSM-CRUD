package com.zx.service;

import com.zx.dao.DepartmentMapper;
import com.zx.model.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {

        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
