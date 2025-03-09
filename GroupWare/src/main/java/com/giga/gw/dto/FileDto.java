package com.giga.gw.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
public class FileDto {
	String file_id,
	approval_id,
	origin_name,
	file_path,
	file_name,
	create_date,
	use_yn,
	update_date,
	create_emp,
	update_emp,
	code;
}
