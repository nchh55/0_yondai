package global.sesoc.tasukete.controller;

import java.util.List;

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
				System.out.println(navi.getStartRecord());
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
			public String suggestionDetail(int suggestionseq, Model model) {
				Suggestion suggestion = repository.selectOne2(suggestionseq);
				System.out.println(suggestion);
				model.addAttribute("suggestion",suggestion);
				
				return "suggestion/suggestionDetail";
			}
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
				System.out.println(suggestion.getSuggestionseq());
				
				
				int result = repository.update(suggestion);
				
				

				rttr.addAttribute("suggestionseq",suggestion.getSuggestionseq());

				return "redirect:/suggestionDetail";
			}
			

}
