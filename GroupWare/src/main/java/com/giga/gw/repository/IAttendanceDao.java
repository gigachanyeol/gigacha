package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

public interface IAttendanceDao {

	//근무 테이블 만들기
	public void createattendacetable();
	//시퀀스 초기화 하는거
	public void dropSequence();
	public void createSequence();
	
	// 연차 불러오기
	public List<Map<String, Object>> leaveList(String empno);
	
	//출근시간 체크
	public boolean workInCheck(Map<String, Object>  workInInfo);
	
}
