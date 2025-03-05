package com.giga.gw.dto;

import java.util.Date;
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
public class RoomDto {

	
	private String room_id,
	room_name,
	open_hours,
	close_hours,
	image_url,
	created_at,
	updated_at,
	use_yn;
	int capacity;
}
