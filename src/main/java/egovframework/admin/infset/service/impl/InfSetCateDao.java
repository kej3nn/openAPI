package egovframework.admin.infset.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="infSetCateDao")
public class InfSetCateDao extends BaseDao {

	/**
	 * 정보 분류 메인 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectInfSetCateList(Params params) {
		return list("InfSetCateDao.selectInfSetCateList", params);
	}
	
	/**
	 * 정보 분류 팝업 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectInfSetCatePopList(Params params) {
		return list("InfSetCateDao.selectInfSetCatePopList", params);
	}
	
	/**
	 * 정보 분류 상세 조회
	 * @param params
	 * @return
	 */
	public Object selectInfSetCateDtl(Params params) {
		return select("InfSetCateDao.selectInfSetCateDtl", params); 
	}
	
	/**
	 * 정보 분류 ID 중복체크
	 * @param params
	 * @return
	 */
	public Object selectInfSetCateDupChk(Params params) {
		return select("InfSetCateDao.selectInfSetCateDupChk", params); 
	}
	
	/**
	 * 정보 분류 등록/수정
	 * @param params
	 * @return
	 */
	public Object saveInfSetCate(Params params) {
		return merge("InfSetCateDao.mergeInfSetCate", params);
	}
	
	/**
	 * 관련된 분류 전체명, 분류 레벨 일괄 업데이트 처리
	 * @param params
	 * @return
	 */
	public Object updateInfSetCateFullnm(Params params) {
		return update("InfSetCateDao.updateInfSetCateFullnm", params);
	}
	
	/**
	 * 정보 분류 자식 존재 여부 조회
	 * @param params
	 * @return
	 */
	public Record selectInfSetCateHaveChild(Params params) {
		return (Record) select("InfSetCateDao.selectInfSetCateHaveChild", params); 
	}
	
	/**
	 * 정보 분류 삭제
	 * @param params
	 * @return
	 */
	public Object deleteInfSetCate(Params params) {
		return delete("InfSetCateDao.deleteInfSetCate", params);
	}
	
	/**
	 * 정보 분류 순서 저장
	 * @param record
	 * @return
	 */
	public Object saveInfSetCateOrder(Record record) {
		return update("InfSetCateDao.saveInfSetCateOrder", record);
	}
	
	/**
	 * 데이터 수정시 사용여부 N처리 될 경우 N처리된 하위 항목들은 모두 동일하게 사용여부 N처리 한다.
	 * @param params
	 * @return
	 */
	public Object updateInfoCateChildUseN(Params params) {
		return update("InfSetCateDao.updateInfoCateChildUseN", params);
	}
	
	
}
