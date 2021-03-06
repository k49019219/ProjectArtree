package masterpiece.exhibition.member.service;

import java.util.HashMap;
import java.util.List;

import masterpiece.exhibition.member.model.MemberVO;

public interface InterMemberService {

	int joinInsert(MemberVO mvo); // 회원가입 insert
	
	boolean duplicateCheck(String email); // 사용중인 이메일 체크

	MemberVO getLoginMember(HashMap<String, String> paraMap); // 로그인 처리
	
	List<HashMap<String, String>> joinFinalInsert(HashMap<String, String> paraMap); // 회원가입 완료, 선호작품설정

	String idFind(HashMap<String, String> paraMap); // 이메일 찾기

	String findUser(HashMap<String, String> paraMap); // 비밀번호 찾기 - 입력한 name, email, hp에 맞는 사용자가 있는지 확인

	int updatePwd(HashMap<String, String> updateMap); // 임시 비밀번호로 현재 비밀번호 변경

	// 선호 장르 차트
	List<String> myfavorGenre(String idx); // 개인 선호 장르 select
	List<HashMap<String, String>> myGenreData(String genre); // 선호 장르 차트 data
	
	// word cloud
	List<String> myfavorTag(String idx);  // 개인 선호 태그 select
	
	List<HashMap<String, String>> selectWannaGo(String idx); // 하트 눌렀을 때 가고싶어요 select 

	List<HashMap<String, String>> selectGo(String idx); // 책갈피 눌렀을 때 다녀왔어요 select
	
	List<HashMap<String, String>> selectFavorAuthor(String idx); // 하트 눌렀을 때 전시회의 작가 select
	
	List<HashMap<String, String>> selectfavorGal(String idx); // 선호 전시관

	int updateFavor(HashMap<String, String> paraMap); // 마이페이지 - 작품 재설정

	int changeName(HashMap<String, String> paraMap); // 닉네임 변경

	int changePwd(HashMap<String, String> paraMap); // 비밀번호 변경

	int withdrawal(HashMap<String, String> paraMap); // 회원탈퇴

	
	// 관리자 통계
	List<String> getAreaFavorGenre(String string); // 지역마다 선호한 장르 다 가져온다.

	List<HashMap<String, String>> getGenreCnt(String genre); // 선호 장르 가져가서 카운트

	int getTotalCnt(String genre); // 지역별 선호장르 카운트 총 합





	








}
