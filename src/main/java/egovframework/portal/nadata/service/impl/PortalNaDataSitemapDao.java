package egovframework.portal.nadata.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회사무처 정보서비스 사이트맵 화면 DB 접근 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/11
 */
@Repository(value="portalNaDataSitemapDao")
public class PortalNaDataSitemapDao extends BaseDao {
	
	/**
	 * 기관을 조회한다.
	 */
	public List<Record> selectCommOrgList(Params params) {
		return (List<Record>) list("portalNaDataSitemapDao.selectCommOrgList", params);
	}
	
	/**
	 * 정보서비스 사이트맵 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectSiteMapList(Params params) {  
		return list("portalNaDataSitemapDao.selectSiteMapList", params);
    }
	
	/**
	 * 사이트맵 조회 
	 * @param params
	 * @return
	 */  
	public Object selectNaDataSiteMapDtl(Params params) {
		return select("portalNaDataSitemapDao.selectNaDataSiteMapDtl", params);
	}

	/**
	 * 사이트맵 메뉴목록 조회
	 * @param params
	 * @return
	 */  
	public List<Record> selectMenuList(Params params) {
		return (List<Record>) list("portalNaDataSitemapDao.selectMenuList", params);
	}

	/**
	 * 정보서비스 사이트맵 검색 조회
	 * @param params
	 * @return
	 */
	public List<?> searchSiteMapList(Params params) {  
		return list("portalNaDataSitemapDao.searchSiteMapList", params);
    }
	
	/**
	 * 메뉴정보를 로그에 담는다.
	 */
	public Object insertLogMenu(Params params) {
		return insert("portalNaDataSitemapDao.insertLogMenu", params);
	}	
}