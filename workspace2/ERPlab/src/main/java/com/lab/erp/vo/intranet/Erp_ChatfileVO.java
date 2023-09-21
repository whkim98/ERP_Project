package com.lab.erp.vo.intranet;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ChatfileVO {
	private int chatfile_no;
	private String chatfile_file;
	private String chatfile_time;
	private int employee2_no;
	private int chatroom_no;
}
