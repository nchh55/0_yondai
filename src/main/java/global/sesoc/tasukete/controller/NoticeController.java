package global.sesoc.tasukete.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.tasukete.dao.NoticeRepository;
import global.sesoc.tasukete.dto.Notice;

@Controller
public class NoticeController {
	
	@Autowired
	NoticeRepository repository;
	
	// 검색, 첫화면
	@RequestMapping(value="/noticeList", method=RequestMethod.GET)
	public String noticeList(
			@RequestParam(value="searchItem",  defaultValue="notice_title") String searchItem, 
			@RequestParam(value="searchWord",  defaultValue="")      String searchWord, 
			@RequestParam(value="currentPage", defaultValue="1")     int currentPage,
			Model model) {
		
		int countPerPage = 3;
		int srow = 1 + (currentPage-1) * countPerPage;   
		int erow = currentPage * countPerPage;
		int total = repository.getNoticeCount(searchItem, searchWord, srow, erow);

		int totalPages = total / countPerPage;
		totalPages += (total % countPerPage != 0) ? 1 : 0;
		
		System.out.println(totalPages);
		List<Notice> list = repository.selectAll(searchItem, searchWord, srow, erow);
		
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("countPerPage", countPerPage);
		model.addAttribute("list", list);
		
		return "notice/noticeList";
	}
	
	//공지사항 상세(조회)
	@RequestMapping(value="/noticeDetail" , method = RequestMethod.GET)
	public String noticeDetail(int noticeseq, Model model){
		Notice notice = repository.selectOne(noticeseq);
		
		model.addAttribute("Notice", notice);
	
		return "notice/noticeDetail";	
	}
	
	//공지사항 등록
	@RequestMapping(value="/noticeWrite" , method = RequestMethod.GET)
	public String noticeWrite(Model model){
		
		Date today = new Date();
		model.addAttribute("today", today);

		return "notice/noticeWrite";
	}
	
	//공지사항 등록(처리)
	@RequestMapping(value="/noticeWrite", method = RequestMethod.POST)
	public String noticeWriteProcess(Notice notice) {
		int result = repository.insert(notice);
		
		return "redirect:/noticeList";
	}
	
	
	@RequestMapping(value="/noticeDelete", method = RequestMethod.GET)
	public String noticeDelete(int noticeseq, Model model){
		int result = repository.delete(noticeseq);
		
		return "redirect:noticeList";
	}
	
	
	@RequestMapping(value="/noticeUpdate", method=RequestMethod.GET)
	public String noticeUpdate(int noticeseq, Model model) {
		Notice notice = repository.selectOne(noticeseq);
		
		return "notice/noticeUpdate";
	}
	
	@RequestMapping(value="/noticeUpdate", method=RequestMethod.POST)
	public String noticeUpdateProcess(Notice notice, Model model, RedirectAttributes rttr) {
		int result = repository.update(notice);
		model.addAttribute("noticeseq",notice.getNoticeseq());
		
		return "redirect:noticeDetail";
	}
	
	
	
	
}
