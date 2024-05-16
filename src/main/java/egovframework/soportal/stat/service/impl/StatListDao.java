package egovframework.soportal.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 통계표를 관리하는 DAO 클래스
 * @author	소프트온
 * @version 1.0
 * @since   2017/09/22
 */

@Repository(value="statListDao")
public class StatListDao extends BaseDao {

	//공통코드 값을 조회한다.
	public List<?> selectOption(Params params) throws DataAccessException, Exception{
		return search("statListDao.selectOption", params);
	}
	
	//통계 공통코드 값을 조회한다.
	public List<?> selectSTTSOption(Params params) throws DataAccessException, Exception {
		return search("statListDao.selectSTTSOption", params);
	}

	/**
	 * 통계표 단위 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblUi(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectStatTblUi", params);
    }

	/**
	 * 통계표 통계자료유형 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblDtadvs(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectStatTblDtadvs", params);
    }
	
	/**
	 * 통계표 등록/수정 메인 리스트 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Record> statEasyList(Params params) throws DataAccessException, Exception {
		return (List<Record>) list("statListDao.statEasyList", params);
    }

	/**
	 * 통계표 인기통계 리스트 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> statHitList(Params params) throws DataAccessException, Exception {
		return (List<Map<String, Object>>) list("statListDao.statHitList", params);
    }
	
	/**
	 * 통계표 최신통계 리스트 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Record> statNewList(Params params) throws DataAccessException, Exception {
		return (List<Record>) list("statListDao.statNewList", params);
    }
	
	/**
	 * 메인 모바일 리스트 조회
	 * @return
	 */
	public Paging statEasyMobileList(Params params, int page, int rows) throws DataAccessException, Exception {
		return search("statListDao.statEasyMobileList", params, page, rows, PAGING_MANUAL);
    }
	
	/**
	 * 메인 검색결과 리스트 조회
	 */
	public List<Record> statEasySearchList(Params params) throws DataAccessException, Exception {
		return (List<Record>) list("statListDao.statEasyMobileList", params);
    }

	//통계표 상세조회
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectStatDtl(Params params) throws DataAccessException, Exception {
		return (Map<String, Object>) select("statListDao.selectStatDtl", params);
    }
	
	//통계표 메타 조회
	@SuppressWarnings("unchecked")
	public List<Record> selectStatSttsMeta(Params params) throws DataAccessException, Exception {
		return (List<Record>) list("statListDao.selectStatSttsMeta", params);
    }

