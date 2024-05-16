package egovframework.admin.menu.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="siteMenuDao")
public class SiteMenuDao extends BaseDao {

	/**
	 * 메뉴 관리 메인 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectSiteMenuList(Params params) {
		return list("SiteMenuDao.selectSiteMenuList", params);
	}
	
	/**
	 * 메뉴 관리 팝업 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectSiteMenuPopList(Params params) {
		return list("SiteMenuDao.selectSiteMenuPopList", params);
	}
	
	/**
	 * 메뉴 관리 상세 조회
	 * @param params
	 * @return
	 */
	public Object selectSiteMenuDtl(Params params) {
		return select("SiteMenuDao.selectSiteMenuDtl", params); 
	}
	
	/**
	 * 메뉴 관리 ID 중복체크
	 * @param params
	 * @return
	 */
	public Object selectSiteMenuDupChk(Params params) {
		return select("SiteMenuDao.selectSiteMenuDupChk", params); 
	}
	
	/**
	 * 메뉴 관리 등록/수정
	 *
	 * @param params
	 */
	public void saveSiteMenu(Params params) {
		merge("SiteMenuDao.mergeSiteMenu", params);
	}
	
	/**
	 * 관련된 분류 전체명, 분류 레벨 일괄 업데이트 처리
	 * @param params
	 * @return
	 */
	public Object updateSiteMenuFullnm(Params params) {
		return update("SiteMenuDao.updateSiteMenuFullnm", params);
	}
	
	/**
	 * 메뉴 관리 자식 존재 여부 조회
	 * @param params
	 * @return
	 */
	public Record selectSiteMenuHaveChild(Params params) {
		return (Record) select("SiteMenuDao.selectSiteMenuHaveChild", params); 
	}
	
	/**
	 * 메뉴 관리 삭제
	 *
	 * @param params
	 */
	public void deleteSiteMenu(Params params) {
		delete("SiteMenuDao.deleteSiteMenu", params);
	}
	
	/**
	 * 메뉴 관리 순서 저장
	 *
	 * @param record
	 */
	public void saveSiteMenuOrder(Record record) {
		update("SiteMenuDao.saveSiteMenuOrder", record);
	}
	
}
