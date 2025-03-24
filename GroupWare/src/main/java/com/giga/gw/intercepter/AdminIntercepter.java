package com.giga.gw.intercepter;

import java.awt.desktop.PreferencesEvent;
import java.awt.desktop.PreferencesHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.dto.LoginDto;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class AdminIntercepter implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("[Intercepter] 인터셉터 시작");
		EmployeeDto loginDto = (EmployeeDto) request.getSession().getAttribute("loginDto");
		if(loginDto == null || !"A".equals(loginDto.getAuth())) {
			log.info("[AdminIntercepter] 관리자 권한 없음");
			log.info("요청 계정 정보 - 사번 : {}, 이름 : {}, 권한 : {} ", loginDto.getEmpno(), loginDto.getName(), loginDto.getAuth());
			log.info("요청 url : {}",request.getRequestURL());
			log.info("요청 ip : {}",request.getRemoteAddr());
			response.sendRedirect(request.getContextPath()+"/logout.do");
			return false;
		}
		return true;
	}

}
