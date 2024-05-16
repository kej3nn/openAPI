package egovframework.admin.stat.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 관리자 주요통계지표관리 Dao 클래스 이다.
 * 
 * @author	김정호
 * @version 1.0
 * @since   2017/08/10
 */

@Repository(value="statSttsMajorDao")
public class StatSttsMajorDao extends BaseDao {

	/**
	 * 주요통계지표 관리 메인 리스트
	 * @param params
	 * @return
	 */
	public List<?> selectStatSttsMajorList(Params params) {
		return list("StatSttsMajorDao.selectStatSttsMajorList", params);
	}

	/**
	 * 통계값 항목/분류 콤보 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblItmCombo(Params params) {
		return list("StatSttsMajorDao.selectStatTblItmCombo", params);
	}
	
	/**
	 * 통계값 자료구분 콤보 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblOptDtadvsCombo(Params params) {
		return list("StatSttsMajorDao.selectStatTblOptDtadvsCombo", params);
	}
	
	/**
	 * 주요통계지표 상세
	 * @param params
	 * @return
	 */
	public Record selectStatSttsMajorDtl(Params params) {
		return (Record) select("StatSttsMajorDao.selectStatSttsMajorDtl", params);
    }
	
	/**
	 * 주요통계지표 통계표 팝업 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblPopupList(Params params) {
		return list("StatSttsMajorDao.selectStatTblPopupList", params);
	}
	
	/**
	 * 주요통계지표 삭제
	 * @param params
	 * @return
	 */
	public int deleteStatSttsMajor(Params params) {
		return delete("StatSttsMajorDao.deleteStatSttsMajor", params);
	}
	
	/**
	 * 주요통계지표 순서저장
	 * @param params
	 * @return
	 */
	public Object updateStatSttsMajorOrder(Record record) {
		return update("StatSttsMajorDao.updateStatSttsMajorOrder", record);
	}
	
	/**
	 * 주요통계지표 MajorId 최대값을 조회한다.(입력시 사용)
	 */
	public int selectMaxMajorId() {
		return (Integer) select("StatSttsMajorDao.selectMaxMajorId");
	}
	
	/**
	 * 주요통계지표 등록/수정
	 */
	public int saveStatSttsMajor(Params params) {
		return merge("StatSttsMajorDao.mergeStatSttsMajor", params);
	}
	
	
}

