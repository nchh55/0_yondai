package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Request {
	private String requestseq;
	private String request_contents;
	private String userid;
	private String support_id;
	private String request_location;
	private String support_location;
	private String request_date;
	private String completion_date;
	private String disabled;
	private String pregnancy;
	private String request_flag;

}
