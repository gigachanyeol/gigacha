package com.giga.gw.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class ApprovalDto {
	String approval_id,
	form_id,
	approval_title,
	approval_content,
	approval_status,
	create_date,
	update_date,
	use_yn,
	approval_deadline,
	approval_urgency,
	temp_save_yn;
	int empno,
	update_empno;
}
