package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.checkerframework.checker.units.qual.m;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.ApprovalLineDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApprovalLineDaoImpl implements IApprovalLineDao{
	
	private final SqlSessionTemplate sql;
	private final String NS = "com.giga.gw.repository.ApprovalLineDaoImpl.";
	
	@Override
	public int insertApprovalLine(Map<String, Object> lines) {
		return sql.insert(NS+"insertApprovalLines",lines);
	}

	@Override
	public int insertApprovalLine(ApprovalLineDto line) {
		return sql.insert(NS+"insertApprovalLine",line);
	}

	@Override
	public int acceptApprovalLine(Map<String, Object> map) {
		return sql.update(NS+"acceptApprovalLine",map);
	}

	@Override
	public int rejectApprovalLine(Map<String, Object> map) {
		return sql.update(NS+"rejectApprovalLine",map);
	}

	@Override
	public int countApprovalLine(String approval_id) {
		return sql.selectOne(NS+"countApprovalLine",approval_id);
	}
	@Override
	public int countApprovalLine(Map<String, Object> map) {
		return sql.selectOne(NS+"countApprovalLine",map);
	}


	@Override
	public int deleteApprovalLine(String approval_id) {
		return sql.delete(NS+"deleteApprovalLine",approval_id);
	}
	
	
}
