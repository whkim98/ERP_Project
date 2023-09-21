package com.lab.erp.vo.intranet;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ChatroomVO {
	private int chatroom_no;
	private String chatroom_title;
	private String chatroom_memo;
	private int employee2_no1;
	private int employee2_no2;
	private int comcode_no;
}
