package global.sesoc.tasukete.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tasukete.dto.Request;
import global.sesoc.tasukete.dto.Request_user;
import global.sesoc.tasukete.dto.Tasukete_user;

public interface MatchingMapper {

	public List<Request> selectAll(Map<String, Object> map);
	
	public int getMatchingCount(Map<String, Object> map);

	public Request_user selectOne(Request_user request_user);

	public List<Tasukete_user> selectSupp(Tasukete_user tasukete_user);
	
	public List<Tasukete_user> selectWait(Tasukete_user supporter);

	public Tasukete_user selectUser(Tasukete_user user);

	public int updateOne(Request request);
	
	public int updateFlag_req(Request request);
	
	public int updateFlag_supp(Request request);
	
	public int updateFlag_ex(Request request);
	
	
}
