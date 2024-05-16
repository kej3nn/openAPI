package egovframework.admin.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="statSttsCateDao")
public class StatSttsCateDao extends BaseDao {

	/**
	 * 통계표 분류 메인 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatSttsCateList(Params params) {
		return list("StatSttsCateDao.selectStatSttsCateList", params);
	}
	
	/**
	 * 통계표 분류 팝업 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatSttsCatePopList(Params params) {
		return list("StatSttsCateDao.selectStatSttsCatePopList", params);
	}
	
	/**
	 * 통계표 분류 상세 조회
	 * @param params
	 * @return
	 */
	public Object selectStatSttsCateDtl(Params params) {
		return select("StatSttsCateDao.selectStatSttsCateDtl", params); 
	}
	
	/**
	 * 통계표 분류 ID 중복체크
	 * @param params
	 * @return
	 */
	public Object selectStatSttsCateDupChk(Params params) {
		return select("StatSttsCateDao.selectStatSttsCateDupChk", params); 
	}
	
	/**
	 * 통계표 분류 등록/수정
	 * @param params
	 * @return
	 */
	public Object saveStatSttsCate(Params params) {
		return merge("StatSttsCateDao.mergeStatSttsCate", params);
	}
	
	/**
	 * 관련된 분류 전체명, 분류 레벨 일괄 업데이트 처리
	 * @param params
	 * @return
	 */
	public Object updateStatSttsCateFullnm(Params params) {
		return update("StatSttsCateDao.updateStatSttsCateFullnm", params);
	}
	
	/**
	 * 통계표 분류 자식 존재 여부 조회
	 * @param params
	 * @return
	 */
	public Record selectStatSttsCateHaveChild(Params params) {
		return (Record) select("StatSttsCateDao.selectStatSttsCateHaveChild", params); 
	}
	
	/**
	 * 통계표 분류 삭제
	 * @param params
	 * @return
	 */
	public Object deleteStatSttsCate(Params params) {
		return delete("StatSttsCateDao.deleteStatSttsCate", params);
	}
	
	/**
	 * 통계표 분류 순서 저장
	 * @param record
	 * @return
	 */
	public Object saveStatSttsCateOrder(Record record) {
		return update("StatSttsCateDao.saveStatSttsCateOrder", record);
	}
	
}
