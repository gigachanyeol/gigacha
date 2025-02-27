package com.giga.gw.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.giga.gw.dto.ApprovalCategoryDto;
import com.giga.gw.dto.ApprovalFormDto;
import com.giga.gw.repository.IApprovalCategoryDao;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IEmployeeDao;
import com.giga.gw.service.IApprovalCategoryService;
import com.giga.gw.service.IApprovalFormService;
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
	private final IApprovalCategoryService approvalCategoryService;
	private final IApprovalFormService approvalFormService;
	
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
	
	
	// TODO 00100 전자결재 - 카테고리 Controller
	@GetMapping("/categoryForm.do")
	public String categoryForm() {
		return "approvalCategoryForm";
	}
	
	// 카테고리 중복체크
	@GetMapping("/categoryCheck.do")
	@ResponseBody
	public boolean categoryCheck(String yname) {
		return approvalCategoryService.categoryCheck(yname.toUpperCase()) == 0 ? true:false;
	}
	
	// 카테고리 저장
	@PostMapping("/categorySave.do")
	@ResponseBody
	public boolean categorySave(@RequestBody ApprovalCategoryDto categoryDto) {
		System.out.println(categoryDto);
		categoryDto.setCategory_yname(categoryDto.getCategory_yname().toUpperCase());
		return approvalCategoryService.categoryInsert(categoryDto) == 1 ? true:false;
	}
	
	@GetMapping("/category.do")
	public String categoryList(Model model) {
		List<ApprovalCategoryDto> categoryList = approvalCategoryService.categorySelect();
		model.addAttribute("categoryList", categoryList);
		return "approvalCategoryList";
	}
	
	// 문서양식 등록시 카테고리 선택을 위한 팝업창
	@GetMapping("/categoryPop.do")
	public String categoryPop(Model model) {
		List<ApprovalCategoryDto> categoryList = approvalCategoryService.categorySelect();
		model.addAttribute("categoryList", categoryList);
		return "categoryPop";
	}
	
	// TODO 00101 전자결재 문서양식 Controller
	// 문서양식 리스트 조회
	@GetMapping("/approvalFormList.do")
	public String approvalForm(Model model) {
		List<ApprovalFormDto> formList = approvalFormService.formSelectAll();
		model.addAttribute("formList", formList);
		return "approvalFormList";
	}
	
	@GetMapping("/approvalFormDetail/{id}.do")
	public String approvalFormDetail(@PathVariable String id, Model model) {
		System.out.println(id);
		ApprovalFormDto form = approvalFormService.formSelectDetail(id);
		model.addAttribute("form",form);
		return "approvalFormDetail";
	}
	
	// 문서양식 등록 페이지로 이동
	@GetMapping("/approvalFormCreate.do")
	public String approvalFormCarete() {
		return "approvalFormCreate";
	}
	
	@PostMapping("/approvalFormSave.do")
	@ResponseBody
	public boolean approvalFormSave(@RequestBody ApprovalFormDto approvalFormDto) {
		System.out.println(approvalFormDto);
		int row = approvalFormService.formInsert(approvalFormDto); 
		return row == 1 ? true:false;
	}
		
}
