package com.giga.gw.test;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.ILoginDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class Login_JUnitTest {

	@Autowired
	private ILoginDao loginDao;
	
	@Test
	public void test() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empno", "1505001");
		map.put("password", "password123");
		
		EmployeeDto employeeDto = loginDao.login(map);
		System.out.println(employeeDto);
		
	
	}
}
