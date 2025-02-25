package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

public interface IApprovalDao {
	List<Map<String, Object>> getDepartments();
    List<Map<String, Object>> getEmployeesByDepartment();
    List<Map<String, Object>> getOrganizationTree();
    int editorSave(String content);
    String editorRead();
}
