package com.giga.gw.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.DepartmentDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IDeptManagementDao;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/deptManagement")
public class DepartmentManagementController {
	
	private final IApprovalDao approvalDao;
	
	private final IDeptManagementDao deptManagementDao ;
	
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
