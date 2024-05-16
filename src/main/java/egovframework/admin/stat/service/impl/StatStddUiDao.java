package egovframework.admin.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="statStddUiDao")
public class StatStddUiDao extends BaseDao {

	/**
	 * 표준단위정보 메인 리스트 조회
	 */
	public List<Record> selectStatStddUiList(Params params) {
        return (List<Record>) list("StatStddUiDao.selectStatStddUiList", params);
    }
	
	/**
	 * 표준단위정보 상세 조회
	 */
	public Map<String, Object> selectStatStddUiDtl(Map<String, String> paramMap) {
		return (Map<String, Object>) select("StatStddUiDao.selectStatStddUiDtl", paramMap);
    }
	
	/**
	 * 표준단위정보를 등록한다.
	 */
	public Object insertStatStddUi(Params params) {
        return insert("StatStddUiDao.insertStatStddUi", params);
    }
	
	/**
	 * 표준단위정보를 수정한다. 
	 */
	public Object updateStatStddUi(Params params) {
        return update("StatStddUiDao.updateStatStddUi", params);
    }
	
	/**
	 * 표준단위정보를 삭제한다. 
	 */
	public Object deleteStatStddUi(Params params) {
        return delete("StatStddUiDao.deleteStatStddUi", params);
    }
	
	/**
	 * 표준단위정보 중복체크(등록시)
	 */
	public Object selectStatStddUiDupChk(Params params) {
		return select("StatStddUiDao.selectStatStddUiDupChk", params);
	}
	
	/**
	 * 상위 항목구분 변경 및 삭제시 자식레벨이 있는지 확인
	 * @param id	단위ID
	 * @return		Y/N (Y일경우 자식레벨이 존재)
	 */
	public Object selectStatStddUiIsLeaf(String id) {
		return select("StatStddUiDao.selectStatStddUiIsLeaf", id);
	}
	
	/**
	 * 표준단위정보 순서저장
	 * @param id
	 * @return
	 */
	public Object saveStatStddUiOrder(Params params) {
		return update("StatStddUiDao.saveStatStddUiOrder", params);
	}
	
	/**
	 * 표준단위정보 단위 그룹 조회
	 * @param params
	 * @return
	 */
	public List<Record> selectStatStddGrpUiList(Params params) {
        return (List<Record>) list("StatStddUiDao.selectStatStddGrpUiList", params);
    }
	
	/**
	 * 표준단위정보 팝업 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatStddUiPopList(Params params) {
        return list("StatStddUiDao.selectStatStddUiPopList", params);
    }
	
}
