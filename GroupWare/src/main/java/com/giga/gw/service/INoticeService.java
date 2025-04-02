package com.giga.gw.service;

import java.util.List;

import com.giga.gw.dto.NoticeDto;

public interface INoticeService {
	
	// 게시판 조회(게시판리스트)
		public List<NoticeDto> getBoardList();

}
