package masterpiece.exhibition.exhibits.model;

import java.util.HashMap;
import java.util.List;

public interface InterExhibitsDAO {

	List<HashMap<String, Object>> getExhList(HashMap<String, String> paraMap); // 전시회 목록 불러오기

	int getTotalCount(HashMap<String, String> paraMap); // 전시회, 갤러리 총 게시물 갯수 알아오기

	HashMap<String, String> getExhDetail(String eno); // 전시회 디테일 페이지 채우기

	List<HashMap<String, String>> getGalList(HashMap<String, String> paraMap); // 갤러리 목록 불러오기

	List<HashMap<String, String>> getGalRecomList(); // 갤러리 이번주 추천 공간

	HashMap<String, String> getGalDetail(String gno); // 갤러리 상세페이지

	List<HashMap<String, String>> getIngExhListMap(String gno); // 특정 갤러리의 전시중 전시회 목록 불러오기

	List<HashMap<String, String>> getComExhListMap(String gno); // 특정 갤러리의 전시예정 전시회 목록 불러오기

	List<HashMap<String, String>> getEndExhListMap(String gno); // 특정 갤러리의 전시종료 전시회 목록 불러오기

	int getCheckExhLike(HashMap<String, String> paraMap); // 전시회 좋아요 체크 유무 확인
 
	int getCheckGalLike(HashMap<String, String> paraMap); // 갤러리 좋아요 체크 유무 확인

	int goCheckDislikeExh(HashMap<String, String> paraMap); // 전시회 좋아요 지정 해제

	int goCheckLikeExh(HashMap<String, String> paraMap); // 전시회 좋아요 지정

	int goCheckDislikeGal(HashMap<String, String> paraMap); // 갤러리 좋아요 지정 해제

	int goCheckLikeGal(HashMap<String, String> paraMap); // 갤러리 좋아요 지정 

}
