package com.giga.gw.test;

import static org.junit.Assert.assertNotEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.ApprovalFormDto;
import com.giga.gw.repository.IApprovalFormDao;
import com.giga.gw.service.IApprovalFormService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class ApprovalForm_JUnitTest {
	
	@Autowired
	private IApprovalFormDao approvalFormDao;
	
	@Autowired
	private IApprovalFormService approvalFormService;
	
	// 결재양식 INSERT 
//	@Test
	public void insertTest() {
		ApprovalFormDto dto = ApprovalFormDto
				.builder()
				.category_id("CATE03")
				.form_name("휴가")
				.form_content("컨텐츠~~~~")
				.build();		
		approvalFormDao.formInsert(dto);
	}
	
	// 결재양식 UPDATE
//	@Test
	public void updateTest() {
		ApprovalFormDto approvalFormDto = ApprovalFormDto.builder()
				.form_id("HR021")
				.form_name("JUnit 수정")
				.form_content("JUnit 수정 테스트 ~~~~~ ")
				.build();
		assertNotEquals(0, approvalFormService.formUpdate(approvalFormDto));
	}
	// 결재양식 DELETE
	@Test
	public void deleteTest() {
		assertNotEquals(0, approvalFormDao.formDelete("HR021"));
	}

}
