package global.sesoc.tasukete.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tasukete.dto.Notice;
import global.sesoc.tasukete.dto.Tasukete_user;

/**
 * 회원 관련 DAO
 */
@Repository
public class UserRepository {

	@Autowired
	SqlSession session;

	//로그인
	public Tasukete_user selectOne(Tasukete_user user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		Tasukete_user tu = mapper.selectOne(user);
		
		return tu;
	}
	//회원 가입
	public int signup(Tasukete_user user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
	
		return mapper.signup(user);
	}
	
	

	//회원 조회 (전체) 
	public List<Tasukete_user> selectAll(String searchItem, String searchWord, int srow, int erow) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		map.put("srow", srow);
		map.put("erow", erow);
		
		List<Tasukete_user> list = mapper.selectAll(map);
		
		return list;
	}
	
	
	//전체 회원수 조회
	public int getUserCount(String searchItem, String searchWord, int srow, int erow) {
		
		UserMapper mapper = session.getMapper(UserMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		map.put("srow", srow);
		map.put("erow", erow);
		
		int total = mapper.getUserCount(map);
		
		return total;
	}
	
	//ID로 회원 찾기 (회원정보 조회용)
	public Tasukete_user selectId(String userid) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		Tasukete_user tu = mapper.selectId(userid);
		return tu;
		
	}
	
	//회원정보 수정
	public int update(Tasukete_user user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = mapper.update(user);
		
		return result;
	}
	
	
	//회원 탈퇴
	public int delete(String userid) {
		UserMapper mapper = session.getMapper(UserMapper.class);

		return mapper.delete(userid);
	}

	
	
}