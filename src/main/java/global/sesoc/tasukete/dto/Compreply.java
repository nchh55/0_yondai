package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Compreply {
	private String compreplyseq;
	private String complimentseq;
	private String userid;
	private String compreply_contents;
	private String compreply_date;
}
