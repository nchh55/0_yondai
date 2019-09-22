package global.sesoc.tasukete.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tasukete.dto.Tasukete_user;

public interface UserMapper {
		//로그인
		public Tasukete_user selectOne(Tasukete_user user);
		//회원가입
		public int signup(Tasukete_user user);
		//회원조회(전체)
		public List<Tasukete_user> selectAll(Map<String, Object> map);
		//회원탈퇴
		public int delete(String userid);
		//전체 회원수 조회
		public int getUserCount(Map<String, Object> map);
		//ID로 회원 찾기 (회원정보 조회용)
		public Tasukete_user selectId(String userid);
		//회원정보 수정
		public int update(Tasukete_user user);
	
}
