package global.sesoc.tasukete.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import global.sesoc.tasukete.dto.Suggestion;

@Repository
public class SuggestionRepository {
	@Autowired
	SqlSession session;
		//건의사항(ajax)
		/*public List<Suggestion> suggestion_selectAll(){
			SuggestionMapper mapper = session.getMapper(SuggestionMapper.class);
			List<Suggestion> suggestionList = mapper.suggestion_selectAll(null);
			
			return suggestionList;
		}*/
		//건의사항글가져오기
		public List<Suggestion> selectAll(String searchItem, String searchWord, int startRecord, int countPerPage) {
			List<Suggestion> list;
			
			RowBounds rb = new RowBounds(startRecord, countPerPage);
			SuggestionMapper mapper = session.getMapper(SuggestionMapper.class); // reflection

			Map<String, String> map = new HashMap<>();
			map.put("searchItem", searchItem);
			map.put("searchWord", searchWord);
			
			list = mapper.selectAll(map, rb);
			
			System.out.println("조회된 데이터 개수 => " + list.size());
			return list;
		}
		public int getSuggestionCount(String searchItem, String searchWord) {
			SuggestionMapper mapper = session.getMapper(SuggestionMapper.class);
			Map<String, Object> map = new HashMap<>();
			map.put("searchItem", searchItem);
			map.put("searchWord", searchWord);
			
			int total = mapper.getSuggestionCount(map);
			
			return total;
		}
		//건의 글 올리기
		public int suggestion(Suggestion suggest) {
			SuggestionMapper mapper = session.getMapper(SuggestionMapper.class);
		
			return mapper.suggestion(suggest);
		}
		//건의디테일
		public Suggestion selectOne2(int suggestionseq) {
			SuggestionMapper mapper = session.getMapper(SuggestionMapper.class); 
			Suggestion suggestion = mapper.selectOne2(suggestionseq);
			
			return suggestion;
		}
		//건의삭제
		public int delete(int suggestionseq) {
			SuggestionMapper mapper = session.getMapper(SuggestionMapper.class);
			
			int result = mapper.delete(suggestionseq);
			return result;
		}
		//건의수정
		public int update(Suggestion suggestion) {
			SuggestionMapper mapper = session.getMapper(SuggestionMapper.class);

			int result = mapper.update(suggestion);

			return result;
		}
}
