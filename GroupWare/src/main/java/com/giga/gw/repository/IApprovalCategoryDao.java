package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ApprovalCategoryDto;

public interface IApprovalCategoryDao {
	int categoryInsert(ApprovalCategoryDto dto);
	List<ApprovalCategoryDto> categorySelect();
	List<ApprovalCategoryDto> categorySelectAll();
	ApprovalCategoryDto categorySelectById(String category_id);
	int categoryCheck(String category_yname);
	int categoryUpdateUseYN(Map<String, Object> map);
}
