package org.ict.controller;

import org.ict.domain.BoardVO;
import org.ict.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

// 컨트롤러는 기본적으로 테이블 단위로 생성합니다.
// 가령 게시판 테이블 관련 컨트롤러는 아래와 같이 만들고
// 여기에 회원가입 기능이 추가되면
// MemberController가 추가되는 식입니다.
// bean-container에 추가하기 위해 어노테이션을 붙입니다.
@Controller
// 만약 하단 @Log4j에 오류가 발생하면
// pom.xml의 log4j의 scope 태그를 주석처리합니다.
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	// 컨트롤러에서 특정 주소에 접속했을때, 서비스 메서드를
	// 실행하기 위해서 객체 선언 및 자동주입을 해 주세요.
	@Autowired
	private BoardService service;
	
	// "/list" 주소를 가지는 list 메서드를 만들어주세요.
	// void 리턴을 하며, .addAttribute()를 이용해
	// list라는 이름으로 전체 글 목록을 뷰에 전달합니다.
	
	@RequestMapping("/list")
	public void list(Model model) {
		
		log.info("list");
		model.addAttribute("list", service.getList());
	}
	
	// CRUD(select,insert,delete,update)기능 연결시
	// SELECT를 제외한 기능에는 특별한 상황이 아니면
	// Post방식을 적용합니다.
	// 따라서 PostMapping 어노테이션을 써야합니다.
	@PostMapping("/register")
	public String register(BoardVO board,
							RedirectAttributes rttr) {
		// 게시물 등록 후 리스트 창으로 이동하기 위해
		// 리다이렉트 방식을 활용합니다.
		// 리다이렉트가 된 이후에 쓸 데이터를 남기기 위해
		// Model.addAttribute() 대신
		// RedirectAttributes를 활용하고 이 경우는
		// Redirect 이후에도 전달데이터가 남습니다.
		log.info("register: " + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
				
		return "redirect:/board/list";
	}
	
	// get방식으로 해당 주소 접속시 글 작성창으로 안내
	@GetMapping("/register")
	public String register() {
		return "/board/register";
	}
	
	// 특정 번호의 글을 상세페이지에서 조회할 수 있도록
	// get 기능을 구현해보겠습니다.
	// 이 메서드는 파라미터로 글 번호 bno를 입력받고
	// model.addAttribute() 기능을 이용해 특정 글 번호에
	// 해당하는 글내용을 .jsp파일로 보내줍니다.
	// 메서드의 리턴 자료형은 void입니다.
	@GetMapping("/get")
	public void get(long bno, Model model) {
		model.addAttribute("board", service.get(bno));
	}
	
	// 수정 기능을 담당하는 modify를 만들어보겠습니다.
	// 수정 창으로 접근하는 .jsp는 get방식으로 접근하지만
	// 실제 수정이 이루어지는 로직은 post방식으로 만듭니다.
	// 수정창으로 진입하는 부분과, 수정 후 디테일 페이지로
	// 넘어오는 로직을 추가로 작성해주세요.
	
	// form에서 넘어온 파라미터를 받기 위해
	// 메서드 선언부에 BoardVO를 선언하고
	// 리다이렉트시 글번호를 같이 넘기기 위해 
	// RedirectAttributes를 선언합니다.
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		service.modify(board);
		// 수정된 글 번호 정보를 저장
		rttr.addFlashAttribute("bno", board.getBno());
		return "redirect:/board/get?bno=" + board.getBno();		
	}
	
	@GetMapping("/modify")
	public String modify(Long bno, Model model) {
		model.addAttribute("board", service.get(bno));
		return "/board/modify";
	}
	
	// Remove 로직을 아래에 짜 주세요.
	// 일반테스트시는 get방식을 처리할 수 있도록,
	// 이후 테스트 코드로 테스트 할 때는 post방식을 처리할 수 있도록 합니다.
	@PostMapping("/remove")
	public String remove(Long bno, RedirectAttributes rttr) {
		
		service.remove(bno);
		// 추후 삭제 완료시 xx번 글이 삭제되었습니다라는
		// 팝업을 띄우기 위해 미리 세팅
		rttr.addFlashAttribute("bno", bno);
		
		// 삭제된 글의 디테일 페이지는 존재하지 않으므로 리스트로 이동
		return "redirect:/board/list";
	}
	
	
}
