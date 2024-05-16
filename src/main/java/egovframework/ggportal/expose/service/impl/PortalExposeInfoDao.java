/*
 * @(#)PortalExposeInfoDao.java 1.0 2019/07/19
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.expose.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

/**
 * 정보공개 요청을 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("portalExposeInfoDao")
public class PortalExposeInfoDao extends BaseDao {
    /**
     * 정보공개 청구대상기관 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectNaboOrg(Params params) {
        return search("PortalExposeInfoDao.getOpnInstCodeList", params);
    }
    
    /**
     * 정보공개 코드 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectComCode(Params params) {
        return search("PortalExposeInfoDao.getOpnCommonCodeList", params);
    }    

	/**
	 * 정보공개 청구서 > 신청번호 조회한다.(입력시 사용)
	 */
	public String selectNextAplNo() {
		return (String) select("PortalExposeInfoDao.selectNextAplNo");
	}
	
	/**
	 * 정보공개 청구서 등록/수정
	 */
	public int saveAccount(Params params) {
		return merge("PortalExposeInfoDao.saveAccount", params);
	}
	
    /**
     * 정보공개 청구서처리현황 내용을 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging searchAccount(Params params, int page, int rows) {
        return search("PortalExposeInfoDao.searchAccount", params, page, rows, PAGING_MANUAL);
    }	
    
	/**
	 * 정보공개 청구서작성 내용을 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getInfoOpenApplyDetail(Params params) {
		return (Map<String, Object>) select("PortalExposeInfoDao.getInfoOpenApplyDetail", params);
    }

	/**
	 * 정보공개 청구를 취하한다. TB_OPNZ_APL 업데이트
	 */
	public int updateOpnApplyCancle(Params params) {
		
		
		
		return update("PortalExposeInfoDao.updateOpnApplyCancle", params);
	}
	
	/**
	 * 정보공개 청구를 취하한다. TB_OPNZ_RCP 업데이트
	 */
	public int updateOpnRcpCancle(Params params) {
		return update("PortalExposeInfoDao.updateOpnRcpCancle", params);
	}
	
	/**
	 * 정보공개 청구서 처리 이력을 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public List<?> getInfoOpenApplyHist(Params params) {
		return search("PortalExposeInfoDao.getInfoOpenApplyHist", params);
    }
	
	/**
	 * 정보공개 이력 정보 등록
	 */
	public Object insertOpnHist(Params params) {
		return insert("PortalExposeInfoDao.insertOpnHist", params);
	}
	
    /**
     * 정보공개 이의신청서 대상을 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging targetObjection(Params params, int page, int rows) {
        return search("PortalExposeInfoDao.targetObjection", params, page, rows, PAGING_MANUAL);
    }
    
	/**
	 * 정보공개 이의신청서 작성 내용을 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getWriteBaseInfo(Params params) {
		return (Map<String, Object>) select("PortalExposeInfoDao.getWriteBaseInfo", params);
    }
	
	/**
	 * 정보공개 이의신청서 수정 내용을 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getUpdateBaseInfo(Params params) {
		return (Map<String, Object>) select("PortalExposeInfoDao.getUpdateBaseInfo", params);
    }
	
	/**
	 * 정보공개 이의신청서 등록한다.
	 */
	public Object insertObjection(Params params) {
		return insert("PortalExposeInfoDao.insertObjection", params);
	}
	
	/**
	 * 정보공개 이의신청서 이력을 등록한다.
	 */
	public Object objectionHist(Params params) {
		return insert("PortalExposeInfoDao.objectionHist", params);
	}

	/**
	 * 정보공개 이의신청서 수정한다.
	 */
	public int updateObjection(Params params) {
		return update("PortalExposeInfoDao.updateObjection", params);
	}
	
	/**
	 * 정보공개 이의신청서 파일을 삭제한다.
	 */
	public int deleteObjectionFiles(Params params) {
		return update("PortalExposeInfoDao.deleteObjectionFiles", params);
	}
	
    /**
     * 정보공개 이의신청서 처리현황을 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging searchObjection(Params params, int page, int rows) {
        return search("PortalExposeInfoDao.searchObjection", params, page, rows, PAGING_MANUAL);
    }
    
	/**
	 * 정보공개 이의신청서 이의취하한다.
	 */
	public int withdrawObjection(Params params) {
		return update("PortalExposeInfoDao.withdrawObjection", params);
	}
	
	/**
	 * 정보공개 이의신청서 작성 내용을 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getOpnObjtnDetail(Params params) {
		return (Map<String, Object>) select("PortalExposeInfoDao.getOpnObjtnDetail", params);
    }

	/**
	 * 정보공개 이의신청서 처리 이력을 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public List<?> getObjtnHist(Params params) {
		return search("PortalExposeInfoDao.getObjtnHist", params);
    }
	
	/**
	 * 기관 정보 조회
	 */
	public List<?> getOpnzInstInfo(String inst_cd) {
		return search("PortalExposeInfoDao.getOpnzInstInfo", inst_cd);
	}

	/**
	 * 기관 담당자 정보
	 */
	public List<?> getOpnUsrRelInfo(String inst_cd) {
		return search("PortalExposeInfoDao.getOpnUsrRelInfo", inst_cd);
	}
	
	/**
	 * SMS 기관명
	 */
	public String getInstNm(String instCd) {
		return (String) select("PortalExposeInfoDao.getInstNm", instCd);
	}

	/**
	 * SMS발송시 청구제목 가져옴
	 */
	public String getAplModSJ(String apl_no) {
		return (String) select("PortalExposeInfoDao.getAplModSJ", apl_no);
	}
	
	/**
	 * SMS발송정보를 등록한다.
	 */
	public Object insertSMSRow(Params params) {
		return insert("PortalExposeInfoDao.insertSMSRow", params);
	}
	
	/**
	 * 청구 기본정보(사용자정보) 입력
	 */
	public int updateExposeDefaultInfo(Params params) {
		return update("PortalExposeInfoDao.updateExposeDefaultInfo", params);
	}
	
	/**
	 * 로그인 사용자정보를 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLoginUserInfo(Params params) {
		return (Map<String, Object>) select("PortalExposeInfoDao.selectLoginUserInfo", params);
    }
	
	/**
	 * 이송중인 청구건이 있는지 체크(결과:존재하는 숫자)
	 * @param params
	 * @return
	 */
	public int selectOpnzAplTransCnt(Params params) {
		return (Integer) select("PortalExposeInfoDao.selectOpnzAplTransCnt", params);
	}
	
	/**
	 * 작성된 청구서 변경시 본인여부와 현재상태 조회
	 */
	public String selectOpnzUsrAccChkStatus(Params params) {
		return (String) select("PortalExposeInfoDao.selectOpnzUsrAccChkStatus", params);
	}

	/**
	 * 작성된 이의신청서 변경시 본인여부와 현재상태 조회
	 */
	public String selectOpnzUsrObjChkStatus(Params params) {
		return (String) select("PortalExposeInfoDao.selectOpnzUsrObjChkStatus", params);
	}

	/**
	 * 이의신청 대상 항목을 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public List<?> selectOpnDcsClsd(Params params) {
		return search("PortalExposeInfoDao.selectOpnDcsClsd", params);
    }

	/**
	 * 이의신청 대상 선택 항목을 조회한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public List<?> selectOpnDcsChkClsd(Params params) {
		return search("PortalExposeInfoDao.selectOpnDcsChkClsd", params);
    }
	
    /**
     * 이의신청 다음순번 확인
     * @param params
     * @return
     */
	public String getInfoOpenObjtnSnoNext(Params params){
		String count = (String)getSqlMapClientTemplate().queryForObject("PortalExposeInfoDao.getInfoOpenObjtnSnoNext", params);
		return count;
	}
	
    /**
     * 결정통보 비공개내용 및 사유 > 이의신청사유 등록
     * @param params
     * @return
     */
    public void updateOpnDcsClsd(Params params) {
    	insert("PortalExposeInfoDao.updateOpnDcsClsd", params);
    }

    /**
     * 결정통보 비공개내용 및 사유 > 이의신청사유 내용 지우기
     * @param params
     * @return
     */
    public void deleteOpnDcsClsd(Params params) {
    	insert("PortalExposeInfoDao.deleteOpnDcsClsd", params);
    }

    /**
     * 결정통보 비공개내용 및 사유 > 청구취하 시 상태만 변경
     * @param params
     * @return
     */
    public void updateOpnDcsClsdYn(Params params) {
    	insert("PortalExposeInfoDao.updateOpnDcsClsdYn", params);
    }

	/**
	 * 정보공개 처리상태를 조회한다.
	 */
	public String getPrgStatCd(String apl_no) {
		return (String) select("PortalExposeInfoDao.getPrgStatCd", apl_no);
	}
	
	/**
	 * 청구 본인 인증정보 업데이트
	 */
	public int updateUserRauth(Params params) {
		return update("PortalExposeInfoDao.updateUserRauth", params);
	}
}