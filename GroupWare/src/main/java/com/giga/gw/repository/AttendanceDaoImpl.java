package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AttendanceDaoImpl implements IAttendanceDao {

	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.AttendanceDaoImpl.";

	@Override
	public void createattendacetable() {
		sessionTemplate.insert(NS + "createattendacetable");
	}

	@Override
	public void resetSequence() {
		sessionTemplate.update(NS + "resetSequence");
	}

	@Override
	public List<Map<String, Object>> leaveList() {
		List<Map<String, Object>> list = sessionTemplate.selectList(NS + "leaveListByEmpno", "1505001");
		System.out.println(list);
		return list;
	}

	@Override
	public boolean workInCheck(Map<String, Object>  workInInfo) {
		sessionTemplate.update(NS + "workInCheck", workInInfo);
		return false;
	}
}
