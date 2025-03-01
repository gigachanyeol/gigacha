package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

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
	
	
}
