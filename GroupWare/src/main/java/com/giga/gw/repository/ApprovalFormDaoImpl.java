package com.giga.gw.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.ApprovalFormDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApprovalFormDaoImpl implements IApprovalFormDao {
	private final SqlSessionTemplate sql;
	private String NS = "com.giga.gw.repository.ApprovalFormDaoImpl.";
	
	@Override
	public int formInsert(ApprovalFormDto approvalFormDto) {
		return sql.insert(NS+"formInsert",approvalFormDto);
	}

	@Override
	public int formUpdate(ApprovalFormDto approvalFormDto) {
		return sql.update(NS+"formUpdate",approvalFormDto);
	}

	@Override
	public int formDelete(String form_id) {
		return sql.update(NS+"formDelete",form_id);
	}

}
