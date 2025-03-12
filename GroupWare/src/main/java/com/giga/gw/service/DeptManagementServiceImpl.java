package com.giga.gw.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.DepartmentDto;
import com.giga.gw.repository.IDeptManagementDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class DeptManagementServiceImpl implements IDeptManagementService{
	
	private final IDeptManagementDao deptManagementDao;

	@Override
	public int insertDepartment(DepartmentDto vo) {
		return deptManagementDao.insertDepartment(vo);
	}

	@Override
	public int updateDept(DepartmentDto vo) {
		return deptManagementDao.updateDept(vo);
	}

	@Override
	public int deleteDept(List<String> vo) {
		return deptManagementDao.deleteDept(vo);
	}

	@Override
	public List<DepartmentDto> getAllDept() {
		return deptManagementDao.getAllDept();
	}

	@Override
	public DepartmentDto getOneDept(String vo) {
		return deptManagementDao.getOneDept(vo);
	}

	@Override
	public List<DepartmentDto> getSearchDept(Map<String, Object> map) {
		return deptManagementDao.getSearchDept(map);
	}

	@Override
	public List<DepartmentDto> getDeletedDept() {
		return deptManagementDao.getDeletedDept();
	}

}
