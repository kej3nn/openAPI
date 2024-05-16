package egovframework.portal.main.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 포털 메인화면 DAO 클래스
 * 
 * @author JHKIM
 * @version 1.0 2019/10/14
 */
@Repository(value="portalMainDao")
public class PortalMainDao extends BaseDao {

	/**
	 * 게시판 리스트 조회
	 */
	public List<?> searchBbsList(Params params) {
		return list("portalMainDao.searchBbsList", params);
	}
	
	/**
	 * 국회는 지금 리스트 조회
	 */
	public List<?> selectAssmNowList(Params params) {
		return list("portalMainDao.selectAssmNowList", params);
	}
	
	/**
	 * 입법예고 리스트 조회
	 */
	public List<?> selectPalInPrgrList(Params params) {
		return list("portalMainDao.selectPalInPrgrList", params);
	}
	
	/**
	 * 의안목록 조회
	 */
	public List<?> selectBpmBillList(Params params) {
		return list("portalMainDao.selectBpmBillList", params);
	}
	
	/**
	 * 표결현황 목록 조회 
	 */
	public List<?> selectBpmVoteResultList(Params params) {
		return list("portalMainDao.selectBpmVoteResultList", params);
	}
	
	/**
	 * 표결현황수 조회
	 */
	public Record selectBpmVoteResultCnt(Params params) {
		return (Record) select("portalMainDao.selectBpmVoteResultCnt", params);
	}
	
	/**
	 * 국회일정 조회 
	 */
	public List<?> selectBultSchdList(Params params) {
		return list("portalMainDao.selectBultSchdList", params);
	}
	
	/**
	 * 국회일정 캘린더 조회 
	 */
	public List<?> selectBultSchdCalendarList(Params params) {
		return list("portalMainDao.selectBultSchdCalendarList", params);
	}
	
	/**
	 * 국회TV(편성표) 
	 */
	public List<?> selectBrdPrmList(Params params) {
		return list("portalMainDao.selectBrdPrmList", params);
	}
	
	/**
	 * 인기공개 정보 조회
	 */
	public List<?> selectPplrInfa(Params params) {
		return list("portalMainDao.selectPplrInfa", params);
	}
	
	/**
	 * 국회생중계 데이터 조회
	 */
	public List<?> selectAssmLiveStat(Params params) {
		return list("portalMainDao.selectAssmLiveStat", params);
	}
	
	/**
	 * 통합검색시 로그 입력
	 */
	public Object insertTbLogSearch(Params params) {
		return insert("portalMainDao.insertTbLogSearch", params);
	}
	
	/**
	 * 의안처리현황 조회
	 */
	public Record selectBillRecpFnshCnt(Params params) {
		return (Record) select("portalMainDao.selectBillRecpFnshCnt", params);
	}
	
	/**
	 * 메인설정 리스트 조회
	 */
	public List<?> selectCommHomeList(Params params) {
		return list("portalMainDao.selectCommHomeList", params);
	}
	
	/**
	 * OPEN API 메인 주간인기 조회(월~일)
	 * @param params
	 * @return
	 */
	public List<?> selectOpenApiWeeklyPopularList(Params params) {
		return list("portalMainDao.selectOpenApiWeeklyPopularList", params);
	}
	
	/**
	 * OPEN API 메인 월간인기 조회
	 * @param params
	 * @return
	 */
	public List<?> selectOpenApiMonthlyPopularList(Params params) {
		return list("portalMainDao.selectOpenApiMonthlyPopularList", params);
	}
}
