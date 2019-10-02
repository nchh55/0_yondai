package global.sesoc.tasukete.security;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class Denied_Handler {

	@RequestMapping(value="/denied", method=RequestMethod.GET)
	public String denied(HttpServletRequest request, RedirectAttributes rttr){
		System.out.println("@@@@@@@@@@@@@@");
		String referer = request.getHeader("Referer");
		
		try{
			System.out.println(referer.lastIndexOf("?"));
			if(referer.lastIndexOf("?") != -1){
				referer = referer.substring(0,referer.lastIndexOf("?"));
			}
		}catch (NullPointerException e) {
			return "redirect:/wrongApproach";
			
		} 
		rttr.addFlashAttribute("deniedMsg", "권한이 없습니다.");
		System.out.println(referer);
		return "redirect:" + referer;
	}
}
