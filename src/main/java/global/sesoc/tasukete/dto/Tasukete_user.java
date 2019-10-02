package global.sesoc.tasukete.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Tasukete_user implements Comparable<Tasukete_user> {
   private String userid; 
   private String userpwd; 
   private String username; 
   private String userbirth; 
   private String userphone; 
   private String disabled; 
   private double user_x; 
   private double user_y; 
   private int compliment_count; 
   private String matching_flag; 
   private String statA; 
   private String statB; 
   private String statC; 
   private List<User_auth> authList;
   private double inter_distance;
   
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

	@Override
	public int compareTo(Tasukete_user tu) {
	    if (this.inter_distance < tu.getInter_distance()) {
	    	return -1;
	    } else if (this.inter_distance > tu.getInter_distance()) {
	    	return 1;
	    }
	    return 0;
	}
   
   
   
   
}