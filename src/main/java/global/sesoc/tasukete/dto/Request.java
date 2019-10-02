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
	private double req_x;
	private double req_y;
	private double supp_x;
	private double supp_y;
	private String request_date;
	private String completion_date;
	private String request_flag;
	private String ex_support_id; // 지원자 변경시 기존 지원자의 ID를 저장

}
