package com.giga.gw.test;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.ApprovalCategoryDto;
import com.giga.gw.repository.IApprovalCategoryDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class ApprovalCategory_JUnitTest {

	@Autowired
	private IApprovalCategoryDao approvalCategoryDao;

	// 문서양식카테고리 insert
//	@Test
	public void categoryInsert_Test() {
		ApprovalCategoryDto dto = ApprovalCategoryDto.builder().category_name("인사").category_yname("HR").build();
		assertNotEquals(0, approvalCategoryDao.categoryInsert(dto));
	}

	// 문서양식 조회 List  select
//	@Test
	public void categorytSelect_Test() {
		List<ApprovalCategoryDto> lists = approvalCategoryDao.categorySelect();
		assertNotEquals(0, lists.size());
	}
	
	// 문서양식 1개 조회
//	@Test
	public void categorySelectById() {
		ApprovalCategoryDto dto = approvalCategoryDao.categorySelectById("CATE03");
		assertNotNull(dto);
	}
	// 카테고리 약어 중복체크
//	@Test
	public void categoryCheck() {
		assertNotEquals(0, approvalCategoryDao.categoryCheck("AD"));
	}
}
