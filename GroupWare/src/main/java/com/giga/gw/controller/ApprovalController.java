package com.giga.gw.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.giga.gw.dto.ApprovalCategoryDto;
import com.giga.gw.dto.ApprovalDto;
import com.giga.gw.dto.ApprovalFormDto;
import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.EmployeeDaoImpl;
import com.giga.gw.repository.IApprovalCategoryDao;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IEmployeeDao;
import com.giga.gw.service.IApprovalCategoryService;
import com.giga.gw.service.IApprovalFormService;
import com.giga.gw.service.IApprovalService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

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
	private final IApprovalService approvalService;
	
	@GetMapping("/index.do")
	public String apprIndex() {
		return "approval";
	}

	@GetMapping("/tre.do")
	public String tre(Model model, HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
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
	public boolean editorSave(@RequestBody String editor) {
		int row = approvalDao.editorSave(editor);
		return row == 1 ? true : false;
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
		return approvalCategoryService.categoryCheck(yname.toUpperCase()) == 0 ? true : false;
	}

	// 카테고리 저장
	@PostMapping("/categorySave.do")
	@ResponseBody
	public boolean categorySave(@RequestBody ApprovalCategoryDto categoryDto) {
		System.out.println(categoryDto);
		categoryDto.setCategory_yname(categoryDto.getCategory_yname().toUpperCase());
		return approvalCategoryService.categoryInsert(categoryDto) == 1 ? true : false;
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

	@GetMapping("/approvalFormDetail.do")
	public String approvalFormDetail(@RequestParam String id, Model model) {
		System.out.println(id);
		ApprovalFormDto form = approvalFormService.formSelectDetail(id);
		model.addAttribute("form", form);
		return "approvalFormDetail";
	}

	// 문서양식 등록 페이지로 이동
	@GetMapping("/approvalFormCreate.do")
	public String approvalFormCarete() {
		return "approvalFormCreate";
	}
	
	// 문서양식등록
	@PostMapping("/approvalFormSave.do")
	@ResponseBody
	public boolean approvalFormSave(@RequestBody ApprovalFormDto approvalFormDto) {
		System.out.println(approvalFormDto);
		int row = approvalFormService.formInsert(approvalFormDto);
		return row == 1 ? true : false;
	}
	
	// 문서양식 tree 데이터 조회 api
	@ResponseBody
	@GetMapping("/formTree.do")
	public List<Map<String, Object>> formTree() {
		return approvalDao.formTree();
	}
	
	// 문서양식 tree view 페이지요청
	@GetMapping("/formTreeView.do")
	public String formTreeView() {
		return "formTree";
	}
	
	// 문서양식 불러오기
	@PostMapping("/selectForm.do")
	@ResponseBody
	public Map<String, Object> selectFormContent(@RequestBody String form_id) {
		System.out.println(form_id);
		return approvalFormService.formSelectById(form_id);
	}
	
	// 문서양식 수정페이지 이동
	@GetMapping("/approvalFormUpdate.do")
	public String approvalFormUpdate(@RequestParam String id, Model model, HttpSession session) {
		ApprovalFormDto dto = approvalFormService.formSelectDetail(id);
		model.addAttribute("form",dto);
		return "approvalFormUpdate";
	}
	
	// 문서양식 수정
	@PostMapping("/approvalFormUpdate.do")
	@ResponseBody
	public boolean formUpdate(@RequestBody ApprovalFormDto approvalFormDto) {
		return approvalFormService.formUpdate(approvalFormDto) == 1?true:false;
	}
	
	@GetMapping("/approvalFormDelete.do")
	@ResponseBody
	public boolean formDelete(@RequestParam String id) {
		return approvalFormService.formDelete(id) == 1 ? true : false;
	}
	
	// TODO 00102 전자결재 문서
	// 전자결재 문서 작성 페이지 이동
	@GetMapping("/approvalDocument.do")
	public String approvalDocument(HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		return "approvalDocumentCreateForm";
	}
	
	@PostMapping("/approvalDocumentSave.do")
	@ResponseBody
	public boolean approvalDocumentSave(@RequestBody ApprovalDto approvalDto, HttpSession session) {
		System.out.println(approvalDto);
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		approvalDto.setEmpno(Integer.parseInt(loginDto.getEmpno()));
		return approvalService.insertApproval(approvalDto);
	}
}
