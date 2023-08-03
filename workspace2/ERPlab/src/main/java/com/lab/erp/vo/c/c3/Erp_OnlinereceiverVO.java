package com.lab.erp.vo.c.c3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_OnlinereceiverVO {

	private int onlinereceiver_no;
	private int online_no;
	private String onlinereceive_name;
	private String onlinereceive_addr1;
	private String onlinereceive_addr2;
	private String onlinereceive_postal;
	private String onlinereceive_phone;
	
}
