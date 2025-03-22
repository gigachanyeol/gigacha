package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

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
	public List<Map<String, Object>> getOrganizationTree(String empno) {
		return sql.selectList(NS+"getOrganizationTree",empno);
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
		return sql.insert(NS+"insertApprovalTemp", approvalDto);
	}

	@Override
	public List<ApprovalDto> selectApproval(int empno) {
		return sql.selectList(NS+"selectApproval", empno);
	}

	@Override
	public int approvalRequest(String approval_id) {
		return sql.update(NS+"approvalRequest",approval_id);
	}

	@Override
	public List<ApprovalDto> selectPendingApprovalDocuments(String empno) {
		return sql.selectList(NS+"selectPendingApprovalDocuments",empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalTemp(String empno) {
		return sql.selectList(NS+"selectApprovalTemp",empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalInProgress(String empno) {
		return sql.selectList(NS+"selectApprovalInProgress",empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalCompleted(String empno) {
		return sql.selectList(NS+"selectApprovalCompleted",empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalRejected(String empno) {
		return sql.selectList(NS+"selectApprovalRejected",empno);
	}

	@Override
	public List<Map<String, Object>> selectApprovalMyDocuments(String empno) {
		return sql.selectList(NS+"selectApprovalMyDocuments",empno);
	}

	@Override
	public List<Map<String, Object>> selectApprovalReference(String empno) {
		return sql.selectList(NS+"selectApprovalReference",empno);
	}

	@Override
	public int finalApprovalStatus(Map<String, Object> map) {
		return sql.update(NS+"finalApprovalStatus", map);
	}

	@Override
	public List<Map<String, Object>> postLeaveToCalendar(String empno) {
		return sql.selectList(NS+"postLeaveToCalendar",empno);
	}

	@Override
	public int insertApprovalReferences(Map<String, Object> references) {
		return sql.insert(NS+"insertApprovalReferences",references);
	}


}
