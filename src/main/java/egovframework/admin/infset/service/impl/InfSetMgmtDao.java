package egovframework.admin.infset.service.impl;

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
 * 정보셋을 관리하는 DAO 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/07/29
 */

@Repository(value="infSetMgmtDao")
public class InfSetMgmtDao extends BaseDao {
	
	/**
	 * 메인 리스트 조회(페이징 처리)
	 */
	public Paging selectMainList(Params params, int page, int rows) {
        return search("infSetMgmtDao.selectMainList", params, page, rows, PAGING_SCROLL);
    }
	
	/**
	 * 상세 데이터 조회
	 */
	public Record selectDtl(Params params) {
		return (Record) select("infSetMgmtDao.selectDtl", params);
	}
	
	/**
	 * 정보셋 분류체계 팝업 조회
	 */
	public List<Record> selectInfSetCatePop(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectInfSetCatePop", params);
	}
	
	/**
	 * 정보셋 신규 시퀀스를 조회
	 */
	public int getSqInfoInfsSeq() {
		return (Integer) selectByPk("infSetMgmtDao.getSqInfoInfsSeq", null);
	}
	
	/**
	 * 정보셋 신규 정보ID 조회
	 */
	public String getInfsId(Params params) {
		return (String) selectByPk("infSetMgmtDao.getInfsId", params);
	}
	
	/**
	 * 정보셋 마스터정보 데이터 등록 
	 */
	public Object insertInfoSetMst(Params params) {
		return insert("infSetMgmtDao.insertInfoSetMst", params);
	}
	
	/**
	 * 정보셋 마스터정보 대표여부 데이터 수정(등록 후 처리됨)
	 */
	public Object updateInfoSetMstRpst(Params params) {
		return update("infSetMgmtDao.updateInfoSetMstRpst", params);
	}

	/**
	 * 정보셋 마스터정보 데이터 수정 
	 */
	public Object updateInfoSetMst(Params params) {
		return update("infSetMgmtDao.updateInfoSetMst", params);
	}
	
	/**
	 * 정보셋 데이터 삭제 
	 */
	public Object execSpBcupInfoSet(Params params) {
		return execPrc("infSetMgmtDao.execSpBcupInfoSet", params);
	}
	
	/**
	 * 정보셋 관리 관련 분류 조회
	 */
	public List<Record> selectInfoSetCate(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectInfoSetCate", params);
	}
	/**
	 * 정보셋 관리 관련 분류 등록/수정
	 */
	public Object mergeInfoSetCate(Record record) {
		return update("infSetMgmtDao.mergeInfoSetCate", record);
	}
	/**
	 * 정보셋 관리 관련 분류 삭제
	 */
	public Object deleteInfoSetCate(Record record) {
		return delete("infSetMgmtDao.deleteInfoSetCate", record);
	}
	
	/**
	 * 정보셋 관리 관련 유저 조회
	 */
	public List<Record> selectInfoSetUsr(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectInfoSetUsr", params);
	}
	/**
	 * 정보셋 관리 관련 유저 등록/수정
	 */
	public Object mergeInfoSetUsr(Record record) {
		return update("infSetMgmtDao.mergeInfoSetUsr", record);
	}
	/**
	 * 정보셋 관리 관련 유저 삭제
	 */
	public Object deleteInfoSetUsr(Record record) {
		return delete("infSetMgmtDao.deleteInfoSetUsr", record);
	}
	
	/**
	 * 문서 목록 리스트 조회(팝업)
	 */
	public List<Record> selectDocListPop(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectDocListPop", params);
	}
	
	/**
	 * 공공데이터 목록 리스트 조회(팝업)
	 */
	public List<Record> selectOpenListPop(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectOpenListPop", params);
	}
	
	/**
	 * 통계 목록 리스트 조회(팝업)
	 */
	public List<Record> selectStatListPop(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectStatListPop", params);
	}
	
	/**
	 * 정보셋 관리 관련 데이터 등록/수정
	 */
	public Object mergeInfoSetRel(Record record) {
		return update("infSetMgmtDao.mergeInfoSetRel", record);
	}
	/**
	 * 정보셋 관리 관련 데이터 삭제
	 */
	public Object deleteInfoSetRel(Record record) {
		return delete("infSetMgmtDao.deleteInfoSetRel", record);
	}
	
	/**
	 * 정보셋 관리 관련 문서데이터 조회
	 */
	public List<Record> selectInfoSetRelDoc(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectInfoSetRelDoc", params);
	}
	
	/**
	 * 정보셋 관리 관련 공공데이터 조회
	 */
	public List<Record> selectInfoSetRelOpen(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectInfoSetRelOpen", params);
	}
	
	/**
	 * 정보셋 관리 관련 통계데이터 조회
	 */
	public List<Record> selectInfoSetRelStat(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectInfoSetRelStat", params);
	}
	
	/**
	 * 정보셋 관리 관련 데이터 저장시 마스터 테이블에 문서, 공공, 통계 갯수 수정
	 */
	public Object updateInfoSetMstRelCnt(Params params) {
		return update("infSetMgmtDao.updateInfoSetMstRelCnt", params);
	}
	
	/**
	 * 정보셋 관리 공개/공개취소 처리
	 */
	public Object updateInfSetOpenState(Params params) {
		return update("infSetMgmtDao.updateInfSetOpenState", params);
	}
	
	/**
	 * 정보셋 관리 태그 삭제
	 */
	public Object deleteInfSetTag(Params params) {
		return delete("infSetMgmtDao.deleteInfSetTag", params);
	}
	
	/**
	 * 정보셋 관리 태그 등록
	 */
	public Object insertInfSetTag(Record record) {
		return insert("infSetMgmtDao.insertInfSetTag", record);
	}
	
	/**
	 * 정보셋 관리 설명 조회
	 */
	public List<Record> selectInfSetExp(Params params) {
		return (List<Record>) list("infSetMgmtDao.selectInfSetExp", params);
	}
	
	/**
	 * 정보셋 관리 설명 데이터 등록
	 */
	public Object insertInfSetExp(Params params) {
		return insert("infSetMgmtDao.insertInfSetExp", params);
	}
	
	/**
	 * 정보셋 관리 설명 데이터 수정
	 */
	public Object updateInfSetExp(Params params) {
		return update("infSetMgmtDao.updateInfSetExp", params);
	}
	
	/**
	 * 정보셋 관리 설명 데이터 삭제
	 */
	public Object deleteInfSetExp(Params params) {
		return delete("infSetMgmtDao.deleteInfSetExp", params);
	}
	
	/**
	 * 정보셋 관리 설명 시트 순서 저장
	 */
	public Object saveInfSetExpOrder(Params params) {
		return update("infSetMgmtDao.saveInfSetExpOrder", params);
	}
	
}
