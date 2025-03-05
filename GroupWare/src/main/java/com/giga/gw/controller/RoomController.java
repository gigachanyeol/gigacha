package com.giga.gw.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.RoomDto;
import com.giga.gw.service.IRoomService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/rooms")
public class RoomController {

	private final IRoomService roomService;
	
	//회의실 등록 폼
	@GetMapping("/roomform.do")
	public String roomform() {
		return "roomform"; //페이지 이동
	}
	
	//회의실 등록
//	@PostMapping(value = "/insertRoom.do")
//	@ResponseBody
//	public String registerRoom(@RequestBody RoomDto roomDto, HttpSession session) {
//		String employee = (String)session.getAttribute("employee");
//		
//		if(employee == null) { //로그인 여부 확인
//			return "redirect:/login.do";
//		}
//		
//		String auth = employeeService.getAuthByEmpno(employee); //employeeService(?)
//		
//	    if(auth == null || !"admin".equals(auth)) {
//	    	return "권한이 없습니다."; //관리자 권한이 없는 경우
//	    }else {
//	    	try {
//	    		roomService.insertRoom(roomDto); 
//	    		return "redirect:/rooms/reservation.do"; //등록 성공 시 예약 페이지로 이동
//	    	}catch(Exception e) {
//	    		return "redirect:/rooms/roomform.do"; //등록 실패 시 등록폼으로 이동
//	    	}
//	    	
//	    int result = roomService.insertRoom(roomDto);
//	    return (result > 0) ? "success":"fail"; //성공여부 
//	    }
//	}
	
	//회의실 리스트 조회(관리자)
	@GetMapping("/roomList.do")
	public String roomList(Model model) {
		List<RoomDto> roomList = roomService.selectAllRooms();
		model.addAttribute("roomList", roomList);
		return "roomList";	
	}
	
	
	@PostMapping("/update.do")
	@ResponseBody
	public ResponseEntity updateRoom(@RequestBody RoomDto roomDto) {
		System.out.println(roomDto);
		
		int updateRoom = roomService.updateRoom(roomDto); // 회의실 정보 업데이트
		
		if (updateRoom > 0) {
	        return ResponseEntity.ok(true);  // 성공 시 응답
	    } else {
	        return ResponseEntity.status(400).body(false);  // 실패 시 응답
	    }
	}
	

}
