package org.ict.service;

import java.util.List;

import org.ict.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
"file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Autowired
	private BoardService service;
	
	//@Test
	public void testRegister() {
		// BoardVO를 생성하고 service의 register 메서드를 사용해주세요.
		BoardVO board = new BoardVO();
		board.setTitle("register제목");
		board.setWriter("register글쓴이");
		board.setContent("register본문");
		
		service.register(board);
	} 
	
	//@Test
	public void testGetList() {
		List<BoardVO> boards = service.getList();
		
		boards.forEach(board -> {
			log.info(board);
		});
	}
	
	//@Test
	public void testGet() {
		BoardVO board = service.get(10L);
		log.info(board);
	}
	
	//@Test
	public void testRemove() {
		service.remove(4L);
	}
	
	//@Test
	public void testModify() {
		BoardVO board = new BoardVO();
		
		board.setBno(7L);
		board.setTitle("modify제목");
		board.setContent("modify본문");
		
		service.modify(board);
	}
}
