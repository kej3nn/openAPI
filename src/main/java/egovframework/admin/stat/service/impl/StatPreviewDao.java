package egovframework.admin.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="statPreviewDao")
public class StatPreviewDao extends BaseDao {

	public Map<String, String> selectStatTblOptLocation(Params params) {
		return (Map<String, String>) select("StatPreviewDao.selectStatTblOptLocation", params);
	}
	
	public List<Map<String, Object>> selectStatTblTS(Params params) {
		return (List<Map<String, Object>>) list("StatPreviewDao.selectStatTblTS", params);
	}
	
	/**
	 * 자료시점 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatWrtTimeOption(Params params) {
		return search("StatPreviewDao.selectStatWrtTimeOption", params);
	}
	
	/**
	 * 통계표 단위 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblUi(Params params) {
		return list("StatPreviewDao.selectStatTblUi", params);
    }
	
	/**
	 * 통계표 통계자료유형 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblDtadvs(Params params) {
		return list("StatPreviewDao.selectStatTblDtadvs", params);
    }
	
	/**
	 * 시트 표두/표측 정보 조회
	 * @param params
	 * @return
	 */
	public List<Record> selectStatTblItm(Params params) {
		return (List<Record>) list("StatPreviewDao.selectStatTblItm", params);
    }
	
	/**
	 * 시트 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Record> selectStatSheetData(Params params) {
		return (List<Record>) list("StatPreviewDao.selectStatSheetData", params);
    }
	
	/**
	 * 통계표 옵션 값 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblOptVal(Params params) {
		return list("StatPreviewDao.selectStatTblOptVal", params);
    }
	
	/**
	 * 통계표 항목분류 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblItmJson(Params params) {
		return list("StatPreviewDao.selectStatTblItmJson", params);
    }
	
	/**
	 * 통계표 주석 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatCmmtList(Params params) {
		return list("StatPreviewDao.selectStatCmmtList", params);
	}
	
	/**
	 * 통계설명 팝업 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatSttsStatMetaList(Params params) {
		return list("StatPreviewDao.selectStatSttsStatMetaList", params);
	}
	
	/**
	 * 통계표 정보 상세조회(단건)
	 * @param params
	 * @return
	 */
	public Record selectStatSttsTblDtl(Params params) {
		return (Record) select("StatPreviewDao.selectStatSttsTblDtl", params);
	}
	
	/**
	 * 연관된 통계표 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatSttsTblReferenceStatId(Params params) {
		return list("StatPreviewDao.selectStatSttsTblReferenceStatId", params);
	}
	
	/**
	 * 통계메타 파일 조회(단건
	 * @param params
	 * @return
	 */
	public Record selectDownloadStatMetaFile(Params params) {
		return (Record) select("StatPreviewDao.selectDownloadStatMetaFile", params);
	}
	
	/**
	 * 통계표 관리에 선택된 작성주기만 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatCheckedDtacycleList(Params params) {
		return list("StatPreviewDao.selectStatCheckedDtacycleList", params);
	}

}
