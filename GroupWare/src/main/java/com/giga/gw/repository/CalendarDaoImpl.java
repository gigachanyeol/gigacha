package com.giga.gw.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.CalendarDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CalendarDaoImpl implements ICalendarDao {

	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.CalendarDaoImpl.";
	
	@Override
	public int scheduleSave(String schedule) {
		return sessionTemplate.insert(NS+"scheduleSave",schedule);
	}
}
