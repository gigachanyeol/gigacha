package com.giga.gw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/calendar")
@RequiredArgsConstructor
@Slf4j
public class CalendarController {
	
	@GetMapping("/tostcalendar.do")
	public String tostcalendar() {
		return "tostcalendar";
	}
	
	@GetMapping("/calendar.do")
	public String fullcalendar() {
		return "calendar";
	}
}
