package com.giga.gw.dto;

import lombok.Data;

@Data
public class ReservationDto {

	private String reservation_id,
	room_id,
	reservation_date,
	reservation_time,
	reserver,
	member,
	purpose;
}
