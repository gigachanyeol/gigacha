package com.giga.gw.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.FileDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class FileDaoImpl implements IFileDao {
	private SqlSessionTemplate sql;
	private final String NS = "com.giga.gw.repository.FileDaoImpl";
	
	@Override
	public int insertFile(List<FileDto> fileDtos) {
		return sql.insert(NS+"insertFile");
	}

}
