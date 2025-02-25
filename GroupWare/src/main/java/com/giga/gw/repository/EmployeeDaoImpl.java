package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
@RequiredArgsConstructor
public class EmployeeDaoImpl implements IEmployeeDao {
	
	private final SqlSessionTemplate sql;
	private final String NS = "com.giga.gw.repository.EmployeeDaoImpl.";
	
	@Override
	public boolean saveSignature(Map<String, Object> map) {
		return sql.insert(NS+"saveSignature",map)==1?true:false;
	}

	@Override
	public List<Map<String, Object>> readSignature(List<String> empList) {
		return sql.selectList(NS+"readSignature",empList);
	}

}
