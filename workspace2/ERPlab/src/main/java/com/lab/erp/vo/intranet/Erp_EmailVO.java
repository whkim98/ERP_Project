package com.lab.erp.vo.intranet;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_EmailVO {
	private String address;
	private String title;
	private String message;
}
