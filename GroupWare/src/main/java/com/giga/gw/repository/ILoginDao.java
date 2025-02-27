package com.giga.gw.repository;

import java.util.Map;

import com.giga.gw.dto.EmployeeDto;

public interface ILoginDao {

	EmployeeDto login(Map<String, Object> map);
}
