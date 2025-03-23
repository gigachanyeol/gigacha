package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ApprovalFormDto;

public interface IApprovalFormDao {
	int formInsert(ApprovalFormDto approvalFormDto);
	int formUpdate(ApprovalFormDto approvalFormDto);
	int formUpdateUseYN(Map<String, Object> map);
	List<ApprovalFormDto> formSelectAll();
	ApprovalFormDto formSelectDetail(String form_id);
	Map<String, Object> formSelectById(String form_id);
}
