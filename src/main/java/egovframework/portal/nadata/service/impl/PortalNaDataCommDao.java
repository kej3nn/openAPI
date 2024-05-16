package egovframework.portal.nadata.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 보고서&발간물 화면 DB 접근 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/11
 */
@Repository(value="portalNaDataCommDao")
public class PortalNaDataCommDao extends BaseDao {
	
	
	/**
	 * 분류 정보를 조회
	 * @param params
	 * @return
	 */
    public List<?> selectDataCommItm(Params params) {
        return search("PortalNaDataCommDao.selectDataCommItm", params);
    }
	
	/**
	 * 기관 정보를 조회
	 * @param params
	 * @return
	 */
    public List<?> selectDataCommOrg(Params params) {
        return search("PortalNaDataCommDao.selectDataCommOrg", params);
    }
	
	/**
	 * 발간주기 정보를 조회
	 * @param params
	 * @return
	 */
    public List<?> selectDataCommCycle(Params params) {
        return search("PortalNaDataCommDao.selectDataCommCycle", params);
    }
    
    /**
     * 국회사무처 보고서&발간물 내용을 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging searchNaDataComm(Params params, int page, int rows) {
    	return search("PortalNaDataCommDao.searchNaDataComm", params, page, rows, PAGING_MANUAL, false, false);
    }
	
}
