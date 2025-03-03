package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import com.giga.gw.dto.ApprovalDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApprovalDaoImpl implements IApprovalDao {
	
	private final SqlSessionTemplate sql;
	private final String NS = "com.giga.gw.repository.ApprovalDaoImpl.";
	
	@Override
	public List<Map<String, Object>> getDepartments() {
		return sql.selectList(NS+"getDepartments");
	}

	@Override
	public List<Map<String, Object>> getEmployeesByDepartment() {
		return sql.selectList(NS+"getEmployeesByDepartment");
	}

	@Override
	public List<Map<String, Object>> getOrganizationTree() {
		return sql.selectList(NS+"getOrganizationTree");
	}

	@Override
	public int editorSave(String content) {
		return sql.insert(NS+"editorSave",content);
	}

	@Override
	public String editorRead() {
		return sql.selectOne(NS+"editorRead");
	}

	@Override
	public int countApproval(String form_id) {
		return sql.selectOne(NS+"countApproval",form_id);
	}

	@Override
	public int insertApproval(ApprovalDto approvalDto) {
		return sql.insert(NS+"insertApproval",approvalDto);
	}

	@Override
	public int updateApproval(ApprovalDto approvalDto) {
		return sql.update(NS+"updateApproval",approvalDto);
	}

	@Override
	public ApprovalDto selectApprovalById(String approval_id) {
		return sql.selectOne(NS+"selectApprovalById",approval_id);
	}

	@Override
	public int recallApproval(String approval_id) {
		return sql.update(NS+"recallApproval",approval_id);
	}

	@Override
	public List<Map<String, Object>> formTree() {
		return sql.selectList(NS+"formTree");
	}

	@Override
	public int insertApprovalTemp(ApprovalDto approvalDto) {
		return sql.insert(NS+"insertApprvalTemp", approvalDto);
	}

}
