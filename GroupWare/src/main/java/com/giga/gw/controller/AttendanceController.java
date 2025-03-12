package com.giga.gw.controller;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.repository.IAttendanceDao;

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
	
	// 연차 불러오기
	@GetMapping("/loadleave.do")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> loadleave(HttpSession session) {
		
		 List<Map<String, Object>> leavelist = attendanceDao.leaveList();
//		 for (Map<String, Object> map : leavelist) {
//			System.out.println("o(*^＠^*)oo(*^＠^*)"+map);
//		}
//		 
		 return ResponseEntity.ok(leavelist);
	}
	//출퇴근 체크
	@PostMapping("/workIn.do")
	@ResponseBody
	public boolean workInCheck(@RequestBody Map<String, Object> workInInfo) {
	    System.out.println("o(*^＠^*)oo(*^＠^*)"+workInInfo);
	    
	    // 날짜 및 시간 추출
	    String workInTime = (String) workInInfo.get("workin_time");

	    // WORKIN_TIME 값이 없으면 오류 처리
	    if (workInTime == null) {
	        System.err.println("WORKIN_TIME 값이 없습니다!");
	        return false;  // 또는 적절한 오류 반환
	    }

	    // ZonedDateTime으로 파싱 (ISO 8601 형식에 맞게 처리)
	    ZonedDateTime zonedDateTime = ZonedDateTime.parse(workInTime, DateTimeFormatter.ISO_DATE_TIME);

	    // 서울 시간으로 변환 (UTC에서 KST로 변환)
	    ZonedDateTime seoulDateTime = zonedDateTime.withZoneSameInstant(ZoneId.of("Asia/Seoul"));

	    // 원하는 형식으로 변환
	    String workDate = seoulDateTime.format(DateTimeFormatter.ofPattern("yyMMdd"));  // 예: 250312
	    String workTime = seoulDateTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));  // 예: 12:51:10

	    // 년-월-일을 포함한 날짜와 시간을 만들기 (yyyy-MM-dd HH:mm:ss)
	    String fullWorkTime = seoulDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd ")) + workTime;

	    // 결과 출력
	    System.out.println("work_date: " + workDate);
	    System.out.println("work_time: " + fullWorkTime);

	    // workInInfo 맵에 workDate와 workTime 추가
	    workInInfo.put("attno", workDate);  // ATTNO에 날짜 값 넣기, 이게 맞는지 확인 필요
	    workInInfo.put("workin_time", fullWorkTime);  // WORKIN_TIME에 yyyy-MM-dd HH:mm:ss 형식으로 값 추가

	    System.out.println(workInInfo);

	    // 반환값
//	    return attendanceDao.workInCheck(workInInfo);
	    return true;
	}
//
//	// 출근시간 조회 
//	  @GetMapping("/getTodayAttendance.do")
//	    public ResponseEntity<?> getTodayAttendance(
//	            @RequestParam("empno") String empno, 
//	            @RequestParam("date") String date) {
//
//	        // empno와 date를 사용하여 처리 로직 작성
//	        System.out.println("empno: " + empno);
//	        System.out.println("date: " + date);
//
//	        // 예시로 응답을 JSON 형식으로 반환
//	        Map<String, Object> response = new HashMap<String, Object>();
//	        response=attendanceDao.
////	        response.put("status", "success");
////	        response.put("empno", empno);
////	        response.put("date", date);
//
//	        return ResponseEntity.ok(response);
//	    }


	
	// 퇴근 등록
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
