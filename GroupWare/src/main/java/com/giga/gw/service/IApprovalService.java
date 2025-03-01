package com.giga.gw.service;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ApprovalDto;

public interface IApprovalService {
	List<Map<String, Object>> getOrganizationTree();
	int countApproval(String form_id);
	boolean insertApproval(ApprovalDto approvalDto);
    int updateApproval(ApprovalDto approvalDto);
    
    ApprovalDto selectApprovalById(String approval_id);
    int recallApproval(String approval_id);
    List<Map<String, Object>> formTree();
}
