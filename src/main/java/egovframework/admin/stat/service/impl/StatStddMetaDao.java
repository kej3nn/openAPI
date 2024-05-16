package egovframework.admin.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;

@Repository(value="statStddMetaDao")
public class StatStddMetaDao extends BaseDao {

	/**
	 * 표준메타정보 메인 리스트 조회
	 */
	public List<Map<String, Object>> selectStatStddMetaList(Params params) {
        return (List<Map<String, Object>>) list("StatStddMetaDao.selectStatStddMetaList", params);
    }
	
	/**
	 * 표준메타정보 상세 조회
	 */
	public Map<String, Object> selectStatStddMetaDtl(Map<String, String> paramMap) {
		return (Map<String, Object>) select("StatStddMetaDao.selectStatStddMetaDtl", paramMap);
    }
	
	/**
	 * 표준메타정보를 등록한다.
	 */
	public Object insertStatStddMeta(Params params) {
        return insert("StatStddMetaDao.insertStatStddMeta", params);
    }
	
	/**
	 * 표준메타정보를 수정한다. 
	 */
	public Object updateStatStddMeta(Params params) {
        return update("StatStddMetaDao.updateStatStddMeta", params);
    }
	
	/**
	 * 표준메타정보를 삭제한다. 
	 */
	public Object deleteStatStddMeta(Params params) {
        return delete("StatStddMetaDao.deleteStatStddMeta", params);
    }
	
	/**
	 * 표준메타정보 순서저장
	 * @param params
	 * @return
	 */
	public Object saveStatStddMetaOrder(Params params) {
		return update("StatStddMetaDao.saveStatStddMetaOrder", params);
	}
	
}
