package com.lab.erp.vo.d.d1;

import java.util.List;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_BomVO {
	private int bom_no;
	private int goods_no1;
	private int goods_no2;
	private int bom_require;
	private String bom_obtain;
	private String bom_note;
	private int comcode_no;
	
	private List<Erp_BomVO> blist;
	private List<Erp_BomVO> blist1;
}
