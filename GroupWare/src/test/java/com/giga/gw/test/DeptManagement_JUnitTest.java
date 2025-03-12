package com.giga.gw.test;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.DepartmentDto;
import com.giga.gw.repository.IDeptManagementDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class DeptManagement_JUnitTest {
	
	@Autowired
	private IDeptManagementDao dao;
	
	@Test
	public void test() {
		
		List<DepartmentDto> list = dao.getAllDept();
		assertNotEquals(0, list.size());
		
		List<DepartmentDto> deletelist = dao.getDeletedDept();
		assertNotEquals(0, deletelist.size());
		
	}

}
