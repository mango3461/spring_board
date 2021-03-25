package org.ict.mapper;

import java.util.List;

import org.ict.domain.ReplyVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	// 테스트 대상이 ReplyMapper의 동작여부이므로 선언 및 주입
	@Autowired
	private ReplyMapper replyMapper;
	// 기능 테스트(@Test를 받은 메서드가 메인메서드처럼 실행대상)
	@Test
	public void testGetList() {
		List<ReplyVO> vo = replyMapper.getList(1111);

		vo.forEach(vos -> {
			log.info(vos);
		});
	}
	
	//@Test
	public void testInsert() {

		ReplyVO vo = new ReplyVO();
		vo.setBno(1111);
		vo.setReplyer("망고3461");
		vo.setReplytext("test댓글");
		
		replyMapper.create(vo);		
	}
	

	
	//@Test
	public void testDelete() {
		replyMapper.delete(1);
	}
	

	//@Test
	public void testUpdate() {
		ReplyVO vo = new ReplyVO();

		vo.setRno(2);
		vo.setReplyer("망고3461 수정");
		vo.setReplytext("test댓글 수정");
		
//		int count = 
				replyMapper.update(vo);
//		log.info("변경된 컬럼 수 : " + count);
	}
}
