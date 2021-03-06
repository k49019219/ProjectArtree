package masterpiece.exhibition.order.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import masterpiece.exhibition.common.AES256;
import masterpiece.exhibition.common.MyUtil;
import masterpiece.exhibition.member.model.MemberVO;
import masterpiece.exhibition.order.service.InterOrderService;

@Controller
public class OrderController {

	@Autowired
	private InterOrderService service;
	
	private AES256 aes;
	
	@RequestMapping(value = "/ticketsbin.at")
	public String ticketsbin(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		String goBackURL = MyUtil.getCurrentURL(request);
		session.setAttribute("goBackURL",goBackURL);		
		String eno = request.getParameter("eno");
		
		if (eno != null) {
			session.setAttribute("eno", eno);
		}		
		
		HashMap<String, String> map = new HashMap<String, String>();		
		
		String exno = (String) session.getAttribute("eno");		
		map.put("no", exno);
		
		List<HashMap<String, String>> exList = service.getEx(map);

		// 키값 꺼내서 리퀘스트셋
		Set key = exList.get(0).keySet();
		Iterator iterator = key.iterator();
		for (iterator = key.iterator(); iterator.hasNext();) {
			String keyName = (String) iterator.next();
			request.setAttribute(keyName, exList.get(0).get(keyName));
		}

		request.setAttribute("exList", exList);

		int price = Integer.parseInt(exList.get(0).get("price"));		
		int price20 = (int) (price * 0.8);
		int price30 = (int) (price * 0.7);
		int price50 = (int) (price * 0.5);

		request.setAttribute("price", price);
		request.setAttribute("price20", price20);
		request.setAttribute("price30", price30);
		request.setAttribute("price50", price50);		
		
		String[] qt = null;
		String bin = "";
		qt = (String[]) session.getAttribute("qt");
		if (qt != null) {
			for (int i = 0; i < qt.length; i++) {
				if (i == 0) {
					bin += qt[i];
				} else {
					bin += "," + qt[i];
				}
			}
			request.setAttribute("bin", bin);
		}

		return "order/ticketsbin.tiles";
	}

	@RequestMapping(value = "/paymentbin.at")
	public String paymentbin(HttpServletRequest request) {
		return "order/paymentbin.tiles";
	}

	@RequestMapping(value = "/insertCart.at")
	public ModelAndView insertCart(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();		
		HashMap<String, String> map = new HashMap<String, String>();
		String dateBin = request.getParameter("dateBin");
		String exname = request.getParameter("exhibitionname");

		map.put("date", dateBin);
		map.put("exname", exname);
		
		// 장바구니 입력		
		MemberVO mvo = (MemberVO)session.getAttribute("loginuser");		
		String idx = mvo.getIdx();	
		map.put("idx", idx);		
		
		String no = (String) session.getAttribute("eno");		
		map.put("no", no);
		if (dateBin != null)
			service.insertCart(map);

		String cartNo = service.selectCartNo(idx);
		map.put("cartNo", cartNo);

		String[] qt = request.getParameterValues("qt");
		session.setAttribute("qt", qt);
		String[] type = request.getParameterValues("type");
		String[] price = request.getParameterValues("price");

		if (dateBin != null) {
			if (qt != null && type != null && price != null) {
				for (int i = 0; i < qt.length; i++) {
					if (Integer.parseInt(qt[i]) == 0) {
						continue;
					} else {
						// 장바구니 상세 입력 수량,타입
						map.put("qt", qt[i]);
						map.put("type", type[i]);
						map.put("price", price[i]);
						if (dateBin != null)
							service.insertCartDetail(map);
					}
				}
			}
		}				
		String msg = null;
		String loc = request.getContextPath() + "/paymentbin.at";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		
		/*else { 
			String msg = "로그인을 해주세요.";
			String loc = request.getContextPath() + "/mainartree.at";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}			*/
		return mav;
	}

