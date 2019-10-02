package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Compliment {
	private String complimentseq;
	private String compliment_title;
	private String userid;
	private String compliment_contents;
	private String compliment_date;
}
