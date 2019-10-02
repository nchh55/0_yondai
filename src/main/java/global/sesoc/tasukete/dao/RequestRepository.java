package global.sesoc.tasukete.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tasukete.dto.Request;
import global.sesoc.tasukete.dto.Suggestion;
@Repository
public class RequestRepository {
	@Autowired
	SqlSession session;
	//요청목록
	/*public List<Request> request_selectAll(){
		RequestMapper mapper = session.getMapper(RequestMapper.class);
		List<Request> request = mapper.request_selectAll(null);
			
		return request;
		}*/
	
	//신 요청하기
	public List<Request> selectAll(String searchItem, String searchWord, int startRecord, int countPerPage) {
		List<Request> list;
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		RequestMapper mapper = session.getMapper(RequestMapper.class); // reflection

		Map<String, String> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		
		list = mapper.selectAll(map, rb);
		
		System.out.println("조회된 데이터 개수 => " + list.size());
		return list;
	}
	public int getRequestCount(String searchItem, String searchWord) {
		RequestMapper mapper = session.getMapper(RequestMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		
		int total = mapper.getRequestCount(map);
		
		return total;
	}
	//요청디테일
	public Request selectOne2(int requestseq) {
		RequestMapper mapper = session.getMapper(RequestMapper.class); 
		Request request = mapper.selectOne2(requestseq);
		
		return request;
	}
}
