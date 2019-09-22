package global.sesoc.tasukete.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tasukete.dto.Notice;

public interface NoticeMapper {
	//전체 공지글수 조회
	public int getNoticeCount(Map<String, Object> map);

	public List<Notice> selectAll(Map<String, Object> map);
	//공지사항 등록
	public int insert(Notice notice);
	//공지사항 상세(조회)
	public Notice selectOne(int noticeseq);

	public int delete(int noticeseq);

	public int update(Notice notice);


}
