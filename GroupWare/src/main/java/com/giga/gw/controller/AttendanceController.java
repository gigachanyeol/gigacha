package com.giga.gw.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.repository.IAttendanceDao;
import com.giga.gw.repository.ICalendarDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/attendance")
@RequiredArgsConstructor
@Slf4j
public class AttendanceController {
	
	@Autowired
	private IAttendanceDao attendanceDao;
	
//	나의 근무 현황             
//	/myattendance.do"> <
	@GetMapping("/myattendance.do")
	public String fullcalendar(HttpSession session) {
		return "attendance";
	}
	
	
	@GetMapping("/loadleave.do")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> loadleave(HttpSession session) {
		
		 List<Map<String, Object>> leavelist = attendanceDao.leaveList();
		 
		 for (Map<String, Object> map : leavelist) {
			System.out.println("o(*^＠^*)oo(*^＠^*)"+map);
		}
//		 
		 return ResponseEntity.ok(leavelist);
	}
//	                    
//	부서 근무 현황                    
//	/deptattendance.do">
//	                    
//	부서 연차 현황                    
//	/deptannualleave.do"
//	                    
//	전사 근무현황                    
//	/emplattendance.do">
//	                    
//	전사 근무통계                    
//	/attstatistics.do"> 
//	                    
//	전사 연차현황                    
//	/attannualleave.do">
//	                    
//	전사 연차 사용 내역                    
//	/attuseannualleave.d
//	                    
//	전사 연차 통계                    
//	/annstatistics.do"> 
	

	
}
