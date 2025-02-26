package com.giga.gw.repository;

import java.util.List;

import com.giga.gw.dto.ApprovalLineDto;

public interface IApprovalLineDao {
	int insertApprovalLine(List<ApprovalLineDto> lines);
	int insertApprovalLine(ApprovalLineDto line);
}
