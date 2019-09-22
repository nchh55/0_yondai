package global.sesoc.tasukete.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.tasukete.dao.RequestRepository;
import global.sesoc.tasukete.dto.PageNavigator;
import global.sesoc.tasukete.dto.Request;
import global.sesoc.tasukete.dto.Suggestion;


@Controller
public class RequestController {

	@Autowired
	RequestRepository repository;
	
	//건의사항데이터받아오기
	/*@RequestMapping(value="/requestList" , method = RequestMethod.GET)
	@ResponseBody
	public List<Request> requestList(Model model){
		List<Request> requestList = repository.request_selectAll();

		return requestList;
	}*/
	
	
		// 검색, 첫화면
		@RequestMapping(value="/request", method=RequestMethod.GET)
		public String requestList(
				@RequestParam(value="searchItem",  defaultValue="userid") String searchItem, 
				@RequestParam(value="searchWord",  defaultValue="")      String searchWord, 
				@RequestParam(value="currentPage", defaultValue="1")     int currentPage,
				Model model) {
		
			// 게시글 전체 개수 조회
			int totalRecordCount = repository.getRequestCount(searchItem, searchWord);
			
			PageNavigator navi = new PageNavigator(currentPage, totalRecordCount);
			System.out.println(navi.getStartRecord());
			List<Request> list = repository.selectAll(searchItem, searchWord, navi.getStartRecord(), navi.getCountPerPage());
			
			model.addAttribute("searchItem", searchItem);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("navi", navi);
			model.addAttribute("list", list);
			
			return "request/request";
		}
		//요청목록디테일
		@RequestMapping(value="/requestDetail", method=RequestMethod.GET)
		public String requestDetail(int requestseq, Model model) {
			Request request = repository.selectOne2(requestseq);

			model.addAttribute("request",request);
			
			return "request/requestDetail";
		}
}
