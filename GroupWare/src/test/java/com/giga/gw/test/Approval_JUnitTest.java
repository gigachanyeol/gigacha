package com.giga.gw.test;

import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;
import java.util.Map;

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
	
	// 조직도 Select 
//	@Test
	public void getOrganizationTree_Test() {
		List<Map<String, Object>> tree = approvalDao.getOrganizationTree();
		assertNotEquals(0, tree.size());
	}
	
	// 문서양식별 작성된 결재문서 갯수
//	@Test
	public void countApproval() {
		assertNotEquals(0, approvalDao.countApproval("HR001"));
	}
	
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
				.empno("2501001")
				.approval_title("문서제목")
				.approval_content("문서작성테스트")
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
		dto.setUpdate_empno("1501001");
		
		assertNotEquals(0, approvalDao.updateApproval(dto));
	}
	
	// 결재문서 회수 update 
	@Test
	public void recallApproval_Test() {
		String approval_id = "HR005DOC0001";
		assertNotEquals(0,approvalDao.recallApproval(approval_id));
	}

}
