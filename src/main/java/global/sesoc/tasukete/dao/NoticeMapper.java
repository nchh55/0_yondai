package global.sesoc.tasukete.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tasukete.dto.Notice;

public interface NoticeMapper {
	//공지사항 조회(전체)
	public List<Notice> selectAll(Map<String, Object> map);
	
	//공지사항 카운트(전체)
	public int getNoticeCount(Map<String, Object> map);
	
	//공지사항 조회(상세)
	public Notice selectOne(int noticeseq);
	
	//공지사항 등록
	public int insert(Notice notice);
	
	//공지사항 수정
	public int update(Notice notice);
	
	//공지사항 삭제
	public int delete(int noticeseq);
	



}
