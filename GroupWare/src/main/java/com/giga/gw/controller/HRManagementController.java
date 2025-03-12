package com.giga.gw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/hrManagement")
public class HRManagementController {
	
	@GetMapping("/employeeRegistration.do")
	public String DeptManagement() {
		return "employeeRegistration";
	}

}
