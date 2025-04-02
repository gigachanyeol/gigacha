package com.giga.gw.repository;

import java.util.List;

import com.giga.gw.dto.NoticeDto;

public interface INoticeDao {

	// 게시판 조회(게시판리스트)
	public List<NoticeDto> getBoardList();


}
