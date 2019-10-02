package global.sesoc.tasukete.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.tasukete.dto.Suggestion;
import global.sesoc.tasukete.dto.Suggreply;
import global.sesoc.tasukete.dto.Sugrereply;



public interface SuggestionMapper {
      //건의사항(ajax)
      /*public List<Suggestion> suggestion_selectAll(Suggestion suggestion);*/
      //건의하기 글 올리기
      public int suggestion(Suggestion suggest); 
      //건의디테일
      public Suggestion selectOne2(int suggestionseq);
      //건의사항글가져오기
      public List<Suggestion> selectAll(Map<String, String> map, RowBounds rb);
      public int getSuggestionCount(Map<String, Object> map);
      //건의삭제
      public int delete(int suggestionseq);
      //건의수정
      public int update(Suggestion suggestion);
      
      //댓글입력
      public int suggreply(Suggreply suggreply); 
      //대댓글입력
      public int sugrereply(Sugrereply sugrereply); 
      //댓글목록
      public List<Suggreply> selectSuggreply(int suggreplyseq);
      //댓글삭제
      public int deleteSuggreply(int suggreplyseq);
      //대댓글목록
      public List<Sugrereply> selectSugrereply(int sugrereplyseq);

}