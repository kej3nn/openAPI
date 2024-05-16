package egovframework.portal.main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.main.service.PortalMainService;

/**
 * 포털 메인화면 서비스 구현 클래스
 * 
 * @author JHKIM
 * @version 1.0 2019/10/14
 */
@Service(value="portalMainService")
public class PortalMainServiceImpl extends BaseService implements PortalMainService {

	@Resource(name="portalMainDao")
	private PortalMainDao portalMainDao;

	/**
	 * 게시판 리스트 조회
	 */
	@Override
	public List<Record> searchBbsList(Params params) {
		return (List<Record>) portalMainDao.searchBbsList(params);
	}

	/**
	 * 국회는 지금 리스트 조회
	 */
	@Override
	public List<Record> selectAssmNowList(Params params) {
		return (List<Record>) portalMainDao.selectAssmNowList(params);
	}

	/**
	 * 입법예고 리스트 조회
	 */
	@Override
	public List<Record> selectPalInPrgrList(Params params) {
		return (List<Record>) portalMainDao.selectPalInPrgrList(params);
	}
	
	/**
	 * 의안 목록조회
	 */
	@Override
	public List<Record> selectBpmBillList(Params params) {
		return (List<Record>) portalMainDao.selectBpmBillList(params);
	}

	/**
	 * 표결현황 목록 조회
	 */
	@Override
	public List<Record> selectBpmVoteResultList(Params params) {
		return (List<Record>) portalMainDao.selectBpmVoteResultList(params);
	}

	/**
	 * 표결현황수 조회
	 */
	@Override
	public Record selectBpmVoteResultCnt(Params params) {
		return portalMainDao.selectBpmVoteResultCnt(params);
	}

	/**
	 * 국회일정 조회
	 */
	@Override
	public List<Record> selectBultSchdList(Params params) {
		return (List<Record>) portalMainDao.selectBultSchdList(params);
	}

	/**
	 * 국회일정 캘린더 조회 
	 */
	@Override
	public List<Record> selectBultSchdCalendarList(Params params) {
		return (List<Record>) portalMainDao.selectBultSchdCalendarList(params);
	}
	
	/**
	 * 국회TV(편성표) 
	 */
	@Override
	public List<Record> selectBrdPrmList(Params params) {
		return (List<Record>) portalMainDao.selectBrdPrmList(params);
	}

	/**
	 * 인기공개정보 조회
	 */
	@Override
	public List<Record> selectPplrInfa(Params params) {
		// 일간, 주간, 월간 구분
		if ( StringUtils.equals("D", params.getString("schRange")) ) {
			params.put("range", "D");
		}
		else if ( StringUtils.equals("W", params.getString("schRange")) ) {
			params.put("range", "W");
		}
		else if ( StringUtils.equals("M", params.getString("schRange")) ) {
			params.put("range", "M");
		}
		else {
			params.put("range", "W");
		}
		return (List<Record>) portalMainDao.selectPplrInfa(params);
	}

	/**
	 * 국회생중계 데이터 조회
	 */
	@Override
	public List<Record> selectAssmLiveStat(Params params) {
		return (List<Record>) portalMainDao.selectAssmLiveStat(params);
	}

	/**
	 * 통합검색시 로그 입력
	 */
	@Override
	public void insertTbLogSearch(Params params) {
		portalMainDao.insertTbLogSearch(params);
	}

	/**
	 * 의안처리현황 조회
	 */
	@Override
	public Record selectBillRecpFnshCnt(Params params) {
		return portalMainDao.selectBillRecpFnshCnt(params);
	}
	
	/**
	 * 메인설정 리스트 조회
	 */
	public List<?> selectCommHomeList(Params params) {
		return portalMainDao.selectCommHomeList(params);
	}
	
	/**
	 * OPEN API 메인 주간인기 조회(월~일)
	 */
	@Override
	public List<?> selectOpenApiWeeklyPopularList(Params params) {
		return portalMainDao.selectOpenApiWeeklyPopularList(params);
	}
	
	/**
	 * OPEN API 메인 월간인기 조회
	 * @param params
	 * @return
	 */
	@Override
	public List<?> selectOpenApiMonthlyPopularList(Params params) {
		return portalMainDao.selectOpenApiMonthlyPopularList(params);
	}
}
