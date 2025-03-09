package com.giga.gw.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.giga.gw.dto.ApprovalDto;
import com.giga.gw.dto.ApprovalLineDto;
import com.giga.gw.dto.FileDto;
import com.giga.gw.repository.IApprovalDao;
import com.giga.gw.repository.IApprovalLineDao;
import com.giga.gw.repository.IFileDao;
import com.giga.gw.util.FileUploadUtil;

import lombok.Builder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalServiceImpl implements IApprovalService {

	private final IApprovalDao approvalDao;
	private final IApprovalLineDao approvalLineDao;
	private final IFileDao fileDao;
	private final FileUploadUtil fileUploadUtil;

	@Override
	public List<Map<String, Object>> getOrganizationTree() {
		return approvalDao.getOrganizationTree();
	}

	@Override
	public int countApproval(String form_id) {
		return approvalDao.countApproval(form_id);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean insertApproval(ApprovalDto approvalDto, List<MultipartFile> files) { // TODO 파일
		int n = approvalDao.insertApproval(approvalDto);
		int m = 0;
		int f = 0;
		List<ApprovalLineDto> lineDtos = approvalDto.getApprovalLineDtos();
		if (lineDtos.size() != 0 && !lineDtos.isEmpty()) {
			for (ApprovalLineDto line : lineDtos) {
				line.setApproval_id(approvalDto.getApproval_id());
				System.out.println(line.getApprover_empno());
			}
			Map<String, Object> map = new HashedMap<String, Object>();
			map.put("approval_id", approvalDto.getApproval_id());
			map.put("approvalLineDtos", lineDtos);
			m = approvalLineDao.insertApprovalLine(map);
		}
		
		// 파일업로드 로직
		List<FileDto> fileDtos = new ArrayList<>();
		if(files != null && files.size() != 0 &&  !fileDtos.isEmpty()) {
			try {
				List<String> savedFileNames = fileUploadUtil.saveFiles(files);
				if (savedFileNames == null || savedFileNames.isEmpty()) return false;
				for(int i=0; i<files.size(); i++) {
					MultipartFile file = files.get(i);
					String saveFileName = savedFileNames.get(i);
					
					FileDto fileDto = FileDto
							.builder()
							.approval_id(approvalDto.getApproval_id())
							.origin_name(file.getOriginalFilename())
							.file_name(saveFileName)
							.create_emp(Integer.toString(approvalDto.getEmpno()))
							.code("FILE01")
							.build();
					fileDtos.add(fileDto);
				}
				if(!fileDtos.isEmpty()) {
					f = fileDao.insertFile(fileDtos);
				}
				
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			}
		}

		return n == 1 && m >= 1 && (fileDtos.isEmpty() || f == fileDtos.size());
	}

	@Transactional
	@Override
	public int updateApproval(ApprovalDto approvalDto , List<MultipartFile> files) { // TODO 파일
		int n = approvalDao.updateApproval(approvalDto);
		int m = 0;

		List<ApprovalLineDto> lineDtos = approvalDto.getApprovalLineDtos();
		if (lineDtos.size() != 0 && !lineDtos.isEmpty()) {
			if (approvalLineDao.countApprovalLine(approvalDto.getApproval_id()) > 0) {
				approvalLineDao.deleteApprovalLine(approvalDto.getApproval_id());
			}
			for (ApprovalLineDto line : lineDtos) {
				line.setApproval_id(approvalDto.getApproval_id());
				System.out.println(line.getApprover_empno());
			}
			Map<String, Object> map = new HashedMap<String, Object>();
			map.put("approval_id", approvalDto.getApproval_id());
			map.put("approvalLineDtos", lineDtos);
			m = approvalLineDao.insertApprovalLine(map);
			
			return n == 1 && m >= 1 ? 1 : 0;
		}

		return n == 1 ? 1 : 0;
	}

	@Override
	public ApprovalDto selectApprovalById(String approval_id) {
		return approvalDao.selectApprovalById(approval_id);
	}

	@Override
	public int recallApproval(String approval_id) {
		return approvalDao.recallApproval(approval_id);
	}

	@Override
	public List<Map<String, Object>> formTree() {
		return approvalDao.formTree();
	}

	@Override
	public boolean insertApprovalTemp(ApprovalDto approvalDto, List<MultipartFile> files) { // TODO 파일
		int n = approvalDao.insertApprovalTemp(approvalDto);
		int m = 0;
		List<ApprovalLineDto> lineDtos = approvalDto.getApprovalLineDtos();
		if (lineDtos != null) {
			if (lineDtos.size() != 0 && !lineDtos.isEmpty()) {
				for (ApprovalLineDto line : lineDtos) {
					line.setApproval_id(approvalDto.getApproval_id());
					System.out.println(line.getApprover_empno());
				}
				Map<String, Object> map = new HashedMap<String, Object>();
				map.put("approval_id", approvalDto.getApproval_id());
				map.put("approvalLineDtos", lineDtos);
				m = approvalLineDao.insertApprovalLine(map);
			}
		}
		return n == 1 ? true : false;
	}

	@Override
	public List<ApprovalDto> selectApproval(int empno) {
		return approvalDao.selectApproval(empno);
	}

	@Override
	public int approvalRequest(String approval_id) {
		if(approvalLineDao.countApprovalLine(approval_id) == 0) {
			return -1;
		}
		return approvalDao.approvalRequest(approval_id);
	}

	@Override
	public List<ApprovalDto> selectPendingApprovalDocuments(String empno) {
		return approvalDao.selectPendingApprovalDocuments(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalTemp(String empno) {
		return approvalDao.selectApprovalTemp(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalInProgress(String empno) {
		return approvalDao.selectApprovalInProgress(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalCompleted(String empno) {
		return approvalDao.selectApprovalCompleted(empno);
	}

	@Override
	public List<ApprovalDto> selectApprovalRejected(String empno) {
		return approvalDao.selectApprovalRejected(empno);
	}

	@Override
	public List<Map<String, Object>> selectApprovalMyDocuments(String empno) {
		return approvalDao.selectApprovalMyDocuments(empno);
	}

	@Override
	public List<Map<String, Object>> selectApprovalReference(String empno) {
		return approvalDao.selectApprovalReference(empno);
	}

}
