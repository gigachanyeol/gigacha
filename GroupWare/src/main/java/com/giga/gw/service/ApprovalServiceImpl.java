package com.giga.gw.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.ApprovalDto;
import com.giga.gw.repository.IApprovalDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalServiceImpl implements IApprovalService {
	
	private final IApprovalDao approvalDao;
	
	@Override
	public List<Map<String, Object>> getOrganizationTree() {
//		List<Map<String, Object>> departmentList = approvalDao.getDepartments();
//        List<Map<String, Object>> employeeList = approvalDao.getEmployeesByDepartment();
//        List<Map<String, Object>> tree = ;
//        List<Map<String, Object>> treeData = new ArrayList<>();
     // 직원 데이터 변환
//        for (Map<String, Object> emp : employeeList) {
//            emp.put("id", String.valueOf(emp.get("id"))); // 직원 ID 변환
//            emp.put("text", emp.get("text")); // 직원 이름
//            emp.put("parent", String.valueOf(emp.get("parent"))); // 부서 ID 그대로 사용
//            treeData.add(emp);
//        }
//        treeData.addAll(employeeList);
//        treeData.addAll(departmentList); // 부서 추가
//		return treeData;
        return approvalDao.getOrganizationTree();
	}

	@Override
	public int countApproval(String form_id) {
		return approvalDao.countApproval(form_id);
	}

	@Override
	public int insertApproval(ApprovalDto approvalDto) {
		return approvalDao.insertApproval(approvalDto);
	}

	@Override
	public int updateApproval(ApprovalDto approvalDto) {
		return approvalDao.updateApproval(approvalDto);
	}

	@Override
	public ApprovalDto selectApprovalById(String approval_id) {
		return approvalDao.selectApprovalById(approval_id);
	}

	@Override
	public int recallApproval(String approval_id) {
		return approvalDao.recallApproval(approval_id);
	}
	
	
	
	

}
