package com.giga.gw.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.ApprovalFormDto;
import com.giga.gw.repository.IApprovalFormDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class ApprovalForm_JUnitTest {
	
	@Autowired
	private IApprovalFormDao approvalFormDao;
	@Test
	public void test() {
		ApprovalFormDto dto = ApprovalFormDto
				.builder()
				.category_id("CATE03")
				.form_name("휴가")
				.form_content("컨텐츠~~~~")
				.build();		
		approvalFormDao.formInsert(dto);
	}

}
