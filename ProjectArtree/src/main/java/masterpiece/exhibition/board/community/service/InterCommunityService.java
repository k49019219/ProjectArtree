package masterpiece.exhibition.board.community.service;

import java.util.HashMap;
import java.util.List;

public interface InterCommunityService {

	// 목록 불러오기
	List<HashMap<String, String>> getCommunity(HashMap<String, String> searchMap);
	
	// 모든 전시회 정보를 가져와서 넘긴다 (전시회 검색용)
	List<HashMap<String, String>> getExhibit(String searchWord);

	// 새 글 추가하기
	int addCommunity(HashMap<String, String> addCommunity);
	
	// 해당 글번호의 글 정보 가져오기
	HashMap<String, String> getCommunityDetail(String no);

	// 글 수정하기 
	int modifyCommunity(HashMap<String, String> modifycommu);

	// 새 댓글 등록하기
	int addComment(HashMap<String, String> comment);	



}
