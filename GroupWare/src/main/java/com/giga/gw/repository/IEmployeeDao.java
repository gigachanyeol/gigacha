package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

public interface IEmployeeDao {
	boolean saveSignature(Map<String, Object> map);
	List<Map<String, Object>> readSignature(List<String> empList);
}
