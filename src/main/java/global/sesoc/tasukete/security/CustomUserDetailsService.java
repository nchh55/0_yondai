package global.sesoc.tasukete.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import global.sesoc.tasukete.security.CustomUser;
import global.sesoc.tasukete.dao.UserMapper;
import global.sesoc.tasukete.dto.Tasukete_user;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
 
@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	
	@Setter(onMethod_ = { @Autowired })
	private UserMapper usermapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("Load User By UserName : " + username);
		
		Tasukete_user tasukete_user = usermapper.read(username);
		
	
		
		log.warn("queried by member mapper : " + tasukete_user);
		
		if (tasukete_user == null) {

	         throw new UsernameNotFoundException("No user found with username"); 
		}	  
		
		return tasukete_user == null ? null : new CustomUser(tasukete_user);
	}
	
	

}
