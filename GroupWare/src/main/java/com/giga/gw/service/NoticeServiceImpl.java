package com.giga.gw.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.NoticeDto;
import com.giga.gw.repository.INoticeDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class NoticeServiceImpl implements INoticeService {
	
	private final INoticeDao noticeDao;

	@Override
	public List<NoticeDto> getBoardList() {
		return noticeDao.getBoardList();
	}

}
