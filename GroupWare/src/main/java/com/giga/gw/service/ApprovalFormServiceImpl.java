package com.giga.gw.service;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.ApprovalFormDto;
import com.giga.gw.repository.IApprovalFormDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalFormServiceImpl implements IApprovalFormService {
	private final IApprovalFormDao approvalFormDao;
	@Override
	public int formInsert(ApprovalFormDto approvalFormDto) {
		return approvalFormDao.formInsert(approvalFormDto);
	}

}
