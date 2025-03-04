package com.giga.gw.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giga.gw.dto.ApprovalDto;
import com.giga.gw.dto.ApprovalLineDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IApprovalLineDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalServiceImpl implements IApprovalService {

	private final IApprovalDao approvalDao;
	private final IApprovalLineDao approvalLineDao;

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

	@Transactional
	@Override
	public boolean insertApproval(ApprovalDto approvalDto) {
		int n = approvalDao.insertApproval(approvalDto);
		int m = 0;
		List<ApprovalLineDto> lineDtos = approvalDto.getApprovalLineDtos();
		if (lineDtos.size() != 0 && !lineDtos.isEmpty()) {
			for (ApprovalLineDto line : lineDtos) {
				line.setApproval_id(approvalDto.getApproval_id());
				System.out.println(line.getApprover_empno());
			}
			Map<String, Object> map = new HashedMap<String, Object>();
			map.put("approval_id", approvalDto.getApproval_id());
			map.put("approvalLineDtos", lineDtos);
			m = approvalLineDao.insertApprovalLine(map);
		}
		return n == 1 && m >= 1 ? true : false;
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

	@Override
	public List<Map<String, Object>> formTree() {
		return approvalDao.formTree();
	}

	@Override
	public boolean insertApprovalTemp(ApprovalDto approvalDto) {
		int n = approvalDao.insertApprovalTemp(approvalDto);
		int m = 0;
		List<ApprovalLineDto> lineDtos = approvalDto.getApprovalLineDtos();
		if(lineDtos != null) {
			if (lineDtos.size() != 0 && !lineDtos.isEmpty()) {
				for (ApprovalLineDto line : lineDtos) {
					line.setApproval_id(approvalDto.getApproval_id());
					System.out.println(line.getApprover_empno());
				}
				Map<String, Object> map = new HashedMap<String, Object>();
				map.put("approval_id", approvalDto.getApproval_id());
				map.put("approvalLineDtos", lineDtos);
				m = approvalLineDao.insertApprovalLine(map);
			}
		}
		return n == 1 ? true : false;
	}

	@Override
	public List<ApprovalDto> selectApproval(int empno) {
		return approvalDao.selectApproval(empno);
	}

	@Override
	public int approvalRequest(String approval_id) {
		return approvalDao.approvalRequest(approval_id);
	}

	@Override
	public List<ApprovalDto> selectPendingApprovalDocuments(String empno) {
		return approvalDao.selectPendingApprovalDocuments(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalTemp(String empno) {
		return approvalDao.selectApprovalTemp(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalInProgress(String empno) {
		return approvalDao.selectApprovalInProgress(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalCompleted(String empno) {
		return approvalDao.selectApprovalCompleted(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalRejected(String empno) {
		return approvalDao.selectApprovalRejected(empno);
	}
	
}
