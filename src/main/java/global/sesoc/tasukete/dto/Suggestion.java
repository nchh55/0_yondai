package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Suggestion {
	private String suggestionseq;
	private String suggestion_title;
	private String userid;
	private String suggestion_contents;
	private String suggestion_result;
	private String reception_date;
	private String completion_date;
	private String progress_flag;
	
}
