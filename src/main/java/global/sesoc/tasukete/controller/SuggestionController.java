package global.sesoc.tasukete.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.tasukete.dao.SuggestionMapper;
import global.sesoc.tasukete.dao.SuggestionRepository;
import global.sesoc.tasukete.dto.PageNavigator;
import global.sesoc.tasukete.dto.Suggestion;
import global.sesoc.tasukete.dto.Suggreply;
import global.sesoc.tasukete.dto.Sugrereply;
import global.sesoc.tasukete.dto.Tasukete_user;


@Controller
public class SuggestionController {
   @Autowired
   SuggestionRepository repository;
   
         //건의사항데이터받아오기(ajax)
         /*@RequestMapping(value="/suggestionList" , method = RequestMethod.GET)
         @ResponseBody
         public List<Suggestion> suggestionList(Model model){
            List<Suggestion> suggestionList = repository.suggestion_selectAll();

            return suggestionList;
         }*/
   
         //건의사항데이터받아오기
         @RequestMapping(value="/suggestionList", method=RequestMethod.GET)
         public String suggestionList(
               @RequestParam(value="searchItem",  defaultValue="userid") String searchItem, 
               @RequestParam(value="searchWord",  defaultValue="")      String searchWord, 
               @RequestParam(value="currentPage", defaultValue="1")     int currentPage,
               Model model) {
         
            // 게시글 전체 개수 조회
            int totalRecordCount = repository.getSuggestionCount(searchItem, searchWord);
            
            PageNavigator navi = new PageNavigator(currentPage, totalRecordCount);
            
            List<Suggestion> list = repository.selectAll(searchItem, searchWord, navi.getStartRecord(), navi.getCountPerPage());
            
            model.addAttribute("searchItem", searchItem);
            model.addAttribute("searchWord", searchWord);
            model.addAttribute("navi", navi);
            model.addAttribute("list", list);
            
            return "suggestion/suggestionList";
         }
         
         //건의글올리기페이지이동
         @RequestMapping(value="/suggestionWrite", method=RequestMethod.GET)
         public String signup() {
                     
            return "suggestion/suggestionWrite";
         }
            
         //건의등록
         @RequestMapping(value="/suggest", method=RequestMethod.POST)
         public String signProcess(Suggestion suggest) {      
                     
            int result = repository.suggestion(suggest);
               
            return "redirect:suggestionList";
         }
         //건의디테일
         @RequestMapping(value="/suggestionDetail", method=RequestMethod.GET)
         public String suggestionDetail(int suggestionseq, Model model, HttpSession session) {
            
            Suggestion suggestion = repository.selectOne2(suggestionseq);
            
            List<Suggreply> suggreply = repository.selectSuggreply(suggestionseq);
            
            List<Sugrereply> sugrereply = repository.selectSugrereply(suggestionseq);
            
            System.out.println(suggreply);
            System.out.println(sugrereply);
            
            model.addAttribute("suggestion",suggestion);
            model.addAttribute("suggreply", suggreply);
            model.addAttribute("sugrereply", sugrereply);
            
            return "suggestion/suggestionDetail";
         }
         /*//건의디테일
         @RequestMapping(value="/suggestionDetail", method=RequestMethod.GET)
         public String suggreplyDetail(Model model, int suggreplyseq) {
            
            
            Suggreply suggreply = repository.selectOne3(suggreplyseq);
            
            
            model.addAttribute("suggreply",suggreply);
            
            return "suggestion/suggestionDetail";
         }*/
         //건의삭제
         @RequestMapping(value="/suggestionDelete", method=RequestMethod.GET)
         public String suggestionDelete(int suggestionseq, Model model) {

            int result = repository.delete(suggestionseq);
            
            return "redirect:suggestionList"; // 
         }
         //수정목록가져오기
         @RequestMapping(value="/suggestionUpdate", method=RequestMethod.GET)
         public String suggestionUpdate(int suggestionseq, Model model) {
            Suggestion suggestion = repository.selectOne2(suggestionseq);
            
            model.addAttribute("suggestion", suggestion);
            return "suggestion/suggestionUpdate";
         }
         //수정값넣기
         @RequestMapping(value="/suggestionUpdate", method=RequestMethod.POST)
         public String suggestionUpdateProcess(Suggestion suggestion, Model model, RedirectAttributes rttr) {
            
            int result = repository.update(suggestion);
            
            rttr.addAttribute("suggestionseq",suggestion.getSuggestionseq());

            return "redirect:/suggestionDetail";
         }
         //댓글등록
         @RequestMapping(value="/suggreply", method=RequestMethod.POST)
         public String suggreply(Suggreply suggreply) {      
            
            int result = repository.suggreply(suggreply);                        

            return "redirect:/suggestionDetail?suggestionseq="+suggreply.getSuggestionseq();
         }
         //대댓글등록
         @RequestMapping(value="/sugrereply", method=RequestMethod.POST)
         public String sugrereply(Sugrereply sugrereply) {      
            
            int result = repository.sugrereply(sugrereply);                        

            return "redirect:/suggestionDetail?suggestionseq="+sugrereply.getSuggreplyseq();
         }
         //댓글삭제 
         @RequestMapping(value="/deleteSuggreply", method=RequestMethod.POST)
         public String delete(HttpSession session,int suggreplyseq, int suggestionseq){
            // 리플라이아이디랑 세션작성자랑 같은지 확인해야됨

            if(session.getAttribute("loginId")!= null){
               String loginId = (String)session.getAttribute("loginId");
               
               List<Suggreply> rList =repository.selectSuggreply(suggestionseq);
               
               for(Suggreply r: rList) { 
                  if(r.getSuggreplyseq()==suggreplyseq){
                     if(r.getUserid().equals(loginId)){
                        repository.deleteSuggreply(suggreplyseq);
                     }
                  }             
               }
            }
            return "redirect:/suggestionDetail?suggestionseq="+suggestionseq;
         }
         

}