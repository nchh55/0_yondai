package global.sesoc.tasukete.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import global.sesoc.tasukete.dao.NoticeRepository;
import global.sesoc.tasukete.dao.SuggestionRepository;
import global.sesoc.tasukete.dto.Notice;
import global.sesoc.tasukete.util.PageNavigator_A;

@Controller
public class NoticeController {
	
	@Autowired
	NoticeRepository repository;
	
	//공지사항 조회(전체)
	@RequestMapping(value="/noticeList", method=RequestMethod.GET)
	public String noticeList(
			@RequestParam(value="searchItem",  defaultValue="notice_title") String searchItem, 
			@RequestParam(value="searchWord",  defaultValue="")      String searchWord, 
			@RequestParam(value="currentPage", defaultValue="1")     int currentPage,
			Model model) {
		
		int totalRecordCount = repository.getNoticeCount(searchItem, searchWord);
		
		PageNavigator_A navi = new PageNavigator_A(currentPage, totalRecordCount);
		
		int sRow = navi.getSRow();
		int eRow = navi.getERow();
		
		List<Notice> list = repository.selectAll(searchItem, searchWord, sRow, eRow);
		
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		model.addAttribute("list", list);
		
		return "notice/noticeList";
	}
	
	//공지사항 조회(상세)
	@RequestMapping(value="/noticeDetail" , method = RequestMethod.GET)
	public String noticeDetail(int noticeseq, Model model){
		
		Notice notice = repository.selectOne(noticeseq);
		
		model.addAttribute("noticeseq", notice.getNoticeseq());
		model.addAttribute("notice_title", notice.getNotice_title());
		model.addAttribute("userid", notice.getUserid());
		model.addAttribute("notice_contents", notice.getNotice_contents());
		model.addAttribute("notice_date", notice.getNotice_date());
		
		System.out.println(notice.getNotice_contents());
			
		return "notice/noticeDetail";	
	}
	
	//공지사항 등록
	@RequestMapping(value="/admin/noticeWrite" , method = RequestMethod.GET)
	public String noticeWrite(Model model){
		
		Date today = new Date();
		model.addAttribute("today", today);

		return "notice/noticeWrite";
	}
	
	//공지사항 등록(처리)
	@RequestMapping(value="/admin/noticeWrite", method = RequestMethod.POST)
	public String noticeWriteProcess(Notice notice) {
		int result = repository.insert(notice);
		
		return "redirect:/noticeList";
	}

	
	//공지사항 수정(조회)
	@RequestMapping(value="/admin/noticeUpdate", method=RequestMethod.GET)
	public String noticeUpdate(int noticeseq, Model model) {
		
		Date today = new Date();
		model.addAttribute("today", today);
		
		Notice notice = repository.selectOne(noticeseq);
				
		model.addAttribute("noticeseq", notice.getNoticeseq());
		model.addAttribute("notice_title", notice.getNotice_title());
		model.addAttribute("userid", notice.getUserid());
		model.addAttribute("notice_contents", notice.getNotice_contents());
		model.addAttribute("notice_date", notice.getNotice_date());
		
		return "notice/noticeUpdate";
	}
	
	//공지사항 수정(처리)
	@RequestMapping(value="/admin/noticeUpdate", method=RequestMethod.POST)
	public String noticeUpdateProcess(Notice notice, Model model, RedirectAttributes rttr) {
		int result = repository.update(notice);
		
		return "redirect:/noticeList";
	}
	
	//공지사항 삭제
    @RequestMapping(value="/admin/noticeDelete", method=RequestMethod.GET)
    public String suggestionDelete(int noticeseq) {

       int result = repository.delete(noticeseq);
       
       return "redirect:/noticeList";
    }
	
	
	
}
