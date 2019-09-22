package global.sesoc.tasukete.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.tasukete.dao.ReportRepository;
import global.sesoc.tasukete.dto.Report;

@Controller
public class ReportController {
	@Autowired
	ReportRepository repository;
	
			//신고하기
			@RequestMapping(value="/report", method=RequestMethod.POST)
			public String report(Report report) {		
							
				int result = repository.report(report);
					
				return "index";
			}

} 
