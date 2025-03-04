package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.RoomDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class RoomDaoImpl implements IRoomDao {
	
	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.RoomDaoImpl.";

	@Override
	public int insertRoom(RoomDto roomDto) {
		return sessionTemplate.insert(NS+"insertRoom", roomDto);
		
	}

	@Override
	public List<RoomDto> selectAllRooms() {
		return sessionTemplate.selectList(NS+"selectAllRooms");
	}

	@Override
	public RoomDto selectRoomById(String roomId) {
		return sessionTemplate.selectOne(NS+"selectRoomById",roomId);
	}

	@Override
	public int updateRoom(RoomDto roomDto) {
		return sessionTemplate.update(NS+"updateRoom",roomDto);
	}


	@Override
	public int delRooms(List<String> roomId) {
		return sessionTemplate.delete(NS+"delRooms", roomId);
	}


}
