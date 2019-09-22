package global.sesoc.tasukete.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tasukete.dto.Notice;

@Repository
public class NoticeRepository {
	
	@Autowired
	SqlSession session;
	
	//공지사항 조회 (전체)
	public List<Notice> selectAll(String searchItem, String searchWord, int srow, int erow) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		map.put("srow", srow);
		map.put("erow", erow);

		List<Notice> list = mapper.selectAll(map);
		
		return list;
	}
	
	//공지사항 카운트 (전체)
	public int getNoticeCount(String searchItem, String searchWord, int srow, int erow) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		map.put("srow", srow);
		map.put("erow", erow);
		
		int total = mapper.getNoticeCount(map);
		
		return total;
	}
	
	//공지사항 등록
	public int insert(Notice notice) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		
		return mapper.insert(notice);
	}
	
	//공지사항 조회 (상세)
	public Notice selectOne(int noticeseq) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class); 
		Notice notice = mapper.selectOne(noticeseq);
			
		return notice;
	}

	public int delete(int noticeseq) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);

		return mapper.delete(noticeseq);
	}

	public int update(Notice notice) {
		NoticeMapper mapper = session.getMapper(NoticeMapper.class);
		
		return mapper.update(notice);
	}


}
