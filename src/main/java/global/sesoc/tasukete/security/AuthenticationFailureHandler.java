package global.sesoc.tasukete.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;

public class AuthenticationFailureHandler
      implements org.springframework.security.web.authentication.AuthenticationFailureHandler {

   @Override
   public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException authenticationException)
         throws IOException, ServletException {
      
      
      if(authenticationException instanceof BadCredentialsException){

         response.sendRedirect(request.getContextPath() + "/login?error=1");

         
      }
   }
}