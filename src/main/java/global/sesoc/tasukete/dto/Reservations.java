package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reservations {
	private String userid;
	private String support_id;
	private String reserseq_date;
	private String reserseq_place;
	private String reserseq_contents;
	
}
