package global.sesoc.tasukete.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.tasukete.controller.UserController;
import lombok.extern.log4j.Log4j;

@Controller
public class SessionExpired {

	@RequestMapping(value="/sessionExpired")
	public String sessionExpired(RedirectAttributes rttr, HttpSession session, HttpServletRequest request,
			@RequestParam(value="error",required=false,defaultValue="noError") String error){
		
		String chageUrl = UserController.back = request.getHeader("referer");
		
		try{
			if(chageUrl.substring(chageUrl.indexOf("login"), chageUrl.indexOf("?")).equals("login")){
				
				UserController.back = chageUrl.substring(0, chageUrl.indexOf("login"))+"index";
				System.out.println(UserController.back);
			}
		}catch(StringIndexOutOfBoundsException e){
			
		}catch(NullPointerException e){
			
		}
		
		if(error.equals("duplication")){
			
			rttr.addFlashAttribute("sessionExpired", "중복 로그인이 되었습니다. 다시 로그인해주세요.");
			return "redirect:/login?chk=2";
		}
		
		rttr.addFlashAttribute("sessionExpired", "세션이 만료되었습니다. 다시 로그인해주세요. ");
		return "redirect:/login?chk=2";
	}
} 
