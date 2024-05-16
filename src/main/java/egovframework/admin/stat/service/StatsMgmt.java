package egovframework.admin.stat.service;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StatsMgmt {

	private String statblId;
	private String statblNm;
	private String dscnId;
	private String rpstuiNm;
	private String cateId;
	private String dtawrtStartYmd;
	private String dtawrtEndYmd;
	private String dtawrtChk;
	private String wrtstddCd;		//작성주기
	//작성주기 기간
	private String wrtstartMdYY;
	private String wrtendMdYY;
	private String wrtstartMdHY01;
	private String wrtendMdHY01;
	private String wrtstartMdHY02;
	private String wrtendMdHY02;
	private String wrtstartMdQY01;
	private String wrtendMdQY01;
	private String wrtstartMdQY02;
	private String wrtendMdQY02;
	private String wrtstartMdQY03;
	private String wrtendMdQY03;
	private String wrtstartMdQY04;
	private String wrtendMdQY04;
	private String wrtstartMdMM;
	private String wrtendMdMM;
	
	private String statblCmmt;
	private String openYn;
	private String openDttm;
	private String useYn;
	
	private String optTN;
	private String optTU;
	private String optIU;
	
}
