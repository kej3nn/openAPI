package egovframework.portal.bpm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 의정활동 통합현황 - 청원 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Repository(value="bpmPetDao")
public class BpmPetDao extends BaseDao {

	/**
	 * 국회의원 청원 조회 페이징
	 */
	Paging searchPetAssmMemb(Params params, int page, int rows) {
		params.put("petitGubun", "의원소개청원");
		return search("bpmPetDao.searchPetAssmMemb", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 국회의원 청원 조회
	 */
	List<Record> searchPetAssmMemb(Params params) {
		params.put("petitGubun", "의원소개청원");
		return (List<Record>) list("bpmPetDao.searchPetAssmMemb", params);
	}
	
	/**
	 * 국민동의 청원 조회 페이징
	 */
	Paging searchPetAprvNa(Params params, int page, int rows) {
		params.put("petitGubun", "국민동의청원");
		return search("bpmPetDao.searchPetAssmMemb", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 국민동의 청원 조회 리스트
	 */
	List<Record> searchPetAprvNa(Params params) {
		params.put("petitGubun", "국민동의청원");
		return (List<Record>) list("bpmPetDao.searchPetAssmMemb", params);
	}
}
