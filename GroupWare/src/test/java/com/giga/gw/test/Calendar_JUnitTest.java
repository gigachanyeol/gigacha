package com.giga.gw.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.CalendarDto;
import com.giga.gw.repository.ICalendarDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class Calendar_JUnitTest {

	@Autowired
	private ICalendarDao calendarDao;
	
	
//	@Test
//	public void scheduleSaveTest() {
//		CalendarDto dto = CalendarDto.builder()
//									.empno(15001)
//									.sch_title("테스트")
//									.sch_content("테스트 내용~~")
//									.build();
//		calendarDao.scheduleSave(dto);									
//	}

}
