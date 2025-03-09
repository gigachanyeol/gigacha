package com.giga.gw.repository;

import java.util.List;


import com.giga.gw.dto.FileDto;

public interface IFileDao {
	int insertFile(List<FileDto> fileDtos);
}
