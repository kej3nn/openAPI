package egovframework.portal.main.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 포털 메인화면 인터페이스
 * 
 * @author JHKIM
 * @version 1.0 2019/10/14
 */
public interface PortalMainService {

	List<Record> searchBbsList(Params params);
	
	List<Record> selectAssmNowList(Params params);
	
	List<Record> selectPalInPrgrList(Params params);
	
	List<Record> selectBpmBillList(Params params);
	
	List<Record> selectBpmVoteResultList(Params params);
	
	Record selectBpmVoteResultCnt(Params params);
	
	List<Record> selectBultSchdList(Params params);
	
	List<Record> selectBultSchdCalendarList(Params params);
	
	List<Record> selectBrdPrmList(Params params);
	
	public List<Record> selectPplrInfa(Params params);
	
	List<Record> selectAssmLiveStat(Params params);
	
	public void insertTbLogSearch(Params params);
	
	public Record selectBillRecpFnshCnt(Params params);
	
	public List<?> selectCommHomeList(Params params);
	
	public List<?> selectOpenApiWeeklyPopularList(Params params);
	
	public List<?> selectOpenApiMonthlyPopularList(Params params);
}
