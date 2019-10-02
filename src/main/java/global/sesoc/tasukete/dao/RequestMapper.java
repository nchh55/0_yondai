package global.sesoc.tasukete.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.tasukete.dto.Request;
import global.sesoc.tasukete.dto.Suggestion;


public interface RequestMapper {
		//요청하기
		/*public List<Request> request_selectAll(Request request);*/
	
		//신 요청하기
		public List<Request> selectAll(Map<String, String> map, RowBounds rb);
		public int getRequestCount(Map<String, Object> map);
		//요청디테일
		public Request selectOne2(int requestseq);
}
