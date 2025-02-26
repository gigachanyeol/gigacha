package com.giga.gw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping
@RequiredArgsConstructor
@Slf4j
public class ReservationController {

	@GetMapping("/reservation.do")
	public String reservation() {
		return "reservation";
	}

}
