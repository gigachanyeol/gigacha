package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ApprovalLineDto;

public interface IApprovalLineDao {
	int insertApprovalLine(Map<String, Object> map);
	int insertApprovalLine(ApprovalLineDto line);
}
