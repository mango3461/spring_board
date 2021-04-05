package org.ict.controller;

import org.ict.domain.UserVO;
import org.ict.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user/*")
public class CheckController {

	@Autowired
	private UserService service;
	
	@PostMapping(value="/check/{uid}", consumes="application/json",
			// XML, JSON을 모두 처리하려면 아래와 같이
			// produces에 MediaType을 두개 이상 넣습니다.
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<UserVO> check(@PathVariable String uid) {
		ResponseEntity<UserVO> entity = null;
		
		try {
			UserVO vo = service.getUserInfo(uid);
			entity = new ResponseEntity<>(vo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
