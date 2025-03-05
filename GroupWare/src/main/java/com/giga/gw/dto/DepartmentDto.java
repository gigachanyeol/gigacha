package com.giga.gw.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DepartmentDto {

	private String deptno;
	private String deptname;
	private String parent_deptno;
	private String use_yn;
	private String create_date;
	private String update_date;
	private int create_emp;
	private int update_emp;

}
