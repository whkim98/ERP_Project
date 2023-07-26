package com.lab.erp.vo.d.d4;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_EquipmentVO {

	private int equipment_no;
	private String equipment_date;
	private int eqkind_no;
	private String equipment_code;
	private String equipment_name;
	private String equipment_production;
	private String equipment_expiry;
	private String equipment_contents;
	private int eqgrade_no;
	private int equipment_result;
	private int equipment_revalue;
	private String equipment_remark;
	private int comcode_no;

}
