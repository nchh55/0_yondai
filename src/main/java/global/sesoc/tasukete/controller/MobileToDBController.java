package global.sesoc.tasukete.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.tasukete.dao.UserRepository;
import global.sesoc.tasukete.dto.Tasukete_user;

import com.google.gson.Gson;


@Controller
public class MobileToDBController {
	
	@Autowired
	UserRepository repository;
	Gson gson = new Gson();
	
	@RequestMapping("/andlogin")
	@ResponseBody
	public Map<String, String> androidlogin(HttpServletRequest request){
		System.out.println("hello,andb");
		
	    Map<String, String> result = new HashMap<String, String>();
	    
	    Tasukete_user temp = new Tasukete_user(request.getParameter("id"),request.getParameter("pwd"));
	    Tasukete_user loginUser = repository.selectOne(temp);
	    System.out.println(loginUser);
	    //로그인한 유저 객체를 받음. 이것을 JSON으로 Serialize함
	    String json = gson.toJson(loginUser);
	    
	    if(loginUser != null){
	    	//result.put("id", loginUser.getUserid());
		    //result.put("phone", loginUser.getUserphone());
		    result.put("loginUser", json);
		    //////여기 부분에다가, 세션정보 저장하고, 다음페이지 시작하는 코드 작성할 것.
	    }else{
	    	System.out.println("login Failed");
	    	return null;
	    }	    
	    return result;
	}
	
	@RequestMapping("/andsignup")
	@ResponseBody
	public int androidsignup(HttpServletRequest request){
		System.out.println("hello, andb");
		
	    int result;
	   
	    Tasukete_user register_user = new Tasukete_user(
	    		request.getParameter("id"),request.getParameter("name"),
	    		request.getParameter("birth"),request.getParameter("phone"),
	    		request.getParameter("disabled"));	    
	    
	    result = repository.signup(register_user);
	    
	    if(result == 1){
	    	System.out.println("가입 성공");
	    }else{
	    	System.out.println("가입 실패");
	    }
	    
	    return result;
	}
}