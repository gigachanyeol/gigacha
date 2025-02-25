package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

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

}
