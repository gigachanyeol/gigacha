package com.giga.gw.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.repository.IEmployeeDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class EmployeeServiceImpl implements IEmployeeService {
	
	private final IEmployeeDao employeeDao;
	
	@Override
	public boolean saveSignature(Map<String, Object> map) {
		employeeDao.updateSignature(map.get("empno").toString());
		return employeeDao.saveSignature(map);
	}

	@Override
	public List<Map<String, Object>> readSignature(String empno) {
		
		return employeeDao.readSignature(empno);
	}

}
