package masterpiece.exhibition.board.community.model;

import java.util.HashMap;
import java.util.List;

public interface InterCommunityDAO {
	
	// 모든 전시회 정보를 가져와서 넘긴다 (전시회 검색용)
	List<HashMap<String, String>> getAllExhibit();

}