	//통계표 옵션정보 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectStatDtlOpt(Params params) throws DataAccessException, Exception {
		return (List<Map<String, Object>>) list("statListDao.selectStatDtlOpt", params);
    }
	
	//통계자료 작성일정 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectStatDtlSchl(Params params) throws DataAccessException, Exception {
		return (List<Map<String, Object>>) list("statListDao.selectStatDtlSchl", params);
    }

	//통계표 항목/분류를 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectStatsItmList(Params params) throws DataAccessException, Exception {
		return (List<Map<String, Object>>) list("statListDao.selectStatsItmList", params);
    }
	
	//통계표 검색주기 조회
	public List<?> statDtacycleList(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectStatDtacycleList", params);
    }
	
	/**
	 * 통계표 항목분류 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> statItmJson(Params params) throws DataAccessException, Exception {
		return list("statListDao.statItmJson", params);
    }
	
	/**
	 * 통계표 옵션 값 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblOptVal(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectStatTblOptVal", params);
    }
	
	/**
	 * 시트 표두/표측 정보 조회
	 * @param params
	 * @return
	 */
	public List<Record> selectStatTblItm(Params params) throws DataAccessException, Exception {
		return (List<Record>) list("statListDao.selectStatTblItm", params);
    }
	
	public Map<String, String> selectStatTblOptLocation(Params params) throws DataAccessException, Exception {
		return (Map<String, String>) select("statListDao.selectStatTblOptLocation", params);
	}
	
	/**
	 * 통계 데이터셋 연계정보 조회
	 */
	public Map<String, Object> selectStatInputDscn(Params params) throws DataAccessException, Exception {
		return (Map<String, Object>) select("statListDao.selectStatInputDscn", params);
    }

	/**
	 * 시트 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Record> selectStatSheetData(Params params) throws DataAccessException, Exception{
		return (List<Record>) list("statListDao.selectStatSheetData", params);
    }

	/**
	 * 자료시점 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatWrtTimeOption(Params params) throws DataAccessException, Exception {
		return search("statListDao.selectStatWrtTimeOption", params);
	}

	/**
	 * 자료시점 조회[월/분기 시작년월/분기 및 종료년월/분기]
	 * @param params
	 * @return
	 */
	public List<?> selectStatQrtTimeOption(Params params) throws DataAccessException, Exception {
		return search("statListDao.selectStatQrtTimeOption", params);
	}
	
	/**
	 * 통계표 주석 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatCmmtList(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectStatCmmtList", params);
	}
	
	/**
	 * 통계 스크랩 마스터 정보 조회
	 */
	public Record selectStatUserTbl(Params params) throws DataAccessException, Exception {
		return (Record) select("statListDao.selectStatUserTbl", params);
	}
	
	/**
	 * 통계 스크랩 항목, 분류 정보 조회
	 */
	public List<?> selectStatUserTblItm(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectStatUserTblItm", params);
	}
	
	/**
	 * 통계스크랩 마스터 정보 등록
	 */
	public Object insertStatUserTbl(Params params) throws DataAccessException, Exception {
		return insert("statListDao.insertStatUserTbl", params);
	}
	
	/**
	 * 통계스크랩 마스터 정보 수정
	 */
	public Object updateStatUserTbl(Params params) throws DataAccessException, Exception {
		return update("statListDao.updateStatUserTbl", params);
	}

	/**
	 * 통계스크랩 항목, 분류 정보 등록
	 */
	public Object insertStatUserTblItm(Params params) throws DataAccessException, Exception {
		return insert("statListDao.insertStatUserTblItm", params);
	}
	
	/**
	 * 통계스크랩 항목, 분류 정보 삭제
	 */
	public Object deleteStatUserTblItm(Params params) throws DataAccessException, Exception {
		return delete("statListDao.deleteStatUserTblItm", params);
	}
	
	/**
	 * 통계스크랩 조회데이터 기준 시작, 종료 시점을 가져온다.
	 */
	public Record selectStatUserTblFirEndWrttime(Params params) throws DataAccessException, Exception {
		return (Record) select("statListDao.selectStatUserTblFirEndWrttime", params);
	}
	
	/**
	 * 통계표 변환저장 로그기록(포털 파일 다운로드시 로그)
	 */
	public Object insertLogSttsTblSave(Params params) throws DataAccessException, Exception {
		return insert("statListDao.insertLogSttsTblSave", params);
	}
	
	/**
	 * 메타데이터 확인 로그
	 */
	public Object insertLogSttsStat(Params params) throws DataAccessException, Exception {
		return insert("statListDao.insertLogSttsStat", params);
	}
	
	/**
	 * 통계표 열람 로그
	 */
	public Object insertLogSttsTbl(Params params) throws DataAccessException, Exception {
		return insert("statListDao.insertLogSttsTbl", params);
	}
	
	/**
	 * 통계주제 최상위 레벨
	 */
	public List<?> statCateTopList(Params params) throws DataAccessException, Exception {
		return list("statListDao.statCateTopList", params);
    }
	
	/**
	 * 통계표이력 검색주기 조회 
	 */
	public List<?> statHistDtacycleList(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectStatHistDtacycleList", params);
    }
	
	/**
	 * 통계표 이력 주기 리스트 조회
	 */
	public List<?> selectStatHisSttsCycleList(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectStatHisSttsCycleList", params);
    }
	
	/**
	 * 통계표 이력 시트 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Record> selectStatHistSheetData(Params params) throws DataAccessException, Exception{
		return (List<Record>) list("statListDao.selectStatHistSheetData", params);
    }

	/**
	 * 시계열(자료시점) 주석 식별자
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public String selectCmmtIdtfr(Params params) throws DataAccessException, Exception {
		return (String) select("statListDao.selectCmmtIdtfr", params);
	}
	
	/**
	 * 통계 연결 게시판 자료 데이터 호출
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public List<?> selectContentsList(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectContentsList", params);
    }

	/**
	 * 통계설명 자료 데이터 호출(파일다운로드 목록)
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public Paging selectContentsFileList(Params params, int page, int rows) throws DataAccessException, Exception {
		return search("statListDao.selectContentsFileList", params, page, rows, PAGING_MANUAL);
    }

	/**
	 * 통계컨텐츠 목록 호출
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public List<?> selectContentsBbsList(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectContentsBbsListData", params);
    }
	
    /**
     * 통계컨텐츠 목록 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging selectContentsBbsListData(Params params, int page, int rows) throws DataAccessException, Exception {
        return search("statListDao.selectContentsBbsListData", params, page, rows, PAGING_MANUAL, true);
    }
    
	/**
	 * 통계컨텐츠 정보 호출(다음/이전)
	 * @param params
	 * @return
	 */
	public List<?> selectContentsBbsNaverData(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectContentsBbsNaverData", params);
    }
	
	/**
	 * 통계 컨턴츠 상세분석 
	 * @param params
	 * @return
	 */
	public List<?> selectDtlAnalysisList(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectDtlAnalysisList", params);
    }

	/**
	 * 통계 연결 게시판 자료 조회수 수정
	 */
	public Object updateContentsBbsDataHit(Params params) throws DataAccessException, Exception {
		return update("statListDao.updateContentsBbsDataHit", params);
	}
	
	/**
	 * 통계 컨텐츠 링크 데이터 조회
	 * @param params
	 * @return
	 */
	public List<?> selectContentsLinkData(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectContentsLinkData", params);
    }
	
	/**
	 * 통계 컨텐츠 파일 조회
	 * @param params
	 * @return
	 */
	public List<?> selectContentsFileData(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectContentsFileData", params);
    }
	
	/**
	 * 통계 컨텐츠 용어설명
	 * @param params
	 * @return
	 */
	public List<?> selectContentsDicData(Params params) throws DataAccessException, Exception {
		return list("statListDao.selectContentsDicData", params);
    }

	/**
	 * 통계표 카테고리를 검색한다(최상위, 부모, 자기자신)
	 */
	public Record selectSttsCateInfo(String statblId) throws DataAccessException, Exception {
		return (Record) select("statListDao.selectSttsCateInfo", statblId);
	}
	
	public Record selectSttsMeta(Params params) throws DataAccessException, Exception {
		return (Record) select("statListDao.selectSttsMeta", params);
	}
	
	/**
	 * 평가점수 등록
	 */
	public Object insertSttsTblAppr(Params params) {
		return insert("statListDao.insertSttsTblAppr", params);
	}
	
	/**
	 * 평가점수 조회
	 */
	public Record selectSttsTblAppr(Params params) {
		return (Record) select("statListDao.selectSttsTblAppr", params);
	}
}
