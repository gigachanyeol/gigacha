package com.giga.gw.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IEmployeeDao;
import com.google.gson.Gson;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/approval")
@RequiredArgsConstructor
@Slf4j
public class ApprovalController {
	private final IApprovalDao approvalDao;
	private final IEmployeeDao employeeDao;
	
	@GetMapping("/index.do")
	public String apprIndex() {
		return "approval";
	}
	
	@GetMapping("/tre.do")
	public String tre() {
		return "tree";
	}
	
	@ResponseBody
	@GetMapping("/tree.do")
	public List<Map<String, Object>> tree() {
		return approvalDao.getOrganizationTree();
	}
	
	@PostMapping("/signatureSave.do")
	@ResponseBody
	public boolean signatureSave(@RequestBody Map<String, Object> map) {
		boolean isc = employeeDao.saveSignature(map);
		System.out.println(map);
		Gson gson = new Gson();
		gson.toJson(map);
		return isc;
	}
	
	@GetMapping("/signatureRead.do")
	@ResponseBody
	public List<Map<String, Object>> signatureRead() {
		List<String> empList = new ArrayList<String>();
		empList.add("2501001");
		empList.add("2501002");
		System.out.println(employeeDao.readSignature(empList));
		return employeeDao.readSignature(empList);
	}
	
	@PostMapping("/editorSave.do")
	@ResponseBody
	public boolean editorSave(@RequestBody String editor){
//		System.out.println(editor);
		int row = approvalDao.editorSave(editor);
		return row == 1?true:false;
	}
	
	@GetMapping(value = "/editorRead.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String editroRead() {
		return approvalDao.editorRead();
	}
}
