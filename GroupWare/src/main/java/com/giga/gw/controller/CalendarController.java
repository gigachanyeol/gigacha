package com.giga.gw.controller;

import java.nio.file.AccessDeniedException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.ICalendarDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/calendar")
@RequiredArgsConstructor
@Slf4j
public class CalendarController {

	private final ICalendarDao calendarDao;

	// 사용 안 함
	@GetMapping("/tostcalendar.do")
	public String tostcalendar() {
		return "tostcalendar";
	}

	// View 반환
	@GetMapping("/calendar.do")
	public String fullcalendar(HttpSession session) {
		log.info("📢 세션 정보: {}", session);
		return "calendar";
	}

	// 일정 저장
	@PostMapping("/saveSchedule.do")
	@ResponseBody
	public boolean saveSchedule(@RequestBody Map<String, Object> schedule) {
		log.info("📢 컨트롤러 도착! 요청 데이터: {}", schedule);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> events = (List<Map<String, Object>>) schedule.get("events");

		for (Map<String, Object> event : events) {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("empno", event.get("empno"));
			paramMap.put("sch_title", event.get("sch_title"));

			// 🛠️ ISO 8601 형식의 날짜 문자열을 Timestamp로 변환
			paramMap.put("sch_startdate", convertToTimestamp((String) event.get("start")));
			paramMap.put("sch_enddate", convertToTimestamp((String) event.get("end")));

			paramMap.put("sch_color", event.get("color"));
			
			paramMap.put("sch_content", event.get("sch_content"));
			paramMap.put("create_empno", event.get("empno"));
			
			
			

			log.info("📌 저장할 데이터: {}", paramMap);
			calendarDao.scheduleSave(paramMap);
		}
		return true;
	}

	// ISO 8601 날짜 문자열을 Timestamp로 변환하는 메서드
	private Timestamp convertToTimestamp(String isoDateString) {
		try {
			// ISO 8601 형식 파싱 (예: 2024-03-05T09:00:00)
			LocalDateTime localDateTime = LocalDateTime.parse(isoDateString);
			return Timestamp.valueOf(localDateTime);
		} catch (DateTimeParseException e) {
			log.error("날짜 변환 오류: {}", isoDateString, e);
			return null; // 또는 기본 Timestamp 반환
		}
	}

	///////////////////////////////////////////////// 일정 조회
	public enum ScheduleAccessLevel {
		PERSONAL, // 개인 일정만 조회
		DEPARTMENT, // 부서 일정 조회 가능
		HR, // 인사팀 - 전체 일정 조회
		MANAGER // 관리자 - 모든 일정 조회
	}

	@GetMapping("/loadSchedule.do")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> loadSchedule(
	    @RequestParam("start") String start,
	    @RequestParam("end") String end, 
	    HttpSession session
	) {
	    // 로그인 사용자 정보 확인
	    EmployeeDto loginUser = (EmployeeDto) session.getAttribute("loginDto");
	    
	    // 로그인 사용자 null 체크
	    if (loginUser == null) {
	        log.warn("⚠️ 미인증 사용자의 일정 조회 시도");
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
	    }
	    
	    log.info("📢 로그인된 사용자 정보 확인: {}", loginUser);

	    try {
	        // 사용자 권한 레벨 결정
	        ScheduleAccessLevel accessLevel = determineAccessLevel(loginUser);
	        
	        // 요청 타입 결정
	        String requestType = switch (accessLevel) {
	            case PERSONAL -> "personal";
	            case DEPARTMENT -> "department";
	            case HR, MANAGER -> "all";
	            default -> throw new AccessDeniedException("일정 조회 권한 없음");
	        };

	        log.info("📢 요청 타입 결정: {}", requestType);
	        log.info("📢 로그인한 사용자: {}", loginUser.getEmpno());
	        // 일정 조회
//	        List<Map<String, Object>> schedules = switch (requestType) {
//	            case "personal" -> calendarDao.loadEmpSchedule(loginUser.getEmpno());
//	            case "department" -> calendarDao.loadDeptSchedule(loginUser.getDeptno());
//	            case "all" -> calendarDao.loadAllSchedule();
//	            default -> Collections.emptyList();
//	        };
	        List<Map<String, Object>> schedules = calendarDao.loadEmpSchedule(loginUser.getEmpno());
	        
	        log.info("📢 일정 조회 성공");

	        // 데이터 없음 체크
	        if (schedules == null || schedules.isEmpty()) {
	            log.info("📌 조회된 일정 없음");
	            return ResponseEntity.noContent().build();
	        }

//	        // 날짜 파싱 및 필터링
//	        LocalDateTime filterStart = LocalDateTime.parse(start);
//	        LocalDateTime filterEnd = LocalDateTime.parse(end);
//
//	        List<Map<String, Object>> filteredSchedules = schedules.stream()
//	            .filter(schedule -> {
//	                try {
//	                    LocalDateTime scheduleStart = parseDateTime(schedule.get("SCH_STARTDATE"));
//	                    LocalDateTime scheduleEnd = parseDateTime(schedule.get("SCH_ENDDATE"));
//	                    
//	                    return (scheduleStart.isBefore(filterEnd) && scheduleEnd.isAfter(filterStart));
//	                } catch (Exception e) {
//	                    log.warn("⚠️ 일정 날짜 파싱 오류: {}", schedule, e);
//	                    return false;
//	                }
//	            })
//	            .collect(Collectors.toList());
//
//	        log.info("📌 필터링된 일정 건수: {}", filteredSchedules.size());
	        return ResponseEntity.ok(schedules);

	    } catch (AccessDeniedException e) {
	        log.warn("🚫 접근 권한 없음: {}", e.getMessage());
	        return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
	    } catch (Exception e) {
	        log.error("❌ 일정 조회 중 예상치 못한 오류 발생", e);
	        return ResponseEntity.internalServerError().build();
	    }
	}

