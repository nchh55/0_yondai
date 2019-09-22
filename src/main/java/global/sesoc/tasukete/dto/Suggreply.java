package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Suggreply {
	private String suggreplyseq;
	private String suggestionseq;
	private String userid;
	private String suggreply_contents;
	private String suggreply_date;
}
