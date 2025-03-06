package com.giga.gw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.giga.gw.service.IRoomService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/rooms")
@RequiredArgsConstructor
@Slf4j
public class ReservationController {
	
	private final IRoomService roomService;

	@GetMapping("/reservation.do")
	public String reservation() {
		return "reservation";
	}
	
	//예약 설정
	


}
