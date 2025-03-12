package com.giga.gw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.DepartmentDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IDeptManagementDao;
import com.giga.gw.service.DepartmentServiceImpl;
import com.giga.gw.service.DeptManagementServiceImpl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/deptManagement")
@Slf4j
public class DepartmentManagementController {
	
	private final IApprovalDao approvalDao;
	
	private final IDeptManagementDao deptManagementDao ;
	
	@Autowired
	private DeptManagementServiceImpl deptManagementService;
	
	@PostMapping("/deptManagement.do")
	public String insertDepartment(@RequestBody DepartmentDto deptDto) {
		log.info("DepartmentManagementController insertDepartment POST 요청");
		deptManagementDao.insertDepartment(deptDto);
		return "redirect:/deptManagement";
	}
	
	@ResponseBody
	@GetMapping("/tree.json")
	public List<DepartmentDto> deptTree() {
		return deptManagementDao.getAllDept();
	}
	
	@GetMapping("/deptManagement.do")
	public String DeptManagement() {
		return "deptManagement";
	}
	
}
