package org.ict.service;

import java.util.List;

import org.ict.domain.BoardAttachVO;
import org.ict.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardAttachServiceImpl implements BoardAttachMapper {

	@Autowired
	BoardAttachMapper mapper;

	@Override
	public void insert(BoardAttachVO vo) {
		mapper.insert(vo);
	}

	@Override
	public void delete(String uuid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BoardAttachVO> findByBno(Long bno) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
