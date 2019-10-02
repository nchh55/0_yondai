package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Suggreply {
	private int suggreplyseq;
	private int suggestionseq;
	private String userid;
	private String suggreply_contents;
	private String suggreply_date;
}
