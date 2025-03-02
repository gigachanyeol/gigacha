package com.giga.gw.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApprovalLineDto {
	String approval_id, reject_reason, create_date, status_id, approval_time, update_date, use_yn;
	int line_id, sequence, approver_empno, delegatee_empno;
}
