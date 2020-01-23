package masterpiece.exhibition.order.service;

import java.util.HashMap;
import java.util.List;

public interface InterOrderService {

	List<HashMap<String, String>> getEx(HashMap<String, String> map); // 전시회 정보 조회

	int insertCart(HashMap<String, String> paraMap); // 장바구니 입력

	String selectCartNo(String idx); // 장바구니 번호 불러오기

	int insertCartDetail(HashMap<String, String> paraMap); // 장바구니 상세 입력

	List<HashMap<String, String>> selectCartNoList(HashMap<String, String> map); // 장바구니 번호들 조회

	List<HashMap<String, String>> cartDetailList(String string); // 상세 조회
	
	void delCartDetail(String cartNo); // 장바구니 상세 삭제
	void delCart(String cartNo); // 장바구니 삭제

	int order(HashMap<String, String> map); // 트랜잭션 장바구니 삭제, 주문완료, 주문내역

}
