package com.giga.gw.service;

import java.util.List;
import java.util.Map;

public interface IEmployeeService {
	boolean saveSignature(Map<String, Object> map);
	List<Map<String, Object>> readSignature(String empno);
}
