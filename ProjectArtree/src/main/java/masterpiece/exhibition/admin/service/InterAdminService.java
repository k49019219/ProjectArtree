package masterpiece.exhibition.admin.service;

import java.util.HashMap;
import java.util.List;

import masterpiece.exhibition.admin.model.GalleryVO;
import masterpiece.exhibition.exhibits.model.ExhibitsVO;

public interface InterAdminService {

	// ------------------------ 트랜잭션 처리 ------------------------ //
	
	// 전시회등록
	int applyExhibition(HashMap<String, String> newExhibitMap);
	
	// 전시회 이미지 등록
	int addExhibitImage(HashMap<String, String> hashMap);

	// ----------------------------------------------------------- //
	
	// tag 가져오기
	HashMap<String, List<String>> getTags();

	// gallery 가져오기
	List<GalleryVO> getGalleries();

	// gallery location 가져오기
	List<String> getGalleryLocations();

	// gallery 검색
	List<GalleryVO> wordSearchShow(HashMap<String, String> paraMap);

	// 새로 등록할 전시회번호 채번해오기 
	int getApplyingno();

	// 전시회목록 가져오기
	List<ExhibitsVO> getExhibitionList();

	// 전시회정보 가져오기
	HashMap<String, String> getExhibitionDetail(String no);

	// 새로운 전시회목록 가져오기
	List<ExhibitsVO> getNewExhibitionList();

	// 전시 대기 -> 전시중으로 바꾸기
	int changeExhibitStatus(String exhibitionno);

	// 종료된 전시목록 조회
	List<ExhibitsVO> getAfterExhibitionList();

	// 검토할 전시회 목록 조회
	List<HashMap<String, String>> getAppliedExhibitionList();

	// 검토할 전시회 조회
	HashMap<String, String> getAppliedExhibitionDetail(String no);

	// 이미지 가져오기
	List<HashMap<String, String>> getAppliedExhibitionImage(String no);



}