	@RequestMapping(value = "/paymentGatebin.at")
	public String paymentGatebin(HttpServletRequest request, HashMap<String,String> map) {
		HttpSession session = request.getSession();		
		MemberVO mvo = (MemberVO)session.getAttribute("loginuser");
		
		String email = mvo.getEmail();
		String name = mvo.getName();
		request.setAttribute("email", email);
		request.setAttribute("name", name);		
		
		String idx = mvo.getIdx();	
		map.put("idx", idx);
		List<HashMap<String,String>> mapList = service.selectCartNoList(map);
		
		String exname = mapList.get(0).get("exname");
		int a = mapList.size()-1;
		
		if(mapList.size()==1) {			
			request.setAttribute("exhibitionname", exname);
		}		
		
		else {
			request.setAttribute("exhibitionname", exname+" 외 "+a+"건");
		}
		
		return "order/paymentGateway";
	}

	@RequestMapping(value = "/orderEnd.at") // 여기서 트랜잭션
	public String orderEnd(HttpServletRequest request, HashMap<String, String> map) {
		DecimalFormat dec = new DecimalFormat("#,###");
				
		String html = "";
		HttpSession session = request.getSession();
		int cancelA = 0;
		int cancelB = 1;
		
		MemberVO mvo = (MemberVO)session.getAttribute("loginuser");
		if ( mvo != null ) {
		
		String idx = mvo.getIdx();
		map.put("idx", idx);
		
		String Subtotal = request.getParameter("Subtotal");
		String Discount = request.getParameter("Discount");
		String orderpri = request.getParameter("orderpri");
		String reserNo = "";
		
		if(Subtotal != null) {
		map.put("Subtotal", Subtotal);
		map.put("Discount", Discount);
		map.put("orderpri", orderpri);			
		
		service.order(map); // 예매 입력, 카트 삭제
		
		reserNo = service.selectReserNo(map);
		map.put("reserNo", reserNo);		
		}
		
		if (request.getParameter("reserNo") != null) {
		reserNo = request.getParameter("reserNo");
		map.put("reserNo", reserNo);
		}
		
		request.setAttribute("reserNo", reserNo);
		
		int cancelC = 1;
		cancelC = Integer.parseInt(service.reserStat(reserNo));
		request.setAttribute("cancelC", cancelC);
		
		List<HashMap<String,String>> reserList = service.selectReser(map);
		for(int a=0; a<reserList.size(); a++) {
			Set key = reserList.get(a).keySet();
			Iterator iterator = key.iterator();
			for (iterator = key.iterator(); iterator.hasNext();) {
				String keyName = (String) iterator.next();
				request.setAttribute(keyName, reserList.get(a).get(keyName));	
				map.put("RESERNO", reserList.get(a).get("RESERNO"));
			}	
			
			html += "<div class=\"slideshow-container\">";
			html += "";
			
			List<HashMap<String,String>> reserDetailList = service.selectReserDetail(map);
			for(int b=0; b<reserDetailList.size(); b++) {
				int start = b+1;
				int end = reserDetailList.size();
				Set key2 = reserDetailList.get(b).keySet();
				Iterator iterator2 = key2.iterator();
				for (iterator2 = key2.iterator(); iterator2.hasNext();) {
					String keyName = (String) iterator2.next();
					request.setAttribute(keyName, reserDetailList.get(b).get(keyName));	
					map.put("RESERDETAILNO", reserDetailList.get(b).get("RESERDETAILNO"));
				}	
				
				html += "<div class=\"mySlides\">";				
				html += "<div style=\"font-weight:bold; display:inline-block; margin-bottom: 1%; font-size: 22px; padding-top: 5%;\">주문 상품 정보</div>";
				html += "<div class=\"numbertext\">"+start+"/"+end+"</div>";
				html += "<table class=\"table table-hover\">";				
				html += "<tr><th>이미지</th><td><img style=\"border-radius: 15px; width: 50%; height: 400px;\" src=\""+reserDetailList.get(b).get("MAINIMG")+"\"></td></tr>";
				html += "<tr><th>상품정보</th><td>"+reserDetailList.get(b).get("EXNAME")+"</td></tr>";
				html += "<tr><th>관람일자</th><td>"+reserDetailList.get(b).get("DDAY")+"</td></tr>";
				html += "<tr><th>수량</th><td></td></tr>";
				html += "";
				
				// 관람일자 전일까지만 취소가 가능 
				Calendar cal = new GregorianCalendar(Locale.KOREA);
				cal.setTime(new Date());
				cal.add(Calendar.DAY_OF_YEAR, 0); // 하루를 더한다. 					
				SimpleDateFormat fm = new SimpleDateFormat("yyyy/MM/dd");
				String currentDate = fm.format(cal.getTime());				
				currentDate = currentDate.replace("/", "");
				int icurrentDate = Integer.parseInt(currentDate);
				
				String dday = reserDetailList.get(b).get("DDAY");
				dday = dday.replace("-", "");							
				int idday = Integer.parseInt(dday);										
									
				int cancel = idday - icurrentDate;
				if (cancel > 2) {
					cancelA = 1;
				}
				else {
					cancelA = 0;
				}
				cancelB *= cancelA;
				
				// 200204 (관람일) - 200203 (현재일) = 음수, 0 or 1 취소 불가  2이상일때 취소가능 
				 
				
				List<HashMap<String,String>> reserExList = service.selectReserEx(map);
				for(int c=0; c<reserExList.size(); c++) {
					String purtype = reserExList.get(c).get("PURTYPE");
					String qt = reserExList.get(c).get("QT");
					int price = Integer.parseInt(reserExList.get(c).get("PRICE"));
					html += "<tr><td>"+purtype+"</td><td>"+qt+"&nbsp;Item(s)<span style=\"margin-left:25%;\">&#8361;"+dec.format(price)+"</span></td></tr>";										
				}
								
				html += "</table>";				
				html += "</div>";
				html += "";
				
			}
			
			html += "<a class=\"prev\" onclick=\"plusSlides(-1)\">&#10094;</a>";
			html += "<a class=\"next\" onclick=\"plusSlides(1)\">&#10095;</a>";
			html += "</div>";
			html += "";
			
		}		
		request.setAttribute("html", html);
		request.setAttribute("cancelB", cancelB);
		
		
		return "order/orderEnd.tiles";		
		
		}		
		else { 
			String msg = "세션이 만료되었습니다.";
			String loc = request.getContextPath() + "/mainartree.at";
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);		
			
			return "msg";
		}			
	}
	
	@ResponseBody
	@RequestMapping(value = "/delCart.at")
	public String delCart(HttpServletRequest request) {
		String jsonStr = "";
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		String delCartNo = request.getParameter("delCartNo");
		service.delCartDetail(delCartNo);
		service.delCart(delCartNo);
		jsonArr.put(jsonObj);
		jsonStr = jsonArr.toString();
		return jsonStr;
	}

	@ResponseBody
	@RequestMapping(value = "/cartList.at", produces = "text/plain;charset=UTF-8")
	public String cartList(HttpServletRequest request) {

		String jsonStr = "";
		JSONArray jsonArr = new JSONArray();
		HashMap<String, String> map = new HashMap<String, String>();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("loginuser");		
		String idx = mvo.getIdx();			
		map.put("idx", idx);
		String cartNo = "";

		// 장바구니 번호들 불러와서 상세 조회
		List<HashMap<String, String>> CartNoList = service.selectCartNoList(map);

		for (int i = 0; i < CartNoList.size(); i++) {
			cartNo = CartNoList.get(i).get("cartno");
			String dday = CartNoList.get(i).get("dday");
			String exnameList = CartNoList.get(i).get("exname");
			JSONObject jsonObj = new JSONObject();

			jsonObj.put("cartNo", cartNo);
			jsonObj.put("dday", dday);
			jsonObj.put("exname", exnameList);

			jsonArr.put(jsonObj);
		}

		jsonStr = jsonArr.toString();
		return jsonStr;
	}

	@ResponseBody
	@RequestMapping(value = "/cartDetailList.at", produces = "text/plain;charset=UTF-8")
	public String cartDetailList(HttpServletRequest request) {
		String cartNo = request.getParameter("cartNo");
		List<HashMap<String, String>> cartDetailList = service.cartDetailList(cartNo);
		String jsonStr = "";
		JSONArray jsonArr = new JSONArray();
		int n = 0;

		for (int a = 0; a < cartDetailList.size(); a++) {
			String qtList = cartDetailList.get(a).get("qt");
			String priceList = cartDetailList.get(a).get("price");
			String purtype = cartDetailList.get(a).get("purtype");
			n += Integer.parseInt(qtList) * Integer.parseInt(priceList);
			JSONObject jsonObj = new JSONObject();

			jsonObj.put("qt", qtList);
			jsonObj.put("purtype", purtype);
			jsonObj.put("price", priceList);
			jsonObj.put("subtotal", n);

			jsonArr.put(jsonObj);
		}

		jsonStr = jsonArr.toString();

		return jsonStr;
	}
	
	@ResponseBody
	@RequestMapping(value = "/monthlySales.at", produces = "text/plain;charset=UTF-8")
	public String monthlySales(HttpServletRequest request) {
		HashMap<String,String> map = new HashMap<String,String>();
		List<HashMap<String, String>> monthlySalesList = service.monthlySalesList(map);
		String jsonStr = "";
		JSONArray jsonArr = new JSONArray();		
		
		for (int a = 0; a < monthlySalesList.size(); a++) {
		
			JSONObject jsonObj = new JSONObject();
			
			Set key = monthlySalesList.get(a).keySet();
			Iterator iterator = key.iterator();		
			for (iterator = key.iterator(); iterator.hasNext();) {
			   String keyName = (String) iterator.next();		
			   jsonObj.put(keyName, monthlySalesList.get(a).get(keyName));			   
			}	
			
			jsonArr.put(jsonObj);
		}

		jsonStr = jsonArr.toString();

		return jsonStr;
	}

	@ResponseBody
	@RequestMapping(value = "/dailySales.at", produces = "text/plain;charset=UTF-8")
	public String dailySales(HttpServletRequest request) {		

		HashMap<String,String> map = new HashMap<String,String>();
		String reserdate =request.getParameter("reserdate");		
		map.put("reserdate", reserdate);
		List<HashMap<String, String>> dailySalesList = service.dailySalesList(map);
		String jsonStr = "";
		JSONArray jsonArr = new JSONArray();		
		
		for (int a = 0; a < dailySalesList.size(); a++) {
		
			JSONObject jsonObj = new JSONObject();
			
			Set key = dailySalesList.get(a).keySet();
			Iterator iterator = key.iterator();		
			for (iterator = key.iterator(); iterator.hasNext();) {
			   String keyName = (String) iterator.next();		
			   jsonObj.put(keyName, dailySalesList.get(a).get(keyName));			   
			}				
			jsonArr.put(jsonObj);
		}

		jsonStr = jsonArr.toString();		
		return jsonStr;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delReser.at")
	public void delReser(HttpServletRequest request) {
		HashMap<String,String> map = new HashMap<String,String>();
		String reserNo = request.getParameter("reserNo");
		map.put("reserNo", reserNo);		
		List<HashMap<String,String>> reserDetailNo = service.reserDetailNo(map);
		
		for (int a=0; a<reserDetailNo.size(); a++) {
			String detailNo = reserDetailNo.get(a).get("RESERDETAILNO");
			//service.delReserEx(detailNo);
			service.upReserEx(detailNo);
		}
		//service.delReserDetail(reserNo);
		//service.delReser(reserNo);	
		service.upReserDetail(reserNo);
		service.upReser(reserNo);	
	}
	
}
