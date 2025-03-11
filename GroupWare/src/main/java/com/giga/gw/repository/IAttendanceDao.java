package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

public interface IAttendanceDao {

	public void createattendacetable();
	
	public List<Map<String, Object>> leaveList();
}
