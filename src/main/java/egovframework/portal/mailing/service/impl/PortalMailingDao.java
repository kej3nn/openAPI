package egovframework.portal.mailing.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
/**
 * 메일링  DAO 클래스
 * 
 * @author SBCHOI
 * @version 1.0 2019/11/25
 */
@Repository(value="portalMailingDao")
public class PortalMailingDao extends BaseDao {
	
	/**
	 * 인기공개 정보 조회
	 */
	public List<?> selectPplrInfoRank(Params params) {
		return list("portalMailingDao.selectPplrInfoRank", params);
	}
	
	/**
	 * 국회문화 행사 리스트 조회
	 */
	public List<?> selectCultureList(Params params) {
		return list("portalMailingDao.selectCultureList", params);
	}
	
	/**
	 * 날짜 조회
	 */
	public List<?> selectWeekDateList(Params params) {
		return list("portalMailingDao.selectWeekDateList", params);
	}
	
	/**
	 * 인기공개 정보 조회
	 */
	public List<?> selectNaScheduleList(Params params) {
		return list("portalMailingDao.selectNaScheduleList", params);
	}
}
