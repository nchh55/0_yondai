package global.sesoc.tasukete.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tasukete.dto.Report;
@Repository
public class ReportRepository {
	@Autowired
	SqlSession session;
	//신고하기
		public int report(Report report) {
			ReportMapper mapper = session.getMapper(ReportMapper.class);
		
			return mapper.report(report);
		}
}
