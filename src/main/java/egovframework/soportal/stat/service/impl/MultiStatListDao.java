package egovframework.soportal.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 통계표를 관리하는 DAO 클래스
 * @author	소프트온
 * @version 1.0
 * @since   2017/09/22
 */

@Repository(value="multiStatListDao")
public class MultiStatListDao extends BaseDao {

	//통계표 옵션정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMultiStatDtlOpt(Params params) {
		return (List<Map<String, Object>>) list("multiStatListDao.selectMultiStatDtlOpt", params);
    }
	
	//통계자료 작성일정 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMultiStatDtlSchl(Params params) {
		return (List<Map<String, Object>>) list("multiStatListDao.selectMultiStatDtlSchl", params);
    }
	
	//통계표 상세조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMultiStatDtl(Params params) {
		return (List<Map<String, Object>>) list("multiStatListDao.selectMultiStatDtl", params);
    }

	/**
	 * 통계표 단위 조회
	 * @param params
	 * @return
	 */
	public List<?> selectMultiStatTblUi(Params params) {
		return list("multiStatListDao.selectMultiStatTblUi", params);
    }
	
	/**
	 * 통계표 통계자료유형 조회
	 * @param params
	 * @return
	 */
	public List<?> selectMultiStatTblDtadvs(Params params) {
		return list("multiStatListDao.selectMultiStatTblDtadvs", params);
    }

	//통계표 검색주기 조회
	public List<?> statMultiDtacycleList(Params params) {
		return list("multiStatListDao.statMultiDtacycleList", params);
    }
	
	/**
	 * 시트 표두/표측 정보 조회
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Record> selectMultiStatTblItm(Params params) {
		return (List<Record>) list("multiStatListDao.selectMultiStatTblItm", params);
    }
	public Map<String, String> selectMultiStatTblOptLocation(Params params) {
		return (Map<String, String>) select("multiStatListDao.selectMultiStatTblOptLocation", params);
	}
	
	/**
	 * 통계표 주석 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectMultiStatCmmtList(Params params) {
		return list("multiStatListDao.selectMultiStatCmmtList", params);
	}

	/**
	 * 시트 표두/표측 정보 조회 전 승인 데이터 건수 확인
	 * @param params
	 * @return
	 */
	public int selectMultiStatItmACCount(Params params) {
		return (Integer)getSqlMapClientTemplate().queryForObject("multiStatListDao.selectMultiStatItmACCount", params);
    }
	
	/**
	 * 시트 데이터 조회
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Record> selectMultiStatSheetData(Params params) {
		return (List<Record>) list("multiStatListDao.selectMultiStatSheetData", params);
    }
	
	/**
	 * 기준시점대비 시트 데이터 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Record> selectBPointStatSheetData(Params params) {
		return (List<Record>) list("multiStatListDao.selectBPointStatSheetData", params);
    }
	
	/**
	 * 자료시점 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatMultiWrtTimeOption(Params params) {
		return search("multiStatListDao.selectMultiStatWrtTimeOption", params);
	}
	
	/**
	 * 통계스크랩 마스터 정보 등록
	 */
	public Object insertStatMultiUserTbl(Params params) {
		return insert("multiStatListDao.insertStatMultiUserTbl", params);
	}
	
	/**
	 * 통계스크랩 마스터 정보 수정
	 */
	public Object updateStatMultiUserTbl(Params params) {
		return update("multiStatListDao.updateStatMultiUserTbl", params);
	}
	
	/**
	 * 통계스크랩 항목, 분류 정보 등록
	 */
	public Object insertStatMultiUserTblItm(Params params) {
		return insert("multiStatListDao.insertStatMultiUserTblItm", params);
	}

	/**
	 * 통계스크랩 항목, 분류 정보 삭제
	 */
	public Object deleteStatMultiUserTblItm(Params params) {
		return delete("multiStatListDao.deleteStatMultiUserTblItm", params);
	}
	
	/**
	 * 통계 스크랩 마스터 정보 조회
	 */
	public Record selectStatMultiUserTbl(Params params) {
		return (Record) select("multiStatListDao.selectStatMultiUserTbl", params);
	}
	
	/**
	 * 통계 스크랩 항목, 분류 정보 조회
	 */
	public List<?> selectStatMultiUserTblItm(Params params) {
		return list("multiStatListDao.selectStatMultiUserTblItm", params);
	}
	
	/**
	 * 통계 스크랩 시계열 정보 조회
	 */
	@SuppressWarnings("unchecked")
	public Record selectMultiName(Params params) {
		return (Record) select("multiStatListDao.selectMultiName", params);
    }
	
	/**
	 * 사칙연산 데이터 수식 입력 조회 
	 */
	public List<Record> selectMultiStatCalcRslt(Params params) {
		return (List<Record>) list("multiStatListDao.selectMultiStatCalcRslt", params);
    }
}
