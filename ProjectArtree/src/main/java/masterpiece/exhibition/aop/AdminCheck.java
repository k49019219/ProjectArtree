package masterpiece.exhibition.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import masterpiece.exhibition.member.model.MemberVO;

@Aspect
@Component
public class AdminCheck {
	/* isAdmin_ 으로 시작하는 모든 메소드 */
	// === PointCut을 생성한다 ===
		@Pointcut("execution(public * masterpiece.exhibition..*Controller.isAdmin_*(..)) ")
		public void isAdmin() {}
		
		// === Before Advice를 구현한다 === //
		@Before("isAdmin()")
		public void before(JoinPoint joinpoint) {
			// joinpoint : 포인트 컷 된 주업무의 method
			
			// 로그인 유무 확인 ~ 주업무 메소드의 parameter, request를 얻어온다.
			HttpServletRequest request = (HttpServletRequest)joinpoint.getArgs()[0];
			HttpServletResponse response = (HttpServletResponse)joinpoint.getArgs()[1];
			HttpSession session = request.getSession();
			
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser == null || !"2".equals(loginuser.getStatus())) {
				try {
					String msg = "관리자의 접근만 가능합니다."; 
					String loc = "/artree";
					
					request.setAttribute("msg", msg);
					request.setAttribute("loc", loc);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
					
					dispatcher.forward(request, response);
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				} 
			} // end of if ------------------------------------------------	
		} // end of before ----------------------------------------------------------
}
