package com.giga.gw.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.IEmployeeDao;
import com.giga.gw.service.IEmployeeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/hrManagement")
public class HRManagementController {
	
	private final IEmployeeDao employeeDao;
	
	// 마이페이지
	@GetMapping("/mypage.do")
//	@ResponseBody
	public String Mypage() {
//		EmployeeDto loginDto = (EmployeeDto)session.getAttribute("loginDto");
		
		
		return "mypage";
	}
	
	// 사원 등록 - 페이지 요청
	@GetMapping("/employeeAdd.do")
	public String DeptManagement() {
		return "employeeAdd";
	}
	
	// 사원 등록 - 사원번호 불러오기
	@GetMapping("/nextEmpno.do")
	@ResponseBody
	public String getNextEmpno(@RequestParam String hiredate) {
	    log.info("사원번호 불러오나요?????????????????????????");
	    String employee = employeeDao.getNextEmpno(hiredate);
	    log.info("입사일자 불러오기!!! {}",hiredate);
	    return employee != null ? employee : "";
	}
	
	// 사원 등록 - 사원 등록
	@PostMapping("/employeeAdd.do")
	@ResponseBody
	public String employeeResist(@RequestBody Map<String, Object> map, 
								HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto)session.getAttribute("loginDto");
		map.put("create_emp", loginDto.getEmpno());
		String empno = (String) map.get("empno");
		map.put("password", empno);
		System.out.println("hiredate: " + map.get("hiredate"));
		System.out.println("birthday: " + map.get("birthday"));
		log.info("비밀번호는??{}", empno);
		
		return employeeDao.insertEmployee(map)==1 ? "true":"false";
	}
	
	// 사원 리스트
	
	
	// 발령 등록

}
