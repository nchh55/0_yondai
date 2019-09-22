package global.sesoc.tasukete.controller;


import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import global.sesoc.tasukete.dao.UserRepository;
import global.sesoc.tasukete.dto.Tasukete_user;


@Controller
public class UserController {

   @Autowired
   UserRepository repository;
   //홈화면
   @RequestMapping(value = "index", method = RequestMethod.GET)
   public String index(Locale locale, Model model) {

      return "index";
   }
   
   //로그인
   @RequestMapping(value = "login", method = RequestMethod.GET)
   public String login(Locale locale, Model model) {

      return "user/login";
   }
   //로그인(처리)
   @RequestMapping(value="/login", method=RequestMethod.POST)
   public String loginProcess(Tasukete_user user, Model model, HttpSession session) {
      
      Tasukete_user tu = repository.selectOne(user);
            
      if(tu == null) {
         String message = "아이디,비밀번호를 확인해주세요!";
         model.addAttribute("message", message);

         return "user/login";
         
      } else {
         session.setAttribute("loginId", tu.getUserid());
         session.setAttribute("loginName", tu.getUsername());
      }
            return "redirect:/index";      
      }
   
   //아이디 중복확인
   @RequestMapping(value="/idCheck", method=RequestMethod.GET)
   public String idCheck() {
      
      return "user/idcheck";
   }
   
   //아이디 중복확인 (처리)
   @RequestMapping(value="/idCheck", method=RequestMethod.POST)
   public String idCheckProcess(String userid, Model model) {

         model.addAttribute("message", "ok");
         model.addAttribute("userid", userid);
      
      return "user/idcheck";
   }
   
   //회원가입
   @RequestMapping(value="/signup", method=RequestMethod.GET)
   public String signup() {
               
      return "user/signup";
   }
      
   //회원가입 (처리)
   @RequestMapping(value="/signup", method=RequestMethod.POST)
   public String signProcess(Tasukete_user user) {      
               
      int result = repository.signup(user);
         
      return "redirect:login";
   }
   
   //로그아웃
   @RequestMapping (value="logout", method=RequestMethod.GET)
   public String logout(HttpSession session) {
         
      session.invalidate();
         
      return "redirect:index";
   }
   

	//회원 조회(전체)
	@RequestMapping(value="/userList", method=RequestMethod.GET)
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
	
	model.addAttribute("totalPages", totalPages);
	model.addAttribute("searchItem", searchItem);
	model.addAttribute("searchWord", searchWord);
	model.addAttribute("currentPage", currentPage);
	model.addAttribute("countPerPage", countPerPage);
	model.addAttribute("list", list);
		
		return "user/userList";	
	}
	
	//회원정보 상세(조회)
	@RequestMapping(value="/userDetail" , method = RequestMethod.GET)
	public String userDetail(String userid, Model model){
		
		Tasukete_user tu = repository.selectId(userid);	
		
		model.addAttribute("userid", tu.getUserid());
		model.addAttribute("uservnum", tu.getUservnum());
		model.addAttribute("username", tu.getUsername());
		model.addAttribute("userbirth", tu.getUserbirth());
		model.addAttribute("userphone", tu.getUserphone());
		model.addAttribute("disabled", tu.getDisabled());
		model.addAttribute("compliment_count", tu.getCompliment_count());
		model.addAttribute("matching_flag", tu.getMatching_flag());
		
		return "user/userDetail";
	}
	
	//회원정보 상세(수정)
	@RequestMapping(value="/userUpdate" , method = RequestMethod.GET)
	public String userUpdate(String userid, Model model){
		
		Tasukete_user tu = repository.selectId(userid);	
		
		model.addAttribute("userid", tu.getUserid());
		model.addAttribute("uservnum", tu.getUservnum());
		model.addAttribute("username", tu.getUsername());
		model.addAttribute("userbirth", tu.getUserbirth());
		model.addAttribute("userphone", tu.getUserphone());
		model.addAttribute("disabled", tu.getDisabled());
		model.addAttribute("compliment_count", tu.getCompliment_count());
		model.addAttribute("matching_flag", tu.getMatching_flag());
		
		return "user/userUpdate";
	}
	
	//회원정보 수정(처리)
	@RequestMapping(value="/userUpdate" , method = RequestMethod.POST)
	public String userUpdateProcess(Tasukete_user user){
		int result = repository.update(user);
		
		return "index";
	}
	
	//회원 탈퇴
	@RequestMapping(value="/userDelete" , method = RequestMethod.POST)
	public String  userDelete(Tasukete_user user, HttpSession session){
		//System.out.println(user.getUserid());
		int result = repository.delete(user.getUserid());
		session.invalidate();
		
		return "redirect:index";
	}
	
	
			
}
