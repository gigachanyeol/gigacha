package com.giga.gw.service;

import java.util.List;

import com.giga.gw.dto.ApprovalFormDto;

public interface IApprovalFormService {
	int formInsert(ApprovalFormDto approvalFormDto);
	int formUpdate(ApprovalFormDto approvalFormDto);
	int formDelete(String form_id);
	List<ApprovalFormDto> formSelectAll();
	ApprovalFormDto formSelectDetail(String form_id);
}
