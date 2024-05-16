package egovframework.admin.infset.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.grid.IBSheetListVO;

/**
 * 정보셋을 관리하는 인터페이스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/07/29
 */
public interface InfSetMgmtService {
	
	public Paging selectInfSetMainListPaging(Params params);
	
	public Record selectDtl(Params params);
	
	Result saveInfSet(Params params);
	
	Result deleteInfSet(Params params);
	
	List<Record> selectInfSetCatePop(Params params);
	
	List<Record> selectInfoSetCate(Params params);
	
	List<Record> selectInfoSetUsr(Params params);
	
	List<Record> selectDocListPop(Params params);
	
	List<Record> selectOpenListPop(Params params);
	
	List<Record> selectStatListPop(Params params);
	
	Result saveInfSetRel(Params params);
	
	List<Record> selectInfoSetRelDoc(Params params);
	
	List<Record> selectInfoSetRelOpen(Params params);
	
	List<Record> selectInfoSetRelStat(Params params);
	
	Result updateInfSetOpenState(Params params);
	
	List<Record> selectInfSetExp(Params params);
	
	Result saveInfSetExp(Params params);
	
	Result deleteInfSetExp(Params params);
	
	Result saveInfSetExpOrder(Params params);
}
