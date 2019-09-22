package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Sugrereply {
	private String sugrereplyseq;
	private String suggreplyseq;
	private String userid;
	private String sugreplyre_contents;
	private String sugreplyre_date;
}
