package org.ict.service;

import org.ict.domain.LoginDTO;
import org.ict.domain.UserVO;
import org.ict.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper mapper;
	
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return mapper.login(dto);
	}
	
	@Override
	public void joinMem(UserVO vo) {
		mapper.insert(vo);
	}

	@Override
	public UserVO getUserInfo(UserVO vo) {
		return mapper.getUserInfo(vo);
	}
}
