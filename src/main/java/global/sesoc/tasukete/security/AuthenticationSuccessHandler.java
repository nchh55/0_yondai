package global.sesoc.tasukete.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;

import global.sesoc.tasukete.controller.UserController;

public class AuthenticationSuccessHandler
      implements org.springframework.security.web.authentication.AuthenticationSuccessHandler {

   @Override
   public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
         throws IOException, ServletException {
      
      //로그인 후 원래 위치로 돌아가기 (referer이 있다면)
      if(!UserController.back.equals("")){
         response.sendRedirect(UserController.back);
         return;
      }
      System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@");
      
      response.sendRedirect(request.getContextPath()+"/index");
   }

}