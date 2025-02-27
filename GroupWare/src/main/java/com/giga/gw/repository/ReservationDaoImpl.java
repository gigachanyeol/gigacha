package com.giga.gw.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.ReservationDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReservationDaoImpl implements IReservationDao{
	
	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.ReservationDaoImpl.";

	@Override
	public ReservationDto reservation(Map<String, Object> map) {
		return sessionTemplate.selectOne(NS+"reservation", map);
	}

}
