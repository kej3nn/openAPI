package egovframework.portal.infs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 사전정보공개 목록을 관리하는 DB 접근 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/12
 */
@Repository(value="portalInfsListDao")
public class PortalInfsListDao extends BaseDao {

	/**
	 * 정보공개 목록 조회(페이징)
	 */
	public Paging selectInfsListPaging(Params params, int page, int rows) {
		return search("portalInfsListDao.selectInfsListPaging", params, page, rows, PAGING_MANUAL);
    }
	
	/**
	 * 기관을 조회한다.(최상위조직)
	 */
	public List<Record> selectCommOrgTop(Params params) {
		return (List<Record>) list("portalInfsListDao.selectCommOrgTop", params);
	}
	
	/**
	 * 정보셋 ID에 속한 정보서비스 목록을 조회한다.
	 */
	public List<Record> selectInfsInfoRelList(Params params) {
		return (List<Record>) list("portalInfsListDao.selectInfsInfoRelList", params);
	}
	
	/**
	 * 체크된 정보서비스 정보 조회 
	 */
	public List<Record> selectInfsInfoList(Params params) {
		return (List<Record>) list("portalInfsListDao.selectInfsInfoList", params);
	}
}
