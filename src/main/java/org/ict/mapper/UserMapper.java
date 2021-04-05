package org.ict.mapper;

import java.sql.Date;

import org.apache.ibatis.annotations.Param;
import org.ict.domain.LoginDTO;
import org.ict.domain.UserVO;

public interface UserMapper {

	public UserVO login(LoginDTO dto) throws Exception;
	
	public void insert(UserVO vo);
	
	public UserVO getUserInfo(String vo);
	
	public void keepLogin(@Param("uid") String uid, 
						@Param("sessionId") String sessionId, 
						@Param("next") Date next);
	
	public UserVO checkUserWithSessionKey(String value);
}
