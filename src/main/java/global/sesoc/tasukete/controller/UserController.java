package global.sesoc.tasukete.controller;


import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import global.sesoc.tasukete.dao.UserRepository;
import global.sesoc.tasukete.dto.Tasukete_user;
import lombok.Setter;


@Controller
public class UserController {

	public static String back = "";
	
   @Setter(onMethod_ = @Autowired)
   private PasswordEncoder pwencoder;
	 
   @Autowired
   UserRepository repository;
   
   @Autowired
   SessionRegistry sessionRegistry;
   
   //홈화면
   @RequestMapping(value = "/index", method = RequestMethod.GET)
   public String index() {

      return "/index";
   }
   
   //로그인
   @RequestMapping(value = "/login", method = RequestMethod.GET)
   public String login(HttpServletRequest request, Model model,
		   			   @RequestParam(value="chk", defaultValue="0") int chk) {
	   
	   if(request.getHeader("Referer") == null){
		   return "/security/wrongApproach";
	   }
	   
	   // 1 - 정상 로그인, 2 - 세션만료 or 중복 로그인, 0 - 비회원이 기능사용시
	   if(chk == 1){
		   back = "";
	   }else if(chk == 2){
		   
	   }else{
		   back = request.getHeader("Referer");
		   
		   model.addAttribute("needLogin", "로그인 후 이용하실 수 있습니다.");
	   }
	 
      return "user/login";
   }
   //로그인(처리)
//   @RequestMapping(value="/login", method=RequestMethod.POST)
//   public String loginProcess(Tasukete_user user, Model model, HttpSession session) {
//      System.out.println("여기 옴!!");
//      Tasukete_user tu = repository.selectOne(user);
//            
//      if(tu == null) {
//         String message = "아이디,비밀번호를 확인해주세요!";
//         model.addAttribute("message", message);
//
//         return "user/login";
//         
//      } else {
//         session.setAttribute("loginId", tu.getUserid());
//         session.setAttribute("loginName", tu.getUsername());
//      }
//            return "redirect:/index";      
//      }
   
   //아이디 중복확인
   @RequestMapping(value="/idCheck", method=RequestMethod.GET)
   @ResponseBody
   public String idCheck(String userid) {
      if(repository.selectId(userid) == null){
    	  return "success";
      }else {
    	  return "failure";
      }
      
   }
   
   //회원가입
   @RequestMapping(value="/signup", method=RequestMethod.GET)
   public String signup(HttpServletRequest request) {
	   
	   if(request.getHeader("Referer") == null){
		   return "/security/wrongApproach";
	   }
               
      return "user/signup";
   }
      
   //회원가입 (처리) 시큐리티
   @RequestMapping(value="/signup", method=RequestMethod.POST)
   public String signProcess(Tasukete_user user) {   
	  
      System.out.println(user.getUserpwd());
      user.setUserpwd(pwencoder.encode(user.getUserpwd()));
      int result = repository.signup(user);
      if(result == 1){
    	  repository.auth(user.getUserid());
      }
         
      return "redirect:login";
   }
   
   //로그아웃
//   @RequestMapping (value="logout", method=RequestMethod.GET)
//   public String logout(HttpSession session) {
//         
//      session.invalidate();
//         
//      return "redirect:index";
//   }
   
//TODO
	//회원 조회(전체)
	@RequestMapping(value="/admin/userList", method=RequestMethod.GET)
	public String userList(
		@RequestParam(value="searchItem",  defaultValue="username") String searchItem, 
		@RequestParam(value="searchWord",  defaultValue="")      String searchWord, 
		@RequestParam(value="currentPage", defaultValue="1")     int currentPage,
		Model model) {
	
	int countPerPage = 3;
	int srow = 1 + (currentPage-1) * countPerPage;   
	int erow = currentPage * countPerPage;
	int total = repository.getUserCount(searchItem, searchWord, srow, erow);

	int totalPages = total / countPerPage;
	totalPages += (total % countPerPage != 0) ? 1 : 0;
	
	List<Tasukete_user> list = repository.selectAll(searchItem, searchWord, srow, erow);
	
	
	
	List<Object> principals = sessionRegistry.getAllPrincipals();

	List<String> onlineUsers = new ArrayList<String>();

	for (Object principal: principals) {
	    if (principal instanceof User) {
	        onlineUsers.add(((User) principal).getUsername());
	    }
	}
	
	System.out.println(onlineUsers);

	Gson jsonlist = new Gson();
	String userList = jsonlist.toJson(list);
	String onlineUserList = jsonlist.toJson(onlineUsers);
	
	model.addAttribute("totalPages", totalPages);
	model.addAttribute("searchItem", searchItem);
	model.addAttribute("searchWord", searchWord);
	model.addAttribute("currentPage", currentPage);
	model.addAttribute("countPerPage", countPerPage);
	model.addAttribute("list", list);
	model.addAttribute("userList", userList);
	model.addAttribute("onlineUserList", onlineUserList);
		
		return "user/userList";	
	}
	
	//회원 조회(상세)
	@RequestMapping(value="/user/userDetail" , method = RequestMethod.GET)
	public String userDetail(String userid, Model model){
		
		Tasukete_user tu = repository.selectId(userid);	
		
		model.addAttribute("userid", tu.getUserid());
		model.addAttribute("username", tu.getUsername());
		model.addAttribute("userbirth", tu.getUserbirth());
		model.addAttribute("userphone", tu.getUserphone());
		model.addAttribute("disabled", tu.getDisabled());
		model.addAttribute("compliment_count", tu.getCompliment_count());
		model.addAttribute("matching_flag", tu.getMatching_flag());
		
		return "user/userDetail";
	}
	
	//회원 수정(조회)
	@RequestMapping(value="/user/userUpdate" , method = RequestMethod.GET)
	public String userUpdate(String userid, Model model){
		
		Tasukete_user tu = repository.selectId(userid);	
		
		model.addAttribute("userid", tu.getUserid());
		model.addAttribute("username", tu.getUsername());
		model.addAttribute("userbirth", tu.getUserbirth());
		model.addAttribute("userphone", tu.getUserphone());
		model.addAttribute("disabled", tu.getDisabled());
		model.addAttribute("compliment_count", tu.getCompliment_count());
		model.addAttribute("matching_flag", tu.getMatching_flag());
			
		return "user/userUpdate";
	}
	
	//회원 수정(처리)
	@RequestMapping(value="/user/userUpdate" , method = RequestMethod.POST)
	public String userUpdateProcess(Tasukete_user user, RedirectAttributes rttr){
		int result = repository.update(user);
		rttr.addAttribute("userid",user.getUserid());
		return "redirect:/user/userDetail";
	}
	
	//회원 탈퇴
	@RequestMapping(value="/user/userDelete" , method = RequestMethod.POST)
	public String  userDelete(Tasukete_user user, HttpSession session){
		if(session.getAttribute("loginId") == "admin"){
			repository.delete(user.getUserid());
			session.invalidate();
			
			return "redirect:userList";
		}else{
			repository.delete(user.getUserid());
			session.invalidate();
			
			return "redirect:/index";
		}
		
	}
	
	
			
}
