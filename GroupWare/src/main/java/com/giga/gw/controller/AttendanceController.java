package com.giga.gw.controller;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.IAttendanceDao;
import com.giga.gw.service.AttendanceServiceImpl;

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

		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
//		System.out.println("o(*^＠^*)oo(*^＠^*)o(*^＠^*)oo(*^＠^*)o(*^＠^*)oo(*^＠^*)"+loginDto.getEmpno());

		List<Map<String, Object>> leavelist = attendanceDao.leaveList(loginDto.getEmpno());
//		 for (Map<String, Object> map : leavelist) {
//			
//			map.put("empno",loginDto.getEmpno());
//			System.out.println("o(*^＠^*)oo(*^＠^*)"+map);
//			
//		}

//		 
		return ResponseEntity.ok(leavelist);
	}

	// 출퇴근 체크
	// 출퇴근 체크
	@PostMapping("/workIn.do")
	@ResponseBody
	public boolean workInCheck(@RequestBody Map<String, Object> workInInfo) {
//	    System.out.println("o(*^＠^*)oo(*^＠^*) " + workInInfo);

		String type = (String) workInInfo.get("type");

		if (type == null) {
			System.err.println("type 값이 없습니다!");
			return false;
		}

		// 날짜 및 시간 추출
		String workTimeString = (String) workInInfo.get(type.equals("check-in") ? "workin_time" : "workout_time");

		if (workTimeString == null) {
			System.err.println(type + " 시간 값이 없습니다!");
			return false;
		}

		try {
			// ZonedDateTime으로 파싱 (ISO 8601 형식에 맞게 처리)
			ZonedDateTime zonedDateTime = ZonedDateTime.parse(workTimeString, DateTimeFormatter.ISO_DATE_TIME);

			// 서울 시간으로 변환 (UTC에서 KST로 변환)
			ZonedDateTime seoulDateTime = zonedDateTime.withZoneSameInstant(ZoneId.of("Asia/Seoul"));

			// 원하는 형식으로 변환
			String workDate = seoulDateTime.format(DateTimeFormatter.ofPattern("yyMMdd")); // 예: 250312
			String workTime = seoulDateTime.format(DateTimeFormatter.ofPattern("HH:mm:ss")); // 예: 12:51:10
			String fullWorkTime = seoulDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")); // 예:
																											// 2025-03-12
																											// 12:51:10

			// workInInfo 맵에 값 추가
			workInInfo.put("attno", workDate); // ATTNO에 날짜 값 넣기
			workInInfo.put(type.equals("check-in") ? "workin_time" : "workout_time", fullWorkTime);

			System.out.println("work_date: " + workDate);
			System.out.println("work_time: " + fullWorkTime);
			System.out.println(workInInfo);

			// 출근 / 퇴근에 따라 처리
			if (type.equals("check-in")) {
				return attendanceDao.workInCheck(workInInfo);
			} else {
				return attendanceDao.workOutCheck(workInInfo);
			}

		} catch (DateTimeParseException e) {
			System.err.println("시간 파싱 오류: " + e.getMessage());
			return false;
		}
	}

	// 시간 파싱

//
	@PostMapping("/getAttendance.do")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> getAttendance(@RequestBody Map<String, Object> requestData) {
	    try {
	        // 요청 데이터 확인
	        String empno = (String) requestData.get("empno"); // 사원번호
	        String attno = (String) requestData.get("attno"); // 출근 기록 날짜 (yyMMdd)

	        System.out.println("📌 요청 데이터: " + requestData);
	        
	        // attno가 null이 아니고 6자리 이상이면 substring
	        if (attno != null && attno.length() >= 6) {
	            attno = attno.substring(2, 6); // yyMMdd -> yyMM (월 단위 조회)
	            requestData.put("attno", attno);
	        } else {
	            return ResponseEntity.noContent().build(); // attno가 잘못된 경우 빈 응답 반환
	        }

	        // 출근 데이터 조회
	        List<Map<String, Object>> attendanceData = attendanceDao.getAttendance(requestData);

	        System.out.println("📌 출근 데이터: " + attendanceData);
	        
	        // 데이터가 없으면 빈 리스트 반환
	        if (attendanceData.isEmpty()) {
	            return ResponseEntity.ok(Collections.emptyList());
	        }
	        
	        for (Map<String, Object> map : attendanceData) {
	        	
	        	map.put("ATTNO", ((String) map.get("ATTNO")).substring(0,6));
			}

	        // 데이터가 있으면 반환
	        return ResponseEntity.ok(attendanceData);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.internalServerError().build(); // 예외 발생 시 500 반환
	    }
	}



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
