package global.sesoc.tasukete.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tasukete.dto.Request;

public interface MatchingMapper {

	public List<Request> selectAll(Map<String, Object> map);

	public int getMatchingCount(Map<String, Object> map);

	public Request selectOne(int requestseq);


	
	
}
