package com.lab.erp.vo.c;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_MultigoodsVO {
	private int multigoods_no;
	private int goods_no;
	private String func_code;
	
	private List<Erp_MultigoodsVO> multigoods_list;
}
