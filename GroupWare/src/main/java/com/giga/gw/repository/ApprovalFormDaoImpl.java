package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

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
	public int formUpdateUseYN(Map<String, Object> map) {
		return sql.update(NS+"formUpdateUseYN",map);
	}

	@Override
	public List<ApprovalFormDto> formSelectAll() {
		return sql.selectList(NS+"formSelectAll");
	}

	@Override
	public ApprovalFormDto formSelectDetail(String form_id) {
		return sql.selectOne(NS+"formSelectDetail",form_id);
	}

	@Override
	public Map<String, Object> formSelectById(String form_id) {
		return sql.selectOne(NS+"formSelectById",form_id);
	}

}
