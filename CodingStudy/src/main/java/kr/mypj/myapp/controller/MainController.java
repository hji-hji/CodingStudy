package kr.mypj.myapp.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;
import kr.mypj.myapp.service.MainService;


@Controller
public class MainController {
		
	@Autowired
	MainService mainservice;	
	
	@RequestMapping(value = "/main/main.do", method = RequestMethod.GET)
	public String main(Model model) {	
		
		System.out.println("main.do");
		
		ArrayList<CategoryVo> clist = mainservice.categorySelectAll();
		
		ArrayList<StudyareaVo> slist = mainservice.studyareaSelectAll();		
		
		model.addAttribute("clist", clist);
		
		model.addAttribute("slist", slist);		
		
		return "/main";
	}
	
	@ResponseBody
	@RequestMapping(value = "/main/mainSearch.do", produces="text/plain;charset=UTF-8")
	public String mainSearch(
			@RequestParam(value="cateNameReq", required = false, defaultValue="C/C++") String cateNameReq,
			@RequestParam(value="areaNameReq", required = false, defaultValue="±§¡÷" ) String areaNameReq,
			Model model) throws Exception {
		
	//	System.out.println("mainSearch.do");
	
	//	System.out.println("cateNameReq:"+cateNameReq);
	//	System.out.println("areaNameReq:"+areaNameReq);
		
		ArrayList<TeacherDto> telist = mainservice.teacherSelectAll(cateNameReq, areaNameReq );
		//System.out.println("telist:"+telist);
		
		//HashMap<String,Object> map = new HashMap<String,Object>();
		
		//String str = "{\"checkValue\":\"trest\"}";
		String str = "";
		String strr = null;
		int cnt  = telist.size();
		System.out.println("cnt"+cnt);
		for( int i =0; i<cnt;i++) {
			
			 strr = "";
			if (i !=cnt-1) {
				strr = ",";
			}
			str = str + "{\"areaName\":\""+telist.get(i).getAreaName()+"\",\"cateName\":\""+telist.get(i).getCateName()+"\"}"+strr;
		            
			
		}
		
		String strB = " ["+str+"]";
		//System.out.println("map"+map);
		
		
		
		
	//	JSONObject json =  new JSONObject(map);
	//	json.put("telist", telist);
 	
		System.out.println("strB"+strB);
		
		return strB; 
	}
}
