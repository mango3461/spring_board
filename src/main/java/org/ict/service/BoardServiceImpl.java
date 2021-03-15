package org.ict.service;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// 서비스 구현체에는 인터페이스의 메서드를 구현합니다.
// 이 클래스는 bean-container에 집어넣어야 호출할 수 있습니다.
// 따라서 root-context.xml에 컴포넌트 스캔범위를 설정해주신 다음
// @Service 어노테이션을 붙여서 스캔을 마친 다음부터 사용해주세요.
@Service
public class BoardServiceImpl implements BoardService{

	// mapper쪽 메서드를 호출하려면 mapper클래스를 먼저 선언합ㄴ디ㅣㅏ.
	@Autowired
	private BoardMapper mapper;
	
	// 메서드 실행용 테스트코드를 만들어주세요.
	// src/test/java 하위에 org.ict.service 패키지를 만들고
	// BoardServiceTests 클래스파일을 만들어주세요.
	// 내부 멤버변수로 BoardService타입의 service를 선언하고
	// @Autowired로 주입한 후, 하단에 register용 코드를 작성하세요.
	@Override
	public void register(BoardVO board) {
		mapper.insert(board);
	}

	@Override
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	// return type이 boolean인 메서드는 
	// int를 리턴하는 mapper쪽 메서드의 겨로가가 1인지 체크해서
	// 참 거짓을 리턴하도록 합니다.
	@Override
	public boolean modify(BoardVO board) {
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		return mapper.getList();
	}

}
