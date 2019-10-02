package global.sesoc.tasukete.security;

import javax.servlet.http.HttpServletRequest;
import javax.sound.midi.MidiDevice.Info;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class Denied_Handler {

   @RequestMapping(value="/denied", method=RequestMethod.GET)
   public String denied(HttpServletRequest request, RedirectAttributes rttr){
      
      String referer = request.getHeader("Referer");
      
      log.info(referer);
      try{
         if(referer.lastIndexOf("?") != -1){
            
            log.info(referer.substring(referer.indexOf("noticeseq")+10));
            
            rttr.addAttribute("noticeseq",referer.substring(referer.indexOf("noticeseq")+10));
            referer = referer.substring(0,referer.lastIndexOf("?"));
         }
      }catch (NullPointerException e) {
         return "redirect:/wrongApproach";
         
      } 
      rttr.addFlashAttribute("deniedMsg", "권한이 없습니다.");
      log.info(referer);
      return "redirect:" + referer;
   }
}