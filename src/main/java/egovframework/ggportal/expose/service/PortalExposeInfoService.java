/*
 * @(#)PortalExposeInfoService.java 1.0 2019/07/19
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.expose.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

/**
 * 정보공개 요청을 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalExposeInfoService {
    /**
     * 정보공개 청구대상기관 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectNaboOrg(Params params);

    /**
     * 정보공개 코드 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectComCode(Params params);

    /**
     * 정보공개 청구서작성 데이터를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    Object insertAccount(HttpServletRequest request, Params params);
    
    /**
     * 정보공개 청구서처리현황 내용을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchAccount(Params params);    

    /**
     * 정보공개 청구서작성 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Map<String, Object> getInfoOpenApplyDetail(Params params);

    /**
     * 정보공개 청구를 취하한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    Object withdrawAccount(HttpServletRequest request, Params params);
    
    /**
     * 정보공개 청구서 처리 이력을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> getInfoOpenApplyHist(Params params);
    
    public Map<String, Object> selectLoginUserInfo(Params params);
    
    /**
     * 정보공개 이의신청서 대상을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging targetObjection(Params params);        
    
    /**
     * 정보공개 이의신청서 작성 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Map<String, Object> getWriteBaseInfo(Params params);

    /**
     * 정보공개 이의신청서 수정 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Map<String, Object> getUpdateBaseInfo(Params params);
    
    /**
     * 정보공개 이의신청서작성 데이터를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    Object insertObjection(HttpServletRequest request, Params params);
    
    /**
     * 정보공개 이의신청서작성 데이터를 수정한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    Object updateObjection(HttpServletRequest request, Params params);
    
    /**
     * 정보공개 이의신청서 처리현황을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchObjection(Params params);
    
    /**
     * 정보공개 이의신청서를 이의취하한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    Object withdrawObjection(HttpServletRequest request, Params params);
    
    /**
     * 정보공개 이의신청서 작성 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Map<String, Object> getOpnObjtnDetail(Params params);

    /**
     * 정보공개 이의신청서 처리 이력을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> getObjtnHist(Params params);
    
    /**
     * 첨부파일 다운로드
     * @param params
     * @return
     */
    public Record downloadOpnAplFile(Params params);
    
    /**
     * 양식파일 다운로드
     * @param params
     * @return
     */
    public Record downloadBasicFile(Params params);
    
    /**
	 * 청구 기본정보(사용자정보) 입력
	 * @param params
	 * @return
	 */
	public Result updateExposeDefaultInfo(Params params);
	
    /**
     * 이의신청 대상 항목을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectOpnDcsClsd(Params params);
    
    /**
     * 이의신청 대상 선택 항목을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectOpnDcsChkClsd(Params params);
    
    /**
     * 정보공개 처리상태를 조회한다.
     * 
     * @param params 파라메터
     * @return 처리상태
     */
    public String getPrgStatCd(String apl_no);    
    
    /**
	 * 청구 본인 인증정보 업데이트
	 * @param params
	 * @return
	 */
	public Result updateUserRauth(Params params);
}