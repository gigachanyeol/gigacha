package com.giga.gw.controller;

import java.sql.Timestamp;
import java.time.OffsetDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.repository.ICalendarDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/calendar")
@RequiredArgsConstructor
@Slf4j
public class CalendarController {

	private final ICalendarDao calendarDao;

	// 사용안함
	@GetMapping("/tostcalendar.do")
	public String tostcalendar() {
		return "tostcalendar";
	}

	// 사용
	@GetMapping("/calendar.do")
	public String fullcalendar(HttpSession session) {

		System.out.println(session);

//		session.setAttribute("loginDto", employeeDto);

		return "calendar";
	}

	@PostMapping("/saveSchedule.do")
	@ResponseBody
	public boolean SaveSchedule(@RequestBody Map<String, Object> schedule) {
	    log.info("📢 컨트롤러 도착! 요청 데이터: {}", schedule);

	    @SuppressWarnings("unchecked")
	    List<Map<String, Object>> events = (List<Map<String, Object>>) schedule.get("events");

	    for (Map<String, Object> event : events) {
	        Map<String, Object> paramMap = new HashMap<>();
	        paramMap.put("empno", "1505001");
	        paramMap.put("sch_title", event.get("title"));
	        
	        // 🛠️ ISO 8601 형식의 날짜 문자열을 Timestamp로 변환
	        paramMap.put("sch_startdate", convertToTimestamp((String) event.get("start")));
	        paramMap.put("sch_enddate", convertToTimestamp((String) event.get("end")));

	        paramMap.put("sch_color", event.get("backgroundColor"));
	        
	        log.info("📌 저장할 데이터: {}", paramMap);
	        calendarDao.scheduleSave(paramMap);
	    }
	    return true;
	}

	// 🛠️ ISO 8601 날짜 문자열을 Timestamp로 변환하는 메서드
	private Timestamp convertToTimestamp(String isoDate) {
	    return Timestamp.valueOf(OffsetDateTime.parse(isoDate).toLocalDateTime());
	}
}
