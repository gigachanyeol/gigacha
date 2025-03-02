package com.giga.gw;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping("/")
	public String index() {
		return "index";
	}

	@GetMapping("/editor.do")
	public String editor() {
		return "editor";
	}
	@GetMapping("/tree.do")
	public String tree() {
		return "tree";
	}
	@GetMapping("/ckeditor.do")
	public String ckeditor() {
		return "ckEditor";
	}
}
