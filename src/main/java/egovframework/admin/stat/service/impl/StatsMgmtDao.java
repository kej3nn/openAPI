package egovframework.admin.stat.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatsStddTblItm;
import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 통계표를 관리하는 DAO 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/05/25
 */

@Repository(value="statsMgmtDao")
public class StatsMgmtDao extends BaseDao {
	
	//공통코드 값을 조회한다.
	public List<?> selectOption(Params params) {
		return search("StatsMgmtDao.selectOption", params);
	}
	
	//통계 공통코드 값을 조회한다.
	public List<?> selectSTTSOption(Params params) {
		return search("StatsMgmtDao.selectSTTSOption", params);
	}
	
	//통계메타명 팝업 데이터 리스트 조회
	public List<Map<String, Object>> selectStatsMetaPopList(Params params) {
        return (List<Map<String, Object>>) list("StatsMgmtDao.selectStatsMetaPopList", params);
    }
	
	//분류체계 팝업 데이터 리스트 조회
	public List<Map<String, Object>> selectStatsCatePopList(Params params) {
        return (List<Map<String, Object>>) list("StatsMgmtDao.selectStatsCatePopList", params);
    }
	
	//통계표 등록/수정 메인 리스트 조회
	public List<Record> statsMgmtList(Params params) {
        return (List<Record>) list("StatsMgmtDao.statsMgmtList", params);
    }
	
	//통계표 상세조회
	public Map<String, Object> selectStatsMgmtDtl(Map<String, String> paramMap) {
		return (Map<String, Object>) select("StatsMgmtDao.selectStatsMgmtDtl", paramMap);
    }
	
	//통계표 옵션정보 조회
	public List<Map<String, Object>> selectStatsMgmtDtlOpt(Map<String, String> paramMap) {
		return (List<Map<String, Object>>) list("StatsMgmtDao.selectStatsMgmtDtlOpt", paramMap);
    }
	
	//통계자료 작성일정 조회
	public List<Map<String, Object>> selectStatsMgmtDtlSchl(Map<String, String> paramMap) {
		return (List<Map<String, Object>>) list("StatsMgmtDao.selectStatsMgmtDtlSchl", paramMap);
    }
	
	//통계표 정보 등록
	public Object insertStatsTbl(Params params) {
        return insert("StatsMgmtDao.insertStatsTbl", params);
    }
	
	//통계표 정보 변경
	public Object updateStatsTbl(Params params) {
        return update("StatsMgmtDao.updateStatsTbl", params);
    }
	
	//통계표 옵션정보 입력
	public Object insertStatsOpt(Map<String, List<HashMap<String, String>>> pMap) {
        return insert("StatsMgmtDao.insertStatsOpt", pMap);
    }
	
	//통계표 옵션정보 삭제 
	public Object delStatsOpt(Params params) {
        return update("StatsMgmtDao.delStatsOpt", params);
    }
	
	//통계표 옵션정보 삭제 (항목 위치)
	public Object delStatsOptInSc(Params params) {
        return update("StatsMgmtDao.delStatsOptInSc", params);
    }
	
	//통계표 옵션정보 삭제 후 재 입력
	public Object mergeStatsOpt(Map<String, List<HashMap<String, String>>> pMap) {
        return merge("StatsMgmtDao.mergeStatsOpt", pMap);
    }
	
	//통계자료작성 일정 입력
	public Object insertStatsSchl(Map<String, List<HashMap<String, String>>> pMap) {
        return insert("StatsMgmtDao.insertStatsSchl", pMap);
    }
	
	//통계자료작성 일정 삭제
	public Object deleteStatsSchl(Params params) {
        return delete("StatsMgmtDao.deleteStatsSchl", params);
    }
	
	//통계표 관리담당자 입력
	public Object insertStatsUsr(Map<String, List<HashMap<String, String>>> pMap) {
        return insert("StatsMgmtDao.insertStatsUsr", pMap);
    }
	
	//통계표 관리담당자 삭제 
	public Object delStatsUsr(Params params) {
        return update("StatsMgmtDao.delStatsUsr", params);
    }
	
	//통계표 관리담당자 삭제 후 재 입력
	public Object mergeStatsUsr(Map<String, List<HashMap<String, String>>> pMap) {
        return merge("StatsMgmtDao.mergeStatsUsr", pMap);
    }
	
	//통계표 관리담당자 대표담당자 처리
	public Object updateStatsOwnerUsr(Map<String, String> usrMap) {
        return update("StatsMgmtDao.updateStatsOwnerUsr", usrMap);
    }
	
	//통계표 관리담당자 목록 조회
	public List<Record> selectStatsUsrList(Params params) {
		return (List<Record>) list("StatsMgmtDao.selectStatsUsrList", params);
    }
	
	//표준항목분류정보 계층 조회 
	public List<Map<String, Object>> selectStatsStddItmPopList(Params params) {
        return (List<Map<String, Object>>) list("StatsMgmtDao.selectStatsStddItmPopList", params);
    }
	
	//표준항목단위정보 팝업 조회
	public List<Map<String, Object>> selectStatsStddUiPopup(Params params) {
        return (List<Map<String, Object>>) list("StatsMgmtDao.selectStatsStddUiPopup", params);
    }
	
	//통계표 항목분류 리스트 조회
	public List<Map<String, Object>> statsTblItmList(Params params) {
		return (List<Map<String, Object>>) list("StatsMgmtDao.selectStatsTblItmList", params);
	}
	
	//통계표 항목분류 입력/수정
	public Object mergeStddTblItm(StatsStddTblItm vo) {
        return merge("StatsMgmtDao.mergeStddTblItm", vo);
    }
	
