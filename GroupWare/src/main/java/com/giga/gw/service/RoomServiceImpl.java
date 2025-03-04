package com.giga.gw.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.RoomDto;
import com.giga.gw.repository.IRoomDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoomServiceImpl implements IRoomService {

	private final IRoomDao roomDao;

	@Override
	public int insertRoom(RoomDto roomDto) {
		return roomDao.insertRoom(roomDto);
	}

	@Override
	public List<RoomDto> selectAllRooms() {
		return roomDao.selectAllRooms();
	}

	@Override
	public RoomDto selectRoomById(String roomId) {
		return roomDao.selectRoomById(roomId);
	}

	@Override
	public int updateRoom(RoomDto roomDto) {
		return roomDao.updateRoom(roomDto);
	}

	@Override
	public int delRooms(List<String> roomId) {
		return roomDao.delRooms(roomId);
	}

	

}