	private ScheduleAccessLevel determineAccessLevel(EmployeeDto loginUser) {
	    // null 체크 (메서드 호출 전 이미 체크했지만 안전을 위해 추가)
	    if (loginUser == null) {
	        log.warn("⚠️ 사용자 정보 없음");
	        return ScheduleAccessLevel.PERSONAL;
	    }

	    // HR 부서 확인 (문자열 비교 시 equals 사용)
	    if ("D01".equals(loginUser.getDeptno())) {
	        return ScheduleAccessLevel.HR;
	    }

	    // 관리자 확인 (문자열 비교 시 equals 사용)
	    if ("J01".equals(loginUser.getJob_id())) {
	        return ScheduleAccessLevel.MANAGER;
	    }

	    // 부서장 확인 (문자열 비교 시 equals 사용)
	    if ("J02".equals(loginUser.getJob_id())) {
	        return ScheduleAccessLevel.DEPARTMENT;
	    }

	    // 기본은 개인 일정
	    return ScheduleAccessLevel.PERSONAL;
	}

	// 날짜 파싱 헬퍼 메서드
	private LocalDateTime parseDateTime(Object dateObj) {
	    if (dateObj == null) {
	        throw new IllegalArgumentException("날짜 정보가 없습니다.");
	    }
	    
	    String dateStr = dateObj.toString();
	    try {
	        return LocalDateTime.parse(dateStr);
	    } catch (DateTimeParseException e) {
	        log.warn("날짜 파싱 오류: {}", dateStr);
	        throw e;
	    }
	}

//    @GetMapping("/loadSchedule.do")
//    @ResponseBody
//    public List<Map<String, Object>> loadSchedule(@RequestParam("start") String start, 
//                                                  @RequestParam("end") String end) {
//        log.info("📢 일정 데이터 요청: {} ~ {}", start, end);
//
//        List<Map<String, Object>> schedules = calendarDao.loadSchedule(start, end);
//
//        if (schedules == null || schedules.isEmpty()) {
//            log.warn("⚠️ 반환할 일정 데이터가 없습니다!");
//            return Collections.emptyList();
//        }
//
//        log.info("📌 FullCalendar로 보낼 데이터: {}", schedules);
//        return schedules;
//    }
	
	@DeleteMapping("/deleteSchedule.do") // DELETE 요청 처리
	@ResponseBody
	public ResponseEntity<Object> deleteSchedule(@RequestBody Map<String, String> requestBody) {
		try {
	        String id = requestBody.get("id");
	        log.info("📢 일정 삭제 요청: {}", id);


	        boolean success = calendarDao.deleteSchedule(id);  //삭제 성공여부

	        if(success){
	             return ResponseEntity.ok().build(); // 200 OK, 삭제 성공
	        } else {
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Schedule not found"); //404
	        }


	    } catch (Exception e) {
	        log.error("일정 삭제 중 오류 발생", e);
	        return ResponseEntity.internalServerError().build(); // 500 Internal Server Error
	    }
	}

}
