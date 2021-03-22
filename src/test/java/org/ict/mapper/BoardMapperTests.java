package org.ict.mapper;




import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Autowired
	private BoardMapper boardMapper;
	
	//@Test
	public void testGetList() {
		List<BoardVO> boards = boardMapper.getList();
		
//		log.info(boards);
		
		boards.forEach(board -> {
			log.info(board);
		});
	}
	
	//@Test
	public void testInsert() {
		// 하기 BoardVO객체를 다음 조건으로 완성시켜주세요
		// content : "insert본문"
		// title : "insert제목"
		// writer : "insert글쓴이"
		BoardVO board = new BoardVO();
		board.setTitle("insert제목");
		board.setWriter("insert글쓴이");
		board.setContent("insert본문");
		
		boardMapper.insert(board);		
		
		// 완성시킨 객체와 .insert() 메서드를 이용해
		// 글을 DB에 집어넣어주세요.
		// 코드 작성해주세요.
	}
	
	//@Test
	public void testRead() {
		BoardVO board = boardMapper.read(6L);
		log.info(board);
	}
	
	//@Test
	public void testDelete() {
		boardMapper.delete(9L);
	}
	
	// 수정내역은 BoardVO에 담아서 보내야 합니다.
	// BoardVO를 생성해주시고 필요정보(bno, title, content)
	// 를 세팅해서 수정구문을 실행해주세요.
	//@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		
		
		board.setBno((long) 2);
		board.setTitle("update제목");
		board.setContent("update본문");
		
		int count = 
				boardMapper.update(board);
		log.info("변경된 컬럼 수 : " + count);
	}
	//@Test
	public void testListPage() {
		Criteria cri = new Criteria();
		cri.setPage(100);
		cri.setNumber(10);
		boardMapper.listPage(cri).forEach(board -> {
			log.info(board);
		});
		
	}
}
