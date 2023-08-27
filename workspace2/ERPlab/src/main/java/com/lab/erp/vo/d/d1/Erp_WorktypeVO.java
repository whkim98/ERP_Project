package com.lab.erp.vo.d.d1;

import java.util.List;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_WorktypeVO {

	private int worktype_no;
	private String worktype_name;
	private String worktype_content;
	
	private List<Erp_WorktypeVO> wlist;
	
}
