package org.ict.service;

import org.ict.domain.LoginDTO;
import org.ict.domain.UserVO;

public interface UserService {
	
	public UserVO login(LoginDTO dto) throws Exception;

	void joinMem(UserVO vo);
	

	UserVO getUserInfo(UserVO vo);
}
