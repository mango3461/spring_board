package org.ict.controller;

import javax.servlet.http.HttpSession;

import org.ict.domain.LoginDTO;
import org.ict.domain.UserVO;
import org.ict.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	private UserService service;
	
	@GetMapping("/login")
	public void loginGet(@ModelAttribute("dto") LoginDTO dto) {
		
	}
	
	@PostMapping("/loginPost")
	public void loginPost(LoginDTO dto, HttpSession session, Model model) throws Exception {
		
		UserVO vo = service.login(dto);
		
		if(vo == null) {
			return;
		}
		model.addAttribute("userVO", vo);
		
	}
	
	@GetMapping("/joinmember")
	public String joinMem() {
		
		return "/user/joinmember";
	}
	
	@PostMapping("/joinmember")
	public String joinMem(UserVO vo) {
		service.joinMem(vo);
		return "redirect:/board/list";
	}
}
