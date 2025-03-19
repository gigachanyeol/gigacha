package com.giga.gw.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.giga.gw.config.WebSocketHandler;
import com.giga.gw.dto.ApprovalCategoryDto;
import com.giga.gw.dto.ApprovalDto;
import com.giga.gw.dto.ApprovalFormDto;
import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.dto.FileDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IEmployeeDao;
import com.giga.gw.repository.IFileDao;
import com.giga.gw.service.IApprovalCategoryService;
import com.giga.gw.service.IApprovalFormService;
import com.giga.gw.service.IApprovalLineService;
import com.giga.gw.service.IApprovalService;
import com.giga.gw.service.IEmployeeService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/approval")
@RequiredArgsConstructor
@Slf4j
public class ApprovalController {
	private final IApprovalDao approvalDao;
	private final IEmployeeDao employeeDao;
	private final IEmployeeService employeeService;
	private final IApprovalCategoryService approvalCategoryService;
	private final IApprovalFormService approvalFormService;
	private final IApprovalService approvalService;
	private final IApprovalLineService approvalLineService;
	private final IFileDao fileDao;
	private final WebSocketHandler webSocketHandler;
	
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
	@GetMapping("/treeAjax.do")
	public List<Map<String, Object>> tree() {
		return approvalDao.getOrganizationTree();
	}

