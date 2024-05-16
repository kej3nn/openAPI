package egovframework.portal.nadata.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회사무처 정보서비스 카탈로그 화면 DB 접근 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/11
 */
@Repository(value="portalNaDataCatalogDao")
public class PortalNaDataCatalogDao extends BaseDao {
	
	
	/**
	 * 정보카달로그 상위분류 리스트 조회
	 * @param params
	 * @return
	 */
	public List<Record> selectNaTopCateList(Params params){
		return (List<Record>) list("portalNaDataCatalogDao.selectNaTopCateList",params);
	}
	
	/**
	 * 정보카달로그 분류 상세 조회
	 * @param params
	 * @return
	 */
	public Object selectNaSetCateDtl(Params params) {
		return select("portalNaDataCatalogDao.selectNaSetCateDtl", params); 
	}
	
	/**
	 * 정보카달로그 사이트 이미지 조회
	 * @param params
	 * @return
	 */
	public Object selectNaDataImgPath(Params params) {
		return select("portalNaDataCatalogDao.selectNaDataImgPath", params); 
	}
	
	/**
	 * 정보카탈로그분류 트리 목록을 조회한다.
	 */
	public List<Record> selectNaDataCateTree(Params params) {
		return (List<Record>) list("portalNaDataCatalogDao.selectNaDataCateTree", params);
	}
	
	/**
	 * 정보카탈로그 상세 조회
	 */
	public Record selectInfoDtl(Params params) {
		return (Record) select("portalNaDataCatalogDao.selectInfoDtl", params);
	}
	
	/**
	 *정보카탈로그 서비스 조회수 증가
	 */
	public Object updateNaDataCatalogViewCnt(Params params) {
		return update("portalNaDataCatalogDao.updateNaDataCatalogViewCnt", params);
	}
	
	/**
	 * 정보카탈로그 디렉토리 목록 검색
	 */
	public Paging searchNaSetDirPaging(Params params, int page, int rows) {
		return search("portalNaDataCatalogDao.selectNaSetDirPaging", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 정보카탈로그와 연결된 카테고르의 최상위 ID 조회
	 */
	public String selectNaSetTopCateId(String infoId) {
		return (String) select("portalNaDataCatalogDao.selectNaSetTopCateId", infoId);
	}
	
	/**
	 * 정보카탈로그 목록(페이징)
	 */
	public Paging selectNaSetListPaging(Params params, int page, int rows) {
		return search("portalNaDataCatalogDao.selectNaSetListPaging", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 정보카탈로그 목록(전체)
	 */
	public List<Record> selectNaSetList(Params params) {
		return (List<Record>) list("portalNaDataCatalogDao.selectNaSetListPaging", params);
	}
	
}
