package global.sesoc.tasukete.controller;

import java.util.Collections;
import java.util.List;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.tasukete.dao.MatchingRepository;
import global.sesoc.tasukete.dto.Request;
import global.sesoc.tasukete.dto.Request_user;
import global.sesoc.tasukete.dto.Tasukete_user;
import global.sesoc.tasukete.util.PageNavigator;
import global.sesoc.tasukete.util.DistanceCalculator;


@Controller
public class MatchingController {
	
	// 요청 테이블(요청상태)
	public static final String request_flag1 = "normal"; 
	public static final String request_flag2 = "uncompleted";
	public static final String request_flag3 = "completed";

	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");

	@Autowired
	MatchingRepository repository;

	@RequestMapping(value="/admin/matchingMgmt" , method = RequestMethod.GET)
	public String matchingMgmt(){
		
		return "matching/matchingList";
	}
	


	@RequestMapping(value="/admin/matchingList" , method = RequestMethod.GET)
	@ResponseBody
	public List<Request> matchingList(
			@RequestParam(value="request_flag", defaultValue="all") String request_flag,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			Model model) {
		
		System.out.println(request_flag);
		
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

	
	
/*	@RequestMapping(value="/admin/matchingList" , method = RequestMethod.GET)
	@ResponseBody
	public List<Request> matchingList(String searchDate, String searchItem,
			@RequestParam(value="searchWord", defaultValue="") String searchWord,
			@RequestParam(value="searchFlag", defaultValue="all") String searchFlag,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			Model model) {
		
		int totalRecordCount = repository.getMatchingCount(searchFlag);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount);
		
		int sRow = navi.getSRow();
		int eRow = navi.getERow();
		
		List<Request> list = repository.selectAll(searchFlag, sRow, eRow);
		
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("request_flag", searchFlag);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("countPerPage", countPerPage);

		//model.addAttribute("request_flag", request.getRequest_flag());
		
		return list;
	}*/
	
	
	@RequestMapping(value="/admin/matchingDetail" , method = RequestMethod.GET)
	public String matchingDetail(Request_user request_user, Model model){
		Request_user request = repository.selectOne(request_user);
		Request_user support = repository.selectOne(request);
		
		model.addAttribute("request", request);
		model.addAttribute("support", support);
		
		return "matching/matchingDetail";
	}
	
	
	@RequestMapping(value="/admin/matchingUpdate" , method = RequestMethod.GET)
	public String matchingUpdate(Request_user request_user, Model model){
		Request_user request = repository.selectOne(request_user);
		Request_user support = repository.selectOne(request);
		
		model.addAttribute("request", request);
		model.addAttribute("support", support);
		
		return "matching/matchingUpdate";
	}
	
	@RequestMapping(value="/admin/userSearch" , method = RequestMethod.GET)
	@ResponseBody
	public Tasukete_user userSearch(Tasukete_user user){
		Tasukete_user tu = repository.selectUser(user);
		
		return tu;
	}
	
	@RequestMapping(value="/admin/matchingUpdate" , method = RequestMethod.POST)
	public String matchingUpdateProcess(Request request, RedirectAttributes rttr){
		repository.updateOne(request);
		rttr.addAttribute("requestseq", request.getRequestseq());
		
		return "redirect:/admin/matchingDetail";
	}
	
	@RequestMapping(value="/admin/waitSearch" , method = RequestMethod.GET)
	@ResponseBody
	public List<Tasukete_user> waitSearch(Tasukete_user supporter){
		List<Tasukete_user> waitList = repository.selectWait(supporter);
		System.out.println(waitList.toString());
		
		DistanceCalculator calc = new DistanceCalculator();
		
		for(int i=0; i < waitList.size(); i++){
			double rlat = supporter.getUser_x();		
			double rlng = supporter.getUser_y();
			double slat = waitList.get(i).getUser_x();
			double slng = waitList.get(i).getUser_y();
			
			String unit = "Meter";
			double distance = calc.DistanceCalc(rlat, rlng, slat, slng, unit);
			waitList.get(i).setInter_distance(distance); 
		}
		
		Collections.sort(waitList);
		
		return waitList;
	}
		
	
}