	@GetMapping("/signature.do")
	public String signature(HttpSession session, Model model) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		return "signature";
	}
	
	@PostMapping("/signatureSaveAjax.do")
	@ResponseBody
	public boolean signatureSave(@RequestBody Map<String, Object> map,HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		map.put("empno", loginDto.getEmpno());
		boolean isc = employeeService.saveSignature(map);
		return isc;
	}

	@GetMapping("/signatureReadAjax.do")
	@ResponseBody
	public List<Map<String, Object>> signatureRead(HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		return employeeDao.readSignature(loginDto.getEmpno());
	}

	// TODO 00100 전자결재 - 카테고리 Controller
	@GetMapping("/categoryForm.do")
	public String categoryForm() {
		return "approvalCategoryForm";
	}

	// 카테고리 중복체크
	@GetMapping("/categoryCheckAjax.do")
	@ResponseBody
	public boolean categoryCheck(String yname) {
		return approvalCategoryService.categoryCheck(yname.toUpperCase()) == 0 ? true : false;
	}

	// 카테고리 저장
	@PostMapping("/categorySaveAjax.do")
	@ResponseBody
	public boolean categorySave(@RequestBody ApprovalCategoryDto categoryDto) {
		System.out.println(categoryDto);
		categoryDto.setCategory_yname(categoryDto.getCategory_yname().toUpperCase());
		return approvalCategoryService.categoryInsert(categoryDto) == 1 ? true : false;
	}
	
	// 카테고리 전체 조회 리스트 이동
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
	// 문서상세 페이지 이동 
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
	@PostMapping("/approvalFormSaveAjax.do")
	@ResponseBody
	public boolean approvalFormSave(@RequestBody ApprovalFormDto approvalFormDto) {
		System.out.println(approvalFormDto);
		int row = approvalFormService.formInsert(approvalFormDto);
		return row == 1 ? true : false;
	}
	
	// 문서양식 tree 데이터 조회 api
	@ResponseBody
	@GetMapping("/formTreeAjax.do")
	public List<Map<String, Object>> formTree() {
		return approvalDao.formTree();
	}
	
	// 문서양식 tree view 페이지요청
	@GetMapping("/formTreeView.do")
	public String formTreeView() {
		return "formTree";
	}
	
	// 문서양식 불러오기
	@PostMapping("/selectFormAjax.do")
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
	@PostMapping("/approvalFormUpdateAjax.do")
	@ResponseBody
	public boolean formUpdate(@RequestBody ApprovalFormDto approvalFormDto) {
		return approvalFormService.formUpdate(approvalFormDto) == 1?true:false;
	}
	
	// 문서양식 삭제
	@GetMapping("/approvalFormDeleteAjax.do")
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
	
	@PostMapping("/approvalDocumentSaveAjax.do")
	@ResponseBody
	public boolean approvalDocumentSave(
			@ModelAttribute ApprovalDto approvalDto,
			@RequestParam(value = "files", required = false) List<MultipartFile> files, 
			HttpSession session,
			HttpServletRequest request) throws FileNotFoundException {
		System.out.println(approvalDto.getApprovalLineDtos().toString());
		System.out.println(files);
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		approvalDto.setEmpno(loginDto.getEmpno());
			
		String path;
		path = WebUtils.getRealPath(request.getSession().getServletContext(), "/storage");
		if(approvalService.insertApproval(approvalDto, files, path)) {
			if(approvalDto.getApproval_urgency().equals("Y")) {
				try {
					webSocketHandler.sendMessageToUser(approvalDto.
								getApprovalLineDtos()
								.get(0)
								.getApprover_empno(), "긴급문서 도착");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return true;
		}
		return false;
	}
	
//	유효성 체크 버전
	@PostMapping("/approvalDocumentSaveRegAjax.do")
	@ResponseBody
	public ResponseEntity<?> approvalDocumentSaveReg(
			@ModelAttribute ApprovalDto approvalDto,
			@RequestParam(value = "files", required = false) List<MultipartFile> files, 
			HttpSession session,
			HttpServletRequest request) throws FileNotFoundException {
		System.out.println(approvalDto);
		// 유효성 체크 시작
		if(approvalDto.getForm_id() == null || 
				approvalDto.getApprovalLineDtos() == null ||
				approvalDto.getApproval_deadline() == null ||
				approvalDto.getApproval_title() == null) {
			return ResponseEntity.badRequest().body("빈 값이 존재함");
		}
		
		System.out.println(approvalDto.getApprovalLineDtos().toString());
		System.out.println(files);
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		approvalDto.setEmpno(loginDto.getEmpno());
			
		String path;
		path = WebUtils.getRealPath(request.getSession().getServletContext(), "/storage");
		
		return approvalService.insertApproval(approvalDto, files, path)?ResponseEntity.ok(true):ResponseEntity.ok(false);
	}
	
	
	
	@PostMapping("/approvalDocumentSaveTempAjax.do")
	@ResponseBody
	public boolean approvalDocumentSaveTemp(@RequestBody ApprovalDto approvalDto, @RequestParam(value = "files", required = false) List<MultipartFile> files, HttpSession session) {
		System.out.println(approvalDto);
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		approvalDto.setEmpno(loginDto.getEmpno());
		return approvalService.insertApprovalTemp(approvalDto, files);
	}
	
	// 결재요청함
	@GetMapping("/approvalList.do")
	public String approvalList(Model model, HttpSession session) {
		return "approvalList";
	}
	
	@GetMapping("/approvalListAjax.do")
	@ResponseBody
	public String approvalListAjax(HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		List<ApprovalDto> approvalList = approvalDao.selectApproval(Integer.parseInt(loginDto.getEmpno()));
		Gson gson = new Gson();
		return gson.toJson(approvalList);
	}
	
	// 임시저장함
	@GetMapping("/approvalListTemp.do")
	public String approvalListTemp() {
		return "approvalListTemp";
	}
	
	@GetMapping("/approvalListTempAjax.do")
	@ResponseBody
	public String approvalListTempAjax(HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		List<ApprovalDto> approvalList = approvalDao.selectApprovalTemp(loginDto.getEmpno());
		Gson gson = new Gson();
		return gson.toJson(approvalList);
	}

	// 문서 상세
	@GetMapping("/approvalDetail.do")
	public String approvalDetail(@RequestParam String id,Model model, HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		ApprovalDto approval = approvalService.selectApprovalById(id);
		model.addAttribute("approval",approval);
		model.addAttribute("loginDto",loginDto);
		return "approvalDetail";
	}
	
	// 문서 상세 api 요청
	@GetMapping(value = "/approvalDetailAjax.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String approvalDetailAjax(@RequestParam String id) {
		System.out.println(id);
		Gson gson = new Gson();
		ApprovalDto dto = approvalService.selectApprovalById(id); 
		return gson.toJson(dto);
	}
	
	
	// 문서 수정 FORM 이동
	@GetMapping("/approvalUpdateForm.do")
	public String approvalUpdateForm(@RequestParam String id,Model model, HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		ApprovalDto approval = approvalService.selectApprovalById(id);
		model.addAttribute("approval",approval);
		model.addAttribute("loginDto",loginDto);
		return "approvalDocumentUpdateForm";
	}
	
	// 문서 수정
	@PostMapping("/approvalUpdateFormAjax.do")
	@ResponseBody
	public boolean approvalUpdate(@RequestBody ApprovalDto approvalDto,List<MultipartFile> files, HttpSession session) {
		System.out.println(approvalDto);
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		approvalDto.setUpdate_empno(loginDto.getEmpno());
		return approvalService.updateApproval(approvalDto, files) == 1 ? true : false;
	}
	
	// 문서 회수
	@PostMapping("/approvalRecallAjax.do")
	@ResponseBody
	public boolean approvalRecall(@RequestBody String approval_id, HttpSession session) {
		return approvalService.recallApproval(approval_id) == 1 ? true : false;
	}
	
	// 임시저장상태에서 결재요청
	@PostMapping("/approvalRequestAjax.do")
	@ResponseBody
	public boolean approvalRequest(@RequestBody String approval_id, HttpSession session) {
		return approvalService.approvalRequest(approval_id) == 1 ? true : false;
	}
	
	// 내가 결재할 목록으로 이동
	@GetMapping("/approvalRequestList.do")
	public String approvalRequestList(HttpSession session, Model model) {
		return "approvalRequestList";
	}
	
	@GetMapping("/approvalRequestListAjax.do")
	@ResponseBody
	public String approvalRequestListAjax(HttpSession session){
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		List<ApprovalDto> approvalList = approvalService.selectPendingApprovalDocuments(loginDto.getEmpno());
		Gson gson = new Gson();
		return gson.toJson(approvalList);
	}
	
	// 결재진행함 페이지 이동
	@GetMapping("/selectApprovalInProgress.do")
	public String selectApprovalInProgress(HttpSession session, Model model) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		return "selectApprovalInProgress";
	}
	
	@PostMapping("/selectApprovalInProgressAjax.do")
	@ResponseBody
	public String selectApprovalInProgressAjax(HttpSession session){
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		List<ApprovalDto> approvalList = approvalService.selectApprovalInProgress(loginDto.getEmpno());
		Gson gson = new Gson();
		return gson.toJson(approvalList);
	}
//	
	// 결재완료함 selectApprovalCompleted 이동
	@GetMapping("/selectApprovalCompleted.do")
	public String selectApprovalCompleted(HttpSession session, Model model) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		return "selectApprovalCompleted";
	}
	
	@PostMapping("/selectApprovalCompletedAjax.do")
	@ResponseBody
	public String selectApprovalCompletedAjax(HttpSession session){
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		List<ApprovalDto> approvalList = approvalService.selectApprovalCompleted(loginDto.getEmpno());
		Gson gson = new Gson();
		return gson.toJson(approvalList);
	}
	
	// 반려문서함
	@GetMapping("/selectApprovalRejected.do")
	public String selectApprovalRejected(HttpSession session, Model model) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		return "selectApprovalRejected";
	}
	
	@PostMapping("/selectApprovalRejectedAjax.do")
	@ResponseBody
	public String selectApprovalRejectedAjax(HttpSession session){
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		List<ApprovalDto> approvalList = approvalService.selectApprovalRejected(loginDto.getEmpno());
		Gson gson = new Gson();
		return gson.toJson(approvalList);
	}
	
	
	// 결재승인
	@PostMapping("/acceptApprovalLineAjax.do")
	@ResponseBody
	public boolean acceptApprovalLine(@RequestBody Map<String, Object> map, HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		map.put("empno", loginDto.getEmpno());
		System.out.println(map);
		return approvalLineService.acceptApprovalLine(map);
	}
	
	// 결재 반려
	@PostMapping("/rejectApprovalLineAjax.do")
	@ResponseBody
	public boolean rejectApprovalLine(@RequestBody Map<String, Object> map, HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		map.put("empno", loginDto.getEmpno());
		
		System.out.println("\n\n"+map+"\n\n");
		
		return approvalLineService.rejectApprovalLine(map);
	}
	
	// 나의 결재함
	@GetMapping("/myApproval.do")
	public String myApproval() {
		return "myApproval";
	}
	
	// 나의 결재함 api 요청주소  
	@PostMapping("/myApprovalDataAjax.do")
	@ResponseBody
	 public Map<String, Object> myDocumentsData(HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<Map<String, Object>> documents = approvalService.selectApprovalMyDocuments(loginDto.getEmpno());
        Map<String, Object> response = new HashMap<>();
        response.put("data", documents);
        return response;
    }
	
	// 참조 문서함
	@GetMapping("/selectApprovalReference.do")
	public String selectApprovalReference() {
		return "selectApprovalReference";
	}
	
	// 참조문서함 api 요청주소  selectApprovalReference
	@GetMapping("/selectApprovalReferenceAjax.do")
	@ResponseBody
	 public Map<String, Object> selectApprovalReferenceAjax(HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
        List<Map<String, Object>> documents = approvalService.selectApprovalReference(loginDto.getEmpno());
        Map<String, Object> response = new HashMap<>();
        response.put("data", documents);
        return response;
    }
	
	// 캘린더로 보낼 휴가 
	@PostMapping("/postLeaveToCalendar.json")	
	@ResponseBody
	public List<Map<String, Object>> postLeaveToCalendar(HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		
		List<Map<String, Object>> leaveList = approvalDao.postLeaveToCalendar("1505001");
		Map<String, Object> response = new HashMap<>();
		response.put("data", leaveList);
		return leaveList;
	}
	
	@PostMapping("/insertSaveLineAjax.do")
	@ResponseBody
	public String insertSaveLine(@RequestBody Map<String, Object> map, HttpSession session) {
		System.out.println(map);
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("line_name", map.get("line_name"));
		paramMap.put("line_data", map.get("line_data").toString());
		paramMap.put("empno", loginDto.getEmpno());
		approvalLineService.insertSaveLine(paramMap);
		return "true";
	}
	
	@GetMapping("/selectSaveLineAjax.do")
	@ResponseBody
	public List<Map<String, Object>> selectSaveLine(HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
		return approvalLineService.selectSaveLine(loginDto.getEmpno());
	}
	
	@GetMapping(value = "/fileListAjax.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String fileList(@RequestParam String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("approval_id", id);
		
		List<FileDto> fileList =  fileDao.selectFile(map);
		Gson gson = new GsonBuilder().create();
		return gson.toJson(fileList);
	}
	
//	파일다운로드
	@PostMapping("/downloadAjax.do")
	@ResponseBody
	public byte[] download(
			@RequestBody Map<String, Object> map,
			HttpServletResponse response) throws IOException {
		List<FileDto> dto = fileDao.selectFile(map);
		String path = dto.get(0).getFile_path();
		String saveFileName = dto.get(0).getFile_name();
		String originFileName = dto.get(0).getOrigin_name();
		File file = new File(path+"/"+saveFileName);
		String outputFileName = new String(originFileName.getBytes(), "8859_1");
		String encodedFileName = URLEncoder.encode(originFileName, "UTF-8").replaceAll("\\+", "%20");
		byte[] bytes = FileCopyUtils.copyToByteArray(file);
		
		response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);
		response.setContentLength(bytes.length);
		response.setContentType("application/octet-stream"); // meword로 정송 application/msword
		
		return bytes;
	}
}
