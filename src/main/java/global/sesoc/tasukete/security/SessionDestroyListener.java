package global.sesoc.tasukete.security;

import java.util.List;


import org.springframework.context.ApplicationListener;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;

@Component
public class SessionDestroyListener implements ApplicationListener<SessionDestroyedEvent> {

	@Override
	public void onApplicationEvent(SessionDestroyedEvent event) {
		List<SecurityContext> securityContexts = event.getSecurityContexts();
		
		for(SecurityContext securityContext : securityContexts){
			//Tasukete_user tasukete_user = (Tasukete_user)securityContext.getAuthentication().getPrincipal();
			User user = (User)securityContext.getAuthentication().getPrincipal();
			System.out.println("=================================");
			System.out.println(user.getUsername());
			System.out.println("=================================");
		}
	}
}
