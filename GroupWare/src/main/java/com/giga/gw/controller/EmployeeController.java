package com.giga.gw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class EmployeeController {
	
	@GetMapping("/grid.do")
	public String grid(){
		return "grid";
	}
	
	@GetMapping("/droppable.do")
	public String droppable(){
		return "droppable";
	}
	
	

	
}
