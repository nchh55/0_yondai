package global.sesoc.tasukete.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import global.sesoc.tasukete.dto.Tasukete_user;
import lombok.Getter;

@Getter
public class CustomUser extends User{

	private static final long serialVersionUID = 1L;
	
	private Tasukete_user user;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(Tasukete_user tasukete_user){
		super(tasukete_user.getUserid(), tasukete_user.getUserpwd(),
				tasukete_user.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		
		this.user = tasukete_user;
	}

}
