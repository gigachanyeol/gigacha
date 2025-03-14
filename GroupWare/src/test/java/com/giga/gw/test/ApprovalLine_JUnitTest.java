package com.giga.gw.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.ApprovalLineDto;
import com.giga.gw.repository.IApprovalLineDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class ApprovalLine_JUnitTest {
	
	@Autowired
	private IApprovalLineDao approvalLineDao;
	
	
	// 결재선 여러명
//	@Test
	public void insertApprovalLines_Test() {
//		ApprovalLineDto dto1 = ApprovalLineDto.builder().approval_id("HR005DOC0001").approver_empno(2501006).build();
//		ApprovalLineDto dto2 = ApprovalLineDto.builder().approval_id("HR005DOC0001").approver_empno(2501007).build();
//		ApprovalLineDto dto3 = ApprovalLineDto.builder().approval_id("HR005DOC0001").approver_empno(2501008).build();
//		List<ApprovalLineDto> lists = List.of(dto1,dto2,dto3);	
//		approvalLineDao.insertApprovalLine(lists);
	}
	
	// 결재선 1명
//	@Test
	public void insertApprovalLine_Test() {
		List<ApprovalLineDto> list = new ArrayList();
//		ApprovalLineDto dto1 = ApprovalLineDto.builder().approval_id("HR005DOC0001").approver_empno(2501013).build();
//		list.add(dto1);
//		approvalLineDao.insertApprovalLine(list);
	}

}
