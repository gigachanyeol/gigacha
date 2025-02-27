package com.giga.gw.repository;

import java.util.Map;

import com.giga.gw.dto.ReservationDto;

public interface IReservationDao {
	
	ReservationDto reservation(Map<String, Object> map);

	
}
