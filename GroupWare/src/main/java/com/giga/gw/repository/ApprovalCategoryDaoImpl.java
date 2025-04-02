package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.ApprovalCategoryDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApprovalCategoryDaoImpl implements IApprovalCategoryDao {

	private final SqlSessionTemplate sql;
	private final String NS = "com.giga.gw.repository.ApprovalCategoryDaoImpl.";

	@Override
	public int categoryInsert(ApprovalCategoryDto dto) {
		return sql.insert(NS + "categoryInsert", dto);
	}

	@Override
	public List<ApprovalCategoryDto> categorySelect() {
		return sql.selectList(NS+"categorySelect");
	}

	@Override
	public ApprovalCategoryDto categorySelectById(String category_id) {
		return sql.selectOne(NS+"categorySelectById",category_id);
	}

	@Override
	public int categoryCheck(String category_yname) {
		return sql.selectOne(NS+"categoryCheck",category_yname);
	}

	@Override
	public int categoryUpdateUseYN(Map<String, Object> map) {
		return sql.update(NS+"categoryUpdateUseYN",map);
	}

	@Override
	public List<ApprovalCategoryDto> categorySelectAll() {
		return sql.selectList(NS+"categorySelectAll");
	}

	@Override
	public int cntCategoryAll() {
		return sql.selectOne(NS+"cntCategoryAll");
	}
	
}
