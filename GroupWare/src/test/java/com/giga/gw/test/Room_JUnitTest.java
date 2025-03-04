package com.giga.gw.test;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.RoomDto;
import com.giga.gw.repository.IRoomDao;

import lombok.Builder;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class Room_JUnitTest {
	
	@Autowired
	private IRoomDao roomDao;

	//회의실 등록
	//@Test
	public void insertRoom_test() {
		RoomDto dto = RoomDto.builder()
							 .room_id("ROOM022")
							 .room_name("회의실 D")
							 .capacity(7)
							 .open_hours("09:00")
							 .close_hours("18:00")
							 .created_at("2025-03-03")
							 .updated_at("2025-03-03")
							 .use_yn("Y")
							 .image_url("/images/roomD.png")
							 .build();		
	}
	//회의실 전체 조회
	//@Test
	public void selectAllRooms_test() {
		List<RoomDto> lists = roomDao.selectAllRooms();
		assertNotEquals(0,lists.size());
	}
	
	//등록한(특정) 회의실 조회
	//@Test
	public void selectRoomById_test() {
		RoomDto dto = roomDao.selectRoomById("ROOM023");
		assertNotNull(dto);
	}
	
	//회의실 정보 수정
	//@Test
	public void updateRoom_test() {
		RoomDto dto = roomDao.selectRoomById("ROOM023");
		System.out.println(dto);
		dto.setRoom_name("대회의실");
		dto.setCapacity(15);
		dto.setUpdated_at("2025-03-04");
		
		assertNotEquals(0, roomDao.updateRoom(dto));			
	}
	
	//회의실 정보 삭제
	//@Test
//	public void delRoom_test() {
//		String room_id = "ROOM023";
//		assertNotEquals(0, roomDao.delRooms(room_id));
//	}
	
	

}
