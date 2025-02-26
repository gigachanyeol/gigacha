package com.giga.gw.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.repository.ICalendarDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/calendar")
@RequiredArgsConstructor
@Slf4j
public class CalendarController {
	
	private final ICalendarDao calendarDao;
	
	//사용안함 
	@GetMapping("/tostcalendar.do")
	public String tostcalendar() {
		return "tostcalendar";
	}
	
	//사용
	@GetMapping("/calendar.do")
	public String fullcalendar(Model model) {
		LocalDateTime StartDate = LocalDateTime.now();
		LocalDateTime EndDate = StartDate.plusDays(7);
		
		
		model.addAttribute("StartDate",StartDate);
		model.addAttribute("EndDate",EndDate);
		
		return "calendar";
	}
	
	@PostMapping("/saveSchedule.do")
	@ResponseBody
	public boolean SaveSchedule(@RequestBody String schedule) {
		log.info("q(≧▽≦q)φ(゜▽゜*)♪q(≧▽≦q)φ(゜▽゜*)♪{}",schedule);
		int row = calendarDao.scheduleSave(schedule);
		
		if(row==1) {
			System.out.println(" o(*^＠^*)oo(*^＠^*)o 저장성공   o(*^＠^*)oo(*^＠^*)o    ");
		}
		
		return row == 1?true:false;
		
	}
	
}
