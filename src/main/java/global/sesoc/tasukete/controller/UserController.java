package global.sesoc.tasukete.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import global.sesoc.tasukete.util.PageNavigator_A;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
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
   public String login(HttpServletRequest request, Model model, HttpSession session,
                     @RequestParam(value="chk", defaultValue="0") int chk/*,
                     @RequestParam(value="error", defaultValue="0") int error*/) {
      
      log.info(request.getRequestURI());
      log.info(request.getRequestURL());
      log.info(request.getHeader("referer"));
      if(request.getHeader("Referer") == null){ //직접 입력시 잘못된 경로로 인식 
         System.out.println("@#!@#@#!@#!@#!@#!@#!@#");
         return "/security/wrongApproach"; //- 처음에 여기서 문제가 발생
      }
      
     //URI 가 로그인이면 세션에 아이디담기
      if(request.getRequestURI().equals("/login")){
//         session.setAttribute("ID", request);
      }
      
//      if(error == 1){
//         String errorMsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
//         model.addAttribute("errorMsg", errorMsg);
//      }
//      
      // 1 - 정상 로그인, 2 - 세션만료 or 중복 로그인, 0 - 비회원이 기능사용시 + 로그인 실패시
      if(chk == 1){
         back = "";
      }else if(chk == 2){
         
      }else{
         // referer이 /login도 아니고 /login?error도 아닐 때 모델 추가
         if(!(request.getHeader("referer").substring(request.getHeader("referer").indexOf("/", 10)).equals("/login") ||
              request.getHeader("referer").substring(request.getHeader("referer").indexOf("/", 10)).equals("/login?error") ||
              request.getHeader("referer").substring(request.getHeader("referer").indexOf("/", 10)).equals("/signup") ||
              request.getHeader("referer").substring(request.getHeader("referer").indexOf("/", 10)).equals("/login?chk=1") ||
              request.getHeader("referer").substring(request.getHeader("referer").indexOf("/", 10)).equals("/login?chk=2"))){  
            back = request.getHeader("Referer");
            model.addAttribute("needLogin", "로그인 후 이용하실 수 있습니다.");
            System.out.println("Referer = "+back);
         }
      }
    
      return "user/login";
   }
   
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
         
      return "redirect:login?chk=1";
   }
   
   //회원 조회(전체)
   @RequestMapping(value="/admin/userList", method=RequestMethod.GET)
   public String userList(
      @RequestParam(value="searchItem",  defaultValue="userid") String searchItem, 
      @RequestParam(value="searchWord",  defaultValue="")      String searchWord, 
      @RequestParam(value="currentPage", defaultValue="1")     int currentPage,
      Model model) {
   
      int totalRecordCount = repository.getUserCount(searchItem, searchWord);
      
      PageNavigator_A navi = new PageNavigator_A(currentPage, totalRecordCount);
         
      int sRow = navi.getSRow();
      int eRow = navi.getERow();
      
      List<Tasukete_user> list = repository.selectAll(searchItem, searchWord, sRow, eRow);
   
      List<Object> principals = sessionRegistry.getAllPrincipals();

      List<String> onlineUsers = new ArrayList<String>();

      System.out.println("list의 크기 = "+ list.size());
   
      for (Object principal: principals) {
          if (principal instanceof User) {
             ((User) principal).getUsername(); // String 타입의 접속중인 유저 이름
             for(int i = list.size()-1; i >= 0 ; i--){
                System.out.println(list.get(i).getUserid());
                
             }
   //           onlineUsers.add(((User) principal).getUsername());
          }
      }
      
//      for (Object principal: principals) {
//          if (principal instanceof User) {
//              onlineUsers.add(((User) principal).getUsername());
//          }
//      }
   
   // list는 모든 유저 -> 리스트의 모든 유저를 DB에서 정렬한 순서대로 뽑는다.
   // onlineUser는 접속중인 유저
   // list에서 onLineUser를 뒤에서 부터 뽑아서 list에 add(0,뽑은 유저)를 한다
   
   
   System.out.println(onlineUsers);

   Gson jsonlist = new Gson();
   //String userList = jsonlist.toJson(list);
   String onlineUserList = jsonlist.toJson(onlineUsers);
   
   model.addAttribute("searchItem", searchItem);
    model.addAttribute("searchWord", searchWord);
    model.addAttribute("navi", navi);
    model.addAttribute("list", list);
   //model.addAttribute("userList", userList);
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
   
      //회원 탈퇴하기(회원)
      @RequestMapping(value="/user/userDelete" , method = RequestMethod.GET)
      public String userDelete_user(String userid, HttpServletRequest request, HttpServletResponse response){
         repository.delete(userid);
         
         Cookie[] cookies = request.getCookies();
         if(cookies != null){
            for(int i = 0; i < cookies.length; i++){
               cookies[i].setMaxAge(0);
               cookies[i].setPath("/");
               response.addCookie(cookies[i]);
            }
         }
         
         return "redirect:/index";
      }
      
      //회원 탈퇴시키기 (관리자)
      @RequestMapping(value="/admin/userDelete" , method = RequestMethod.GET)
      public String userDelete_admin(String userid){
         repository.delete(userid);
      
         return "redirect:/admin/userList";
      }
   
   
         
}