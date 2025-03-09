package com.giga.gw.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUploadUtil {

	   private final String uploadPath;

	    public FileUploadUtil(ServletContext context) {
	    	// eclipse에서 tomcat 실행시에는 프로젝트root/uploads에 저장
	    	// 톰캣에서 배포시 tomcat webapps/root/uploads에 저장 
	        this.uploadPath = context.getRealPath("/uploads/");  
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs(); // 디렉터리가 없으면 생성
	        }
	    }

	    // 다중 파일 저장
	    public List<String> saveFiles(List<MultipartFile> files) throws IOException {
	        List<String> fileNames = new ArrayList<>();
	        
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                String fileName = UUID.randomUUID().toString().replace("-", "") 
	                                 + "_" + file.getOriginalFilename();
	                File saveFile = new File(uploadPath, fileName);
	                file.transferTo(saveFile); // 파일 저장
	                fileNames.add(fileName); // 저장된 파일명 추가
	            }
	        }
	        return fileNames;
	    }
}
