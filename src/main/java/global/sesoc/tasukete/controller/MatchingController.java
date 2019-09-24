package global.sesoc.tasukete.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.tasukete.dao.MatchingRepository;
import global.sesoc.tasukete.dto.Request;

@Controller
public class MatchingController {
	
	@Autowired
	MatchingRepository repository;

	@RequestMapping(value="/matchingMgmt" , method = RequestMethod.GET)
	public String matchingMgmt(){
		
		return "matching/matchingList";
	}
	
	
	@RequestMapping(value="/matchingList" , method = RequestMethod.GET)
	@ResponseBody
	public List<Request> matchingList(
			@RequestParam(value="request_flag", defaultValue="전체") String request_flag,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			Model model) {
		
		int countPerPage = 3;
		int srow = 1 + (currentPage-1) * countPerPage;
		int erow = currentPage * countPerPage;
		int total = repository.getMatchingCount(request_flag, srow, erow);
		
		int totalPages = total / countPerPage;
		totalPages += (total % countPerPage != 0) ? 1 : 0;
		
		List<Request> list = repository.selectAll(request_flag, srow, erow);
		
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("request_flag", request_flag);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("countPerPage", countPerPage);

		//model.addAttribute("request_flag", request.getRequest_flag());
		
		return list;
	}
	
	
/*	@RequestMapping(value="/selectList" , method = RequestMethod.GET)
	@ResponseBody
	public List<Request> selectList(String request_flag){
		List<Request> list = repository.selectFlag(request_flag);
		
		return list;
	}*/
	
	
	
}
