package global.sesoc.tasukete.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tasukete.dto.Request;
import global.sesoc.tasukete.dto.Request_user;
import global.sesoc.tasukete.dto.Tasukete_user;
import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class MatchingRepository {

	@Autowired
	SqlSession session;
	
/*	public List<Request> selectAll(String searchFlag, int sRow, int eRow){
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchFlag", searchFlag);
		map.put("sRow", sRow);
		map.put("eRow", eRow);

		List<Request> list = mapper.selectAll(map);
		
		return list;
		
	}


	public int getMatchingCount(String searchFlag) {
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchFlag", searchFlag);
		
		int total = mapper.getMatchingCount(map);
		
		return total;
	}
*/
	

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

	//
	public Request_user selectOne(Request_user request_user) {
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		Request_user ru = mapper.selectOne(request_user);
		
		return ru;
	}

	//
	public List<Tasukete_user> selectSupp() {
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		List<Tasukete_user> list = mapper.selectSupp(null);

		return list;
	}
	
	//
	public Tasukete_user selectUser(Tasukete_user user) {
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		Tasukete_user tu = mapper.selectUser(user);

		return tu;
	}
	
	//
	public int updateOne(Request request) {
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		
		int result = 0;
	
		if((request.getSupport_id()).equals(request.getEx_support_id())){
			// 관리자가 지원자를 변경하지 않은 경우
			System.out.println("if문 참!");
			result = mapper.updateOne(request); 
			if(result == 1){ 
				mapper.updateFlag_req(request);
				mapper.updateFlag_supp(request);
			}
			
			return result;
		}else{
			// 관리자가 지원자를 변경함
			System.out.println("if문 거짓!");
			result = mapper.updateOne(request);
			if(result == 1){
				mapper.updateFlag_req(request);
				mapper.updateFlag_supp(request);
				mapper.updateFlag_ex(request);
			} 
			
			return result;
		}
		
	}
	
	//
	public List<Tasukete_user> selectWait(Tasukete_user supporter) {
		MatchingMapper mapper = session.getMapper(MatchingMapper.class);
		List<Tasukete_user> list = mapper.selectWait(supporter);

		return list;
	}



}
