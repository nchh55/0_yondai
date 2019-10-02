package global.sesoc.tasukete.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Request_user {
	private int requestseq;
	private String request_contents;
	private String userid;
	private String support_id;
	private double req_x;
	private double req_y;
	private double supp_x;
	private double supp_y;
	private String request_date;
	private String completion_date;
	private String request_flag;
	
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
	

}



