package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.EmployeeDto;

public interface IEmployeeDao {
	boolean saveSignature(Map<String, Object> map);
	List<Map<String, Object>> readSignature(String empno);
	int updateSignature(String empno);
	
	// empno 값 가져오기
	String getNextEmpno(String empno);
	
	// 사원 등록
	int insertEmployee(Map<String, Object> map);
	
	// 사원 리스트
	List<EmployeeDto> employeeList();
}
