package com.giga.gw.repository;

import java.util.Map;

import com.giga.gw.dto.CalendarDto;

public interface ICalendarDao {

    int scheduleSave(Map<String, Object> schedule);
}
