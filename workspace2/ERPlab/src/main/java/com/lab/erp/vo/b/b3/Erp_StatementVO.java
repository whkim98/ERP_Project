package com.lab.erp.vo.b.b3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_StatementVO {

	private int statement_no;
	private int ctgr_no;
	private String statement_code;
	private String statement_date;
	private int client_no;
	private int team_no;
	private int debtor_no;
	private int creditor_no;
	private String statement_type;
	private String statement_abstract;
	private int statement_debtor;
	private int statement_creditor ;
	private int comcode_no;

}
