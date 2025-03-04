package com.giga.gw.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class ReservationDto {

	private String reservation_id,
	room_id,
	reservation_date,
	reservation_time,
	reserver,
	member,
	purpose;
}
