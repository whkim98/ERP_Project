package com.lab.erp.vo.intranet;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ChatVO {
	private int chat_no;
	private String chat_text;
	private String chat_time;
	private int employee2_no;
	private int chatroom_no;
}
