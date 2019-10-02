package global.sesoc.tasukete.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import global.sesoc.tasukete.controller.UserController;

public class authenticationSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		Cookie cookie = new Cookie("loginChk", "loginChk");
		response.addCookie(cookie);
		
		//로그인 후 원래 위치로 돌아가기
		if(!UserController.back.equals("")){
			response.sendRedirect(UserController.back);
			return;
		}
		
		response.sendRedirect(request.getContextPath()+"/index");
	}

}
