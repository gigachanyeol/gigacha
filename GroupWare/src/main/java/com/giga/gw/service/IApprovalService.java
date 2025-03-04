package com.giga.gw.service;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ApprovalDto;

public interface IApprovalService {
	List<Map<String, Object>> getOrganizationTree();
	int countApproval(String form_id);
	boolean insertApproval(ApprovalDto approvalDto);
	boolean insertApprovalTemp(ApprovalDto approvalDto);
    int updateApproval(ApprovalDto approvalDto);
    ApprovalDto selectApprovalById(String approval_id);
    int recallApproval(String approval_id);
    List<Map<String, Object>> formTree();
    List<ApprovalDto> selectApproval(int empno);
    List<ApprovalDto> selectApprovalTemp(String empno);
    int approvalRequest(String approval_id);
    List<ApprovalDto> selectPendingApprovalDocuments(String empno);
    List<ApprovalDto> selectApprovalInProgress(String empno);
    List<ApprovalDto> selectApprovalCompleted(String empno);
    List<ApprovalDto> selectApprovalRejected(String empno);
}
