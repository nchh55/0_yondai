package global.sesoc.tasukete.security;


import org.springframework.context.ApplicationListener;
import org.springframework.security.core.session.SessionCreationEvent;
import org.springframework.stereotype.Component;

@Component
public class SessionCreateListener implements ApplicationListener<SessionCreationEvent> {

	@Override
	public void onApplicationEvent(SessionCreationEvent event) {
		System.out.println(event.getTimestamp());
		System.out.println(event.getSource());
	}
}
