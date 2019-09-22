package global.sesoc.tasukete.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Blacklist {
	private String userid;
	private String blacklist_contents;
	private String blacklist_deadline;
	
}
