package com.giga.gw.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.service.ILoginService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class LoginController {
	
	private final ILoginService loginService;
	
	@GetMapping("/login.do")
	public String login() {
		return "login";
	}
	
	@PostMapping("/login.do")
	public String login(@RequestParam Map<String, Object> map, HttpSession session) {
		System.out.println(map.toString());
		EmployeeDto employeeDto = loginService.login(map);
		System.out.println(employeeDto);
		
		if(employeeDto == null) {
			
			return "login";
		}
		session.setAttribute("loginDto", employeeDto);
		
		return "redirect:/";
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
//		EmployeeDto dto = (EmployeeDto)session.getAttribute("loginDto");
		session.removeAttribute("loginDto");
		return "redirect:/login.do";
	}


}