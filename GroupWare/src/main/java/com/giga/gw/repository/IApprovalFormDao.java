package com.giga.gw.repository;

import java.util.List;

import com.giga.gw.dto.ApprovalFormDto;

public interface IApprovalFormDao {
	int formInsert(ApprovalFormDto approvalFormDto);
	int formUpdate(ApprovalFormDto approvalFormDto);
	int formDelete(String form_id);
	List<ApprovalFormDto> formSelectAll();
	ApprovalFormDto formSelectDetail(String form_id);
}
