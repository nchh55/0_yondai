package global.sesoc.tasukete.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tasukete.dto.Request;

@Repository
public class MatchingRepository {

	@Autowired
	SqlSession session;
	
	public List<Request> selectAll(String request_flag, int srow, int erow){
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("request_flag", request_flag);
		map.put("srow", srow);
		map.put("erow", erow);

		List<Request> list = mapper.selectAll(map);
		
		return list;
		
	}


	public int getMatchingCount(String request_flag, int srow, int erow) {
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("request_flag", request_flag);
		map.put("srow", srow);
		map.put("erow", erow);
		
		int total = mapper.getMatchingCount(map);
		
		return total;
	}



}
