package com.giga.gw.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.repository.IApprovalLineDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalLineServiceImpl implements IApprovalLineService{

	private final IApprovalLineDao approvalLineDao;

	@Override
	public boolean acceptApprovalLine(Map<String, Object> map) {
		return approvalLineDao.acceptApprovalLine(map) == 1?true:false;
	}

	@Override
	public boolean rejectApprovalLine(Map<String, Object> map) {
		return approvalLineDao.rejectApprovalLine(map) == 1 ? true:false;
	}
	
}
