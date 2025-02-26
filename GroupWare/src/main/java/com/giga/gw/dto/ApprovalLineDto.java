package com.giga.gw.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ApprovalLineDto {
	String approval_id, reject_reason, create_date, status_id, approval_time, update_date, use_yn;
	int line_id, sequence, approver_empno, delegatee_empno;
}