	//통계표 항목분류 삭제
	public Object delStddTblItm(Map<String, Object> pMap) {
        return update("StatsMgmtDao.delStddTblItm", pMap);
    }
	
	//출력항목명 FullNm 계층 업데이트
	public Object updateStddTblItmFullNm(Map<String, Object> pMap) {
        return update("StatsMgmtDao.updateStddTblItmFullNm", pMap);
    }
	
	//항목/분류 순서 저장
	public Object saveStddTblItmOrder(StatsStddTblItm itm) {
        return update("StatsMgmtDao.saveStddTblItmOrder", itm);
    }
	
	//통계표 백업
	public Object execSpBcupSttsTbl(Params params) {
		return execPrc("StatsMgmtDao.execSpBcupSttsTbl", params);
	}
	
	//통계자료작성대장 생성
	public Object execSpCreateSttsWrtlist(Params params) {
		return execPrc("StatsMgmtDao.execSpCreateSttsWrtlist", params);
	}
	
	//통계표 메인 순서저장
	public Object saveStatsMgmtOrder(Record record) {
		return update("StatsMgmtDao.saveStatsMgmtOrder", record);
	}
	
	//통계표 검색태그 입력
	public Object insertStatsTag(List<Record> tagList) {
        return insert("StatsMgmtDao.insertStatsTag", tagList);
    }
	
	//통계표 검색태그 삭제 
	public Object delStatsTag(Params params) {
        return delete("StatsMgmtDao.delStatsTag", params);
    }
	
	//통계표 공개상태를 공개/취소 한다
	public Object updateOpenState(Params params) {
        return update("StatsMgmtDao.updateOpenState", params);
    }
	
	// 통계분석자료 일괄생성
	public Object execSttsAnlsAll(Params params) {
		return execPrc("StatsMgmtDao.execSttsAnlsAll", params);
    }
	
	// 통계표 복사
	public Object execCopySttsTbl(Params params) {
		return execPrc("StatsMgmtDao.execCopySttsTbl", params);
    }
	
	// 통계표 분류 조회
	public List<Record> selectStatSttsTblCateList(Params params) {
		return (List<Record>) list("StatsMgmtDao.selectStatSttsTblCateList", params);
    }
	
	// 통계표 분류 제거
	public Object deleteStatTblCate(Params params) {
		return delete("StatsMgmtDao.deleteStatTblCate", params);
	}
	
	// 통계표 분류체계 데이터 사용여부 변경
	public Object updateStatTblCate(Params params) {
		return delete("StatsMgmtDao.updateStatTblCate", params);
	}
	
	// 통계표 분류 추가
	public Object insertStatTblCate(Record record) {
		return insert("StatsMgmtDao.insertStatTblCate", record);
	}
	
	// 연관 통계표 팝업 조회
	public List<Record> selectSttsTblPopList(Params params) {
		return (List<Record>) list("StatsMgmtDao.selectSttsTblPopList", params);
    }
	
	// 연관 통계표 리스트 조회
	public List<Record> selectSttsTblList(Params params) {
		return (List<Record>) list("StatsMgmtDao.selectSttsTblList", params);
    }
	
	// 연관 통계표 삭제 
	public Object delStatsTblRel(Params params) {
        return update("StatsMgmtDao.delStatsTblRel", params);
    }
	
	// 연관 통계표 삭제 후 재 입력
	public Object mergeStatsTblRel(Map<String, List<HashMap<String, String>>> pMap) {
        return merge("StatsMgmtDao.mergeStatsTblRel", pMap);
    }
	
	// 통계표 정보 항목/분류/그룹 설정 시 처리 작업
	// 통계표의 분류나 그룹 항목 설정 시 (추가나 삭제 ) 기존에 데이터가 있으면 쓰레기 데이터가 되므로 데이터를 정리한다.	 
	public Object execSpModSttsTblItm(Params params) {
		return execPrc("StatsMgmtDao.execSpModSttsTblItm", params);
	}
	
	/**
	 * 통계표 분류정보 관련 분류 조회
	 */
	public List<Record> selectStatsCateInfoList(Params params) {
		return (List<Record>) list("StatsMgmtDao.selectStatsCateInfoList", params);
	}

	public List<Record> selectStatCateInfoPop(Params params) {
		return (List<Record>) list("StatsMgmtDao.selectStatCateInfoPop", params);
	}
	
	/**
	 * 통계표 분류정보 관련 분류 삭제
	 */
	public Object deleteStatsCateInfo(Record record) {
		return delete("StatsMgmtDao.deleteStatsCateInfo", record);
	}
	
	/**
	 * 통계표 분류정보 관련 분류  등록/수정
	 */
	public Object mergeStatsCateInfo(Record record) {
		return delete("StatsMgmtDao.mergeStatsCateInfo", record);
	}
	
	/**
	 * 분류체계 대표여부 처리
	 */
	public Object updateMstStatsCateInfo(Params params) {
		return delete("StatsMgmtDao.updateMstStatsCateInfo", params);
	}
	
	//공통코드 값을 조회한다.
	public List<?> selectSysOption(Params params) {
		return search("StatsMgmtDao.selectSysOption", params);
	}

	public Paging selectStfStatsMgmtList(Params params, int page, int rows) {
		return search("StatsMgmtDao.selectStfStatsMgmtList", params, page, rows, PAGING_SCROLL);
	}

	public Object selectStfStatsMgmtDtl(Params params) {
		return select("StatsMgmtDao.selectStfStatsMgmtDtl", params);
	}
	public Object saveStfStatsMgmt(Params params) {
		return update("StatsMgmtDao.updateStfStatsMgmt", params);
		
	}
}
