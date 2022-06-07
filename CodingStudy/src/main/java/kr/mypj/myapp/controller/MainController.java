package kr.mypj.myapp.controller;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;
import kr.mypj.myapp.service.MainService;


@Controller
public class MainController {
		
	@Autowired
	MainService mainservice;	
	
	@RequestMapping(value = "/main/main.do", method = RequestMethod.GET)
	public String main(Model model) {			
		
		ArrayList<CategoryVo> clist = mainservice.categorySelectAll();
		
		ArrayList<StudyareaVo> slist = mainservice.studyareaSelectAll();		
		
		model.addAttribute("clist", clist);
		
		model.addAttribute("slist", slist);		
		
		return "/main";
	}
	
	
	
	
}
