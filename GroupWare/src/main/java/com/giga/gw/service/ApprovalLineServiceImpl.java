package com.giga.gw.service;

import org.springframework.stereotype.Service;

import com.giga.gw.repository.IApprovalLineDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalLineServiceImpl implements IApprovalLineService{

	private final IApprovalLineDao approvalLineDao;
	
}
