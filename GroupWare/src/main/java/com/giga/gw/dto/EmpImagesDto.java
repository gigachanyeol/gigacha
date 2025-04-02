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
public class EmpImagesDto {

	private String signature_id;
	private int empno;
	private String file_name;
	private String file_path;
	private String file_base;
	private String update_date;
	private String create_date;
	private int gubun;
	private String use_yn;

}
