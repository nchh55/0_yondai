package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Tasukete_user {
	private String userid;
	private String uservnum;
	private String username;
	private String userbirth;
	private String userphone;
	private String disabled;
	private int compliment_count;
	private String matching_flag;
	
	public Tasukete_user(String userid, String userphone) {
		this.userid = userid;
		this.userphone = userphone;
	}

	public Tasukete_user(String userid, String username, String userbirth, String userphone) {
		this.userid = userid;
		this.username = username;
		this.userbirth = userbirth;
		this.userphone = userphone;
	}

	public Tasukete_user(String userid, String username, String userbirth, String userphone, String disabled) {
		this.userid = userid;
		this.username = username;
		this.userbirth = userbirth;
		this.userphone = userphone;
		this.disabled = disabled;
	}
	
	
	
	
}
