package com.giga.gw.repository;

import com.giga.gw.dto.ApprovalFormDto;

public interface IApprovalFormDao {
	int formInsert(ApprovalFormDto approvalFormDto);
	int formUpdate(ApprovalFormDto approvalFormDto);
	int formDelete(String form_id);
}
