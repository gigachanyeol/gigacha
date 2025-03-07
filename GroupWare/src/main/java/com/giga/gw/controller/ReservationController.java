package com.giga.gw.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.ReservationDto;
import com.giga.gw.service.IReservationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/rooms")
@RequiredArgsConstructor
@Slf4j
public class ReservationController {

	private final IReservationService reservationService;

	@GetMapping("/reservation.do")
	public String reservation() {
		return "reservation";
	}
	
	//예약 설정
	@PostMapping("/insertroom.do")
	@ResponseBody
	public ResponseEntity insertreservation(@RequestBody ReservationDto reservationDto){
		System.out.println(reservationDto);
		
		int result = reservationService.insertreservation(reservationDto);
		
		if(result > 0) {
			return ResponseEntity.ok(true); // 성공 시 응답
		}else {
			return ResponseEntity.status(400).body(false); // 실패 시 응답			
		}
		
	}


}
