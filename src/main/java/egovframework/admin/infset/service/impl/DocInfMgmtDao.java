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
 * 정보공개 문서를 관리하는 DAO 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/05
 */

@Repository(value="docInfMgmtDao")
public class DocInfMgmtDao extends BaseDao {
	
	/**
	 * 메인 리스트 조회(페이징 처리)
	 */
	public Paging selectMainList(Params params, int page, int rows) {
        return search("docInfMgmtDao.selectMainList", params, page, rows, PAGING_SCROLL);
    }
	
	/**
	 * 상세 데이터 조회
	 */
	public Record selectDtl(Params params) {
		return (Record) select("docInfMgmtDao.selectDtl", params);
	}
	
	/**
	 * 정보공개 문서관리 분류체계 팝업 조회
	 */
	public List<Record> selectDocInfCatePop(Params params) {
		return (List<Record>) list("docInfMgmtDao.selectDocInfCatePop", params);
	}
	
	/**
	 * 정보공개 문서관리 신규 시퀀스를 조회
	 */
	public int getSqDocInfSeq() {
		return (Integer) selectByPk("docInfMgmtDao.getSqDocInfSeq", null);
	}
	
	/**
	 * 정보공개 문서관리 신규 정보ID 조회
	 */
	public String getDocId(Params params) {
		return (String) selectByPk("docInfMgmtDao.getDocId", params);
	}
	
	/**
	 * 정보공개 문서관리 마스터정보 데이터 등록 
	 */
	public Object insertDocInfMst(Params params) {
		return insert("docInfMgmtDao.insertDocInfMst", params);
	}
	
	/**
	 * 정보공개 문서관리 마스터정보 대표여부 데이터 수정(등록 후 처리됨)
	 */
	public Object updateDocInfMstRpst(Params params) {
		return update("docInfMgmtDao.updateDocInfMstRpst", params);
	}

	/**
	 * 정보공개 문서관리 마스터정보 데이터 수정 
	 */
	public Object updateDocInfMst(Params params) {
		return update("docInfMgmtDao.updateDocInfMst", params);
	}
	
	/**
	 * 문서관리 데이터 삭제 
	 */
	public Object execSpBcupDocInf(Params params) {
		return execPrc("docInfMgmtDao.execSpBcupDocInf", params);
	}
	
	/**
	 * 정보공개 문서관리 관련 분류 조회
	 */
	public List<Record> selectDocInfCate(Params params) {
		return (List<Record>) list("docInfMgmtDao.selectDocInfCate", params);
	}
	/**
	 * 정보공개 문서관리 관련 분류 등록/수정
	 */
	public Object mergeDocInfCate(Record record) {
		return update("docInfMgmtDao.mergeDocInfCate", record);
	}
	/**
	 * 정보공개 문서관리 관련 분류 삭제
	 */
	public Object deleteDocInfCate(Record record) {
		return delete("docInfMgmtDao.deleteDocInfCate", record);
	}
	
	/**
	 * 정보공개 문서관리 관련 유저 조회
	 */
	public List<Record> selectDocInfUsr(Params params) {
		return (List<Record>) list("docInfMgmtDao.selectDocInfUsr", params);
	}
	/**
	 * 정보공개 문서관리 관련 유저 등록/수정
	 */
	public Object mergeDocInfUsr(Record record) {
		return update("docInfMgmtDao.mergeDocInfUsr", record);
	}
	/**
	 * 정보공개 문서관리 관련 유저 삭제
	 */
	public Object deleteDocInfUsr(Record record) {
		return delete("docInfMgmtDao.deleteDocInfUsr", record);
	}
	
	/**
	 * 정보셋 관리 관련 데이터 저장시 마스터 테이블에 문서, 공공, 통계 갯수 수정
	 */
	/*public Object updateDocInfMstRelCnt(Params params) {
		return update("docInfMgmtDao.updateDocInfMstRelCnt", params);
	}*/
	
	/**
	 * 정보공개 문서관리 공개/공개취소 처리
	 */
	public Object updateDocInfOpenState(Params params) {
		return update("docInfMgmtDao.updateDocInfOpenState", params);
	}
	
	/**
	 * 정보공개 문서관리 태그 삭제
	 */
	public Object deleteDocInfTag(Params params) {
		return delete("docInfMgmtDao.deleteDocInfTag", params);
	}
	
	/**
	 * 정보공개 문서관리 태그 등록
	 */
	public Object insertDocInfTag(Record record) {
		return insert("docInfMgmtDao.insertDocInfTag", record);
	}
	
	/**
	 * 정보공개 문서 파일을 조회한다. 
	 */
	public List<Record> selectDocInfFile(Params params) {
		return (List<Record>) list("docInfMgmtDao.selectDocInfFile", params);
	}
	
	/**
	 * 정보공개 문서 파일을 등록한다. 
	 */
	public Object insertDocInfFile(Params params) {
		return insert("docInfMgmtDao.insertDocInfFile", params);
	}
	
	/**
	 * 정보공개 문서 파일을 수정한다. 
	 */
	public Object updateDocInfFile(Params params) {
		return insert("docInfMgmtDao.updateDocInfFile", params);
	}
	
	/**
	 * 정보공개 문서 파일을 삭제한다. 
	 */
	public Object deleteDocInfFile(Params params) {
		return delete("docInfMgmtDao.deleteDocInfFile", params);
	}
	
	/**
	 * 문서공개 원본 파일 고유번호를 조회한다.
	 */
	public List<Record> selectDocInfFileSrcFileSeq(Params params) {
		return (List<Record>) list("docInfMgmtDao.selectDocInfFileSrcFileSeq", params);
	}
	
	/**
	 * 문서공개 첨부파일 순서를 저장한다.
	 */
	public Object saveDocInfFileOrder(Params params) {
		return update("docInfMgmtDao.saveDocInfFileOrder", params);
	}
}
