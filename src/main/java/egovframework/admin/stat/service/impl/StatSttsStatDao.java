package egovframework.admin.stat.service.impl;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 통계메타를 관리하는 DAO 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/08/07
 */

@Repository(value="statSttsStatDao")
public class StatSttsStatDao extends BaseDao {

	/**
	 * 통계 메타 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatSttsStat(Params params) {
		return list("StatSttsStatDao.selectStatSttsStat", params); 
	}
	
	/**
	 * 통계 메타 관리 입력
	 * @param params
	 * @return
	 */
	public Object insertStatSttsStat(Params params) {
        return insert("StatSttsStatDao.insertStatSttsStat", params);
    }
	
	/**
	 * 통계설명 메타정보 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatSttsStddMeta(Params params) {
		return list("StatSttsStatDao.selectStatSttsStddMeta", params);
	}
	
	/**
	 * 통계 메타 관리 상세
	 * @param params
	 * @return
	 */
	public Object selectStatSttsStatDtl(Params params) {
		return select("StatSttsStatDao.selectStatSttsStatDtl", params); 
	}
	
	/**
	 * 통계설명정보 저장
	 * @param list
	 * @return
	 */
	public Object saveSttsStat(Params params) {
        return update("StatSttsStatDao.saveSttsStat", params);
    }
	
	/**
	 * 통계설명 메타정보 저장
	 * @param list
	 * @return
	 */
	public Object saveSttsStatMeta(LinkedList<Record> list) {
        return update("StatSttsStatDao.saveSttsStatMeta", list);
    }
	
	
	/**
	 * 통계설명 관리 담당자 삭제
	 * @param params
	 * @return
	 */
	public Object delSttsStatUsr(Params params) {
        return update("StatSttsStatDao.delSttsStatUsr", params);
    }
	
	/**
	 * 통계설명 관리담당자 삭제 후 재 입력
	 * @param pMap
	 * @return
	 */
	public Object mergeSttsStatUsr(Map<String, LinkedList<Record>> pMap) {
        return merge("StatSttsStatDao.mergeSttsStatUsr", pMap);
    }
	
	/**
	 * 통계설명 관리담당자 대표담당자 처리
	 * @param usrMap
	 * @return
	 */
	public Object updateSttsStatOwner(Record usrMap) {
        return update("StatSttsStatDao.updateSttsStatOwner", usrMap);
    }
	
	/**
	 * 통계설명 관리담당자 목록 조회
	 * @param params
	 * @return
	 */
	public List<?> selectSttsStatUsrList(Params params) {
		return list("StatSttsStatDao.selectSttsStatUsrList", params);
    }
	
	/**
	 * 통계 설명 메타정보 메타입력 유형코드 조회(실 데이터 확인 후) 
	 * @param params
	 * @return
	 */
	public List<?> selectStatSttsStatExistMetaCd(Params params) {
		return list("StatSttsStatDao.selectStatSttsStatExistMetaCd", params);
    }
	
	/**
	 * 통계설명 정보 삭제
	 * @param params
	 * @return
	 */
	public Object deleteSttsStat(Params params) {
        return delete("StatSttsStatDao.deleteSttsStat", params);
    }
	
	/**
	 * 통계설명 메타정보 삭제
	 * @param params
	 * @return
	 */
	public Object deleteSttsStatMeta(Params params) {
        return delete("StatSttsStatDao.deleteSttsStatMeta", params);
    }
	
	/**
	 * 통계설명 관리 담당자 삭제
	 * @param params
	 * @return
	 */
	public Object deleteSttsStatUsr(Params params) {
        return delete("StatSttsStatDao.deleteSttsStatUsr", params);
    }
	
	/**
	 * 통계메타 순서 저장
	 * @param params
	 * @return
	 */
	public Object updateSttsStatMetaVorder(Record record) {
		return update("StatSttsStatDao.updateSttsStatMetaVorder", record);
	}
	
	/**
	 * 통계메타 정보 백업
	 * @param params
	 * @return
	 */
	public Object execSpBcupSttsStat(Params params) {
		return execPrc("StatSttsStatDao.execSpBcupSttsStat", params);
	}
	
	/**
	 * 통계설명 ID를 사용하는 공개된 통계표 갯수 확인
	 * @param params
	 * @return
	 */
	public Object selectStatSttsOpenStateTblCnt(Params params) {
		return select("StatSttsStatDao.selectStatSttsOpenStateTblCnt", params); 
	}
	
}
