package egovframework.portal.mailing.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.RequestAttribute;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.mailing.service.PortalMailingService;
import egovframework.portal.model.User;

/**
 * 메일링  서비스 구현 클래스
 * 
 * @author SBCHOI
 * @version 1.0 2019/11/25
 */
@Service(value="portalMailingService")
public class PortalMailingServiceImpl extends BaseService implements PortalMailingService {
	@Resource(name="portalMailingDao")
	private PortalMailingDao portalMailingDao;
	
	/**
	 * 인기공개정보 조회
	 */
	@Override
	public List<Record> selectPplrInfoRank(Params params) {
		return (List<Record>) portalMailingDao.selectPplrInfoRank(params);
	}
	
	/**
	 * 국회문화 행사 리스트 조회
	 */
	@Override
	public List<Record> selectCultureList(Params params) {
		return (List<Record>) portalMailingDao.selectCultureList(params); 
	}
	
	/**
	 * 날짜 조회
	 */
	@Override
	public List<Record> selectWeekDateList(Params params) {
		return (List<Record>) portalMailingDao.selectWeekDateList(params); 
	}
	
	/**
	 * 국회 주간일정 조회
	 */
	@Override
	public List<Record> selectNaScheduleList(Params params) {
		return (List<Record>) portalMailingDao.selectNaScheduleList(params);
	}
}
