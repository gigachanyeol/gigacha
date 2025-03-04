package com.giga.gw.service;

import java.util.Map;

public interface IApprovalLineService {
	boolean acceptApprovalLine(Map<String, Object> map);
	boolean rejectApprovalLine(Map<String, Object> map);
}
