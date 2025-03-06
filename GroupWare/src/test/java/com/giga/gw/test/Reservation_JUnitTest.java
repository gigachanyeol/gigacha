package com.giga.gw.test;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.giga.gw.dto.ReservationDto;
import com.giga.gw.repository.IReservationDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class Reservation_JUnitTest {

	@Autowired
	private IReservationDao reservationDao;
	
	//예약생성
	//@Test
	public void insertreservation_test() {
		ReservationDto dto = ReservationDto.builder().reservation_id("20").room_id("ROOM001")
										.reservation_date("2025-01-20").reservation_time("10:00-12:00").reserver("1505001")
										.member("김인사, 최지원").purpose("프로젝트 회의").build();
	}
	
	//내 예약 조회
	//@Test
	public void selectReservationByRoomId_test() {
		ReservationDto dto = reservationDao.selectReservationByRoomId("ROOM027");
		assertNotNull(dto);

	}
	
	//예약자와 참여자 조회
	//@Test
	public void selectReserverAndMember_test() {
		ReservationDto dto = reservationDao.selectReserverAndMember("23");
		assertNotNull(dto);
	}
	
	//예약삭제 (예약자 본인 예약내역만 삭제)
	@Test 
	public void delReservation_test() {
//		int dto = reservationDao.delReservation("23", "2311007");
//		assertNotNull(dto);
//        String reservation_id = "23";
//        String reserver = "2311007";
//        
//        ReservationDto dto = new ReservationDto();
//        dto.setReservation_id(reservation_id);
//        dto.setReserver(reserver);
        
        //삭제 실행
        int result = reservationDao.delReservation("23", "2311007"); 
        assertEquals(1, result);
//        //실제로 삭제되었는지 확인 (선택적)
//        ReservationDto afterDelete = reservationDao.selectReservationByRoomId(reservation_id);
//        assertNull("삭제 후 예약이 존재하지 않아야 합니다", afterDelete);
        
	}
}
