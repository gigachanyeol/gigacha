package com.giga.gw.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.ApprovalDto;
import com.giga.gw.repository.IApprovalDao;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class Approval_JUnitTest {
	
	@Autowired
	private IApprovalDao approvalDao;
	
	// 결재문서 select id
//	@Test
	public void selectApprovalById_Test() {
		assertNotNull(approvalDao.selectApprovalById("HR005DOC0001"));
	}
	
	// 결재문서 INSERT
//	@Test
	public void insertApproval_Test() {
		ApprovalDto dto = ApprovalDto
				.builder()
				.form_id("HR005")
				.empno(2501001)
				.approval_title("title~~~~~")
				.approval_content("문서InsertTest~~~~~!~")
				.approval_deadline("2025-03-01")
				.build();
		assertNotEquals(0, approvalDao.insertApproval(dto));
	}
	// 결재문서 수정 update
//	@Test
	public void updateApproval_Test() {
		ApprovalDto dto = approvalDao.selectApprovalById("HR005DOC0001");
		System.out.println(dto);
		dto.setApproval_title("update title");
		dto.setApproval_content("content ~~ update");
		dto.setApproval_deadline("2025-03-07");
		dto.setUpdate_empno(1501001);
		
		assertNotEquals(0, approvalDao.updateApproval(dto));
	}
	
	// 결재문서 회수 update 
	@Test
	public void recallApproval_Test() {
		String approval_id = "HR005DOC0001";
		assertNotEquals(0,approvalDao.recallApproval(approval_id));
	}

}
