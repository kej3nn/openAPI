package egovframework.admin.infset.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="docInfCateDao")
public class DocInfCateDao extends BaseDao {

	/**
	 * 문서 분류 메인 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectDocInfCateList(Params params) {
		return list("DocInfCateDao.selectDocInfCateList", params);
	}
	
	/**
	 * 문서 분류 팝업 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectDocInfCatePopList(Params params) {
		return list("DocInfCateDao.selectDocInfCatePopList", params);
	}
	
	/**
	 * 문서 분류 상세 조회
	 * @param params
	 * @return
	 */
	public Object selectDocInfCateDtl(Params params) {
		return select("DocInfCateDao.selectDocInfCateDtl", params); 
	}
	
	/**
	 * 문서 분류 ID 중복체크
	 * @param params
	 * @return
	 */
	public Object selectDocInfCateDupChk(Params params) {
		return select("DocInfCateDao.selectDocInfCateDupChk", params); 
	}
	
	/**
	 * 문서 분류 등록/수정
	 * @param params
	 * @return
	 */
	public Object saveDocInfCate(Params params) {
		return merge("DocInfCateDao.mergeDocInfCate", params);
	}
	
	/**
	 * 관련된 분류 전체명, 분류 레벨 일괄 업데이트 처리
	 * @param params
	 * @return
	 */
	public Object updateDocInfCateFullnm(Params params) {
		return update("DocInfCateDao.updateDocInfCateFullnm", params);
	}
	
	/**
	 * 문서 분류 자식 존재 여부 조회
	 * @param params
	 * @return
	 */
	public Record selectDocInfCateHaveChild(Params params) {
		return (Record) select("DocInfCateDao.selectDocInfCateHaveChild", params); 
	}
	
	/**
	 * 문서 분류 삭제
	 * @param params
	 * @return
	 */
	public Object deleteDocInfCate(Params params) {
		return delete("DocInfCateDao.deleteDocInfCate", params);
	}
	
	/**
	 * 문서 분류 순서 저장
	 * @param record
	 * @return
	 */
	public Object saveDocInfCateOrder(Record record) {
		return update("DocInfCateDao.saveDocInfCateOrder", record);
	}
	
}
