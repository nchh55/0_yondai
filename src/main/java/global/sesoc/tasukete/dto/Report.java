package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Report {
	private String reportseq;
	private String report_title;
	private String userid;
	private String report_contents;
	private String report_date;

}
