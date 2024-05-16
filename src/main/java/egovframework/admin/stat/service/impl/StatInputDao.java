package egovframework.admin.stat.service.impl;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="statInputDao")
public class StatInputDao extends BaseDao {

	/**
	 * 통게표 메인 리스트 조회(페이징 처리)
	 */
	public Paging selectStatInputMainList(Params params, int page, int rows) {
        return search("StatInputDao.selectStatInputMainList", params, page, rows, PAGING_SCROLL);
    }
	
	/**
	 * 통계표 상세 조회
	 */
	public Map<String, Object> selectStatInputDtl(Map<String, String> paramMap) {
		return (Map<String, Object>) select("StatInputDao.selectStatInputDtl", paramMap);
    }
	
	/**
	 * 통계표 분류/항목 조회 
	 */
	public List<Map<String, Object>> selectStatInputItm(Params params) {
		return (List<Map<String, Object>>) list("StatInputDao.selectStatInputItm", params);
    }
	
	/**
	 * 통계 데이터 조회
	 */
	public List<Map<String, Object>> selectStatInputData(Params params) {
		return (List<Map<String, Object>>) list("StatInputDao.selectStatInputData", params);
    }
	
	/**
	 * 통계자료 비교자료 구분코드 조회
	 */
	public List<Map<String, Object>> selectStatDtadvsCd(Params params) {
		return (List<Map<String, Object>>) list("StatInputDao.selectStatDtadvsCd", params);
    }
	
	/**
	 *  통계표 항목의 검증코드와 정규식 확인
	 */
	public List<Map<String, Object>> selectStatChckRegExp(Params params) {
		return (List<Map<String, Object>>) list("StatInputDao.selectStatChckRegExp", params);
    }
	
	/**
	 * 통계표 입력 데이터 저장
	 */
	public Object insertStatInputData(Map<String, Object> pMap) {
        return update("StatInputDao.insertStatInputData", pMap);
    }
	
	/**
	 * 통계표 주석 데이터 저장
	 */
	public Object saveStatInputDataCmmt(Map<String, Object> cmmt) {
        return update("StatInputDao.saveStatInputDataCmmt", cmmt);
    }
	
	/**
	 * 통계데이터 주석 조회
	 */
	public List<Map<String, Object>> selectStatInputCmmtList(Params params) {
        return (List<Map<String, Object>>) list("StatInputDao.selectStatInputCmmtList", params);
    }
	
	/**
	 * 통계자료작성 처리 기록
	 */
	public Object insertStatInputLogWrtList(Params params) {
        return insert("StatInputDao.insertStatInputLogWrtList", params);
    }
	
	/**
	 * 통계 데이터셋 연계정보 조회
	 */
	public Map<String, Object> selectStatInputDscn(Params params) {
		return (Map<String, Object>) select("StatInputDao.selectStatInputDscn", params);
    }
	
	/**
	 * 분류항목 갯수 확인
	 */
	public int selectStatInputClsCnt(Params params) {
		params.set("itmTag", "C");
		return (Integer) select("StatInputDao.selectStatInputGrpClsCnt", params);
	}
	
	/**
	 * 그룹항목 갯수 확인
	 */
	public int selectStatInputGrpCnt(Params params) {
		params.set("itmTag", "G");
		return (Integer) select("StatInputDao.selectStatInputGrpClsCnt", params);
	}
	
	/**
	 * 검증 데이터 변경전 데이터 null 처리
	 * @param params
	 * @return
	 */
	public Object updateStatVerifyDataInit(Params params) {
        return update("StatInputDao.updateStatVerifyDataInit", params);
    }
	
	/**
	 * 자료작성코드 변경처리시 검증데이터 오류 건수 조회
	 * @param params
	 * @return
	 */
	public int selectStatInputVerifyCnt(Params params) {
		return (Integer) select("StatInputDao.selectStatInputVerifyCnt", params);
	}
	
	
	/**
	 * 승인시 통계 분석자료 생성
	 * @param params
	 * @return
	 */
	public Object execSpCreateSttsAnals(Params params) {
		return execPrc("StatInputDao.execSpCreateSttsAnals", params);
	}
	
	/**
	 * 자료시점 주석 조회
	 * @param params
	 * @return
	 */
	public Record selectSttsTblDif(Params params) {
        return (Record) select("StatInputDao.selectSttsTblDif", params);
    }
	
	/**
	 * 자료시점 주석 머지처리
	 * @param params
	 * @return
	 */
	public Object saveSttsTblDif(Params params) {
        return update("StatInputDao.saveSttsTblDif", params);
    }
	
	// 통계자료작성 처리기록 팝업 리스트 조회
	public List<Record> selectStatLogSttsWrtList(Params params) {
		return (List<Record>) list("StatInputDao.selectStatLogSttsWrtList", params);
    }
	
	/**
	 * 통계 사용자 입력권한체크
	 * @param params
	 * @return
	 */
	public String selectStatsInputUsrAcc(Params params) {
		return (String) select("StatInputDao.selectStatsInputUsrAcc", params);
	}
	
}
