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
		
	//	System.out.println("main.do");
		
		ArrayList<CategoryVo> clist = mainservice.categorySelectAll();
		
		ArrayList<StudyareaVo> slist = mainservice.studyareaSelectAll();	
		
		ArrayList<TeacherDto> telist = mainservice.teacherRandomSelectAll();
		
		model.addAttribute("clist", clist);		
		model.addAttribute("slist", slist);
		model.addAttribute("telist", telist);		
		
		return "/main";
	}
	
	@ResponseBody
	@RequestMapping(value = "/main/mainSearch.do", produces="text/plain;charset=UTF-8")
	public String mainSearch(
			@RequestParam(value="cateNameReq", required = false, defaultValue="") String cateNameReq,
			@RequestParam(value="areaNameReq", required = false, defaultValue="") String areaNameReq,
			Model model) throws Exception {
		
	//	System.out.println("cateNameReq"+cateNameReq);
	//	System.out.println("areaNameReq"+areaNameReq);
		
		ArrayList<TeacherDto> telist = mainservice.teacherSelectAll(cateNameReq, areaNameReq );
		//System.out.println("telist:"+telist);
				
		String str = "";
		String strr = null;		
		int cnt  = telist.size();				
		
		for( int i =0; i<cnt;i++) {
			
			 strr = "";
			if (i !=cnt-1) {
				strr = ",";
			}
			str = str + "{"
						  + "\"areaName\":\""+telist.get(i).getAreaName()+"\","
						  + "\"teacherExp\":\""+telist.get(i).getTeacherExp()+"\","
						  + "\"teacherGender\":\""+telist.get(i).getTeacherGender()+"\","
						  + "\"teacherInfo\":\""+telist.get(i).getTeacherInfo()+"\","
						  + "\"teacherName\":\""+telist.get(i).getTeacherName()+"\","
						  + "\"teacherPay\":\""+telist.get(i).getTeacherPay()+"\","
						  + "\"filename\":\""+telist.get(i).getFilename()+"\","
						  + "\"tidx\":\""+telist.get(i).getTidx()+"\","
						  + "\"midx\":\""+telist.get(i).getMidx()+"\","
						  + "\"cateName\":\""+telist.get(i).getCateName()+"\""
						  + "}"+strr; 
		
		}
		
		
		String strB = " ["+str+"]";	 	
		System.out.println("strB"+strB);
		
		return strB; 
	}
}
