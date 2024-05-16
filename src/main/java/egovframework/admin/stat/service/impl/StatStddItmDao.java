package egovframework.admin.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="statStddItmDao")
public class StatStddItmDao extends BaseDao {

	/**
	 * 표준항목분류정보 메인 리스트 조회
	 */
	public List<Map<String, Object>> selectStatStddItmList(Params params) {
        return (List<Map<String, Object>>) list("StatStddItmDao.selectStatStddItmList", params);
    }
	
	/**
	 * 표준항목분류정보 상세 조회
	 */
	public Map<String, Object> selectStatStddItmDtl(Map<String, String> paramMap) {
		return (Map<String, Object>) select("StatStddItmDao.selectStatStddItmDtl", paramMap);
    }
	
	/**
	 * 표준항목분류정보를 등록한다.
	 */
	public Object insertStatStddItm(Params params) {
        return insert("StatStddItmDao.insertStatStddItm", params);
    }
	
	/**
	 * 표준항목분류정보를 수정한다. 
	 */
	public Object updateStatStddItm(Params params) {
        return update("StatStddItmDao.updateStatStddItm", params);
    }
	
	/**
	 * 표준항목분류정보를 삭제한다. 
	 */
	public Object deleteStatStddItm(Params params) {
        return delete("StatStddItmDao.deleteStatStddItm", params);
    }
	
	/**
	 * 자식레벨 존재 여부 확인
	 */
	public Object selectStatStddItmIsLeaf(String id) {
		return select("StatStddItmDao.selectStatStddItmIsLeaf", id);
	}
	
	/**
	 * 표준항목분류명 저장
	 * @param params
	 * @return
	 */
	public int saveStatStddItmNm(Params params) {
        // 데이터 컬럼 컬럼명을 수정한다.
        return update("StatStddItmDao.saveStatStddItmNm", params);
    }
	
	/**
	 * 표준항목분류 순서저장
	 * @param record
	 * @return
	 */
	public Object saveStatStddItmOrder(Record record) {
		return update("StatStddItmDao.saveStatStddItmOrder", record);
	}
	
}
