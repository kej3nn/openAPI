package egovframework.ggportal.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface PortalMyPageService {

	/**
	 * 활용 갤러리 등록
	 * @param params
	 * @return
	 */
	public Result insertUtilGalleryCUD(Params params);
	
	/**
	 * 활용 갤러리 수정
	 * @param params
	 * @return
	 */
	public Result updateUtilGalleryCUD(Params params);
	
	/**
	 * OpenAPI 검색
	 * @param params
	 * @return
	 */
	public List<?> searchOpenApi(Params params);
	
	/**
	 * OpenAPI 인증키 폐기
	 * @param params
	 * @return
	 */
	public Result updateDiscardActKey(Params params);
	
	/**
	 * 사용자 정보 조회
	 * @param params
	 * @return
	 */
	public Object selectUserInfo(Params params);
	
	/**
	 * 사용자 정보 수정
	 * @param params
	 * @return
	 */
	public Result updateUserInfoCUD(Params params);
	
	/**
	 * 사용자 정보 삭제
	 * @param params
	 * @return
	 */
	public Result deleteUserInfoCUD(Params params);
	
	/**
	 * 인증키 이용 목록
	 * @param params
	 * @return
	 */
	public List<?> selectListUseActKey(Params params);
	
	/**
	 * 통계스크랩 목록 조회
	 * @param params
	 * @return
	 */
	public Paging statUserScrapList(Params params);
	
	/**
	 * 통계스크랩 삭제
	 * @param params
	 * @return
	 */
	public Result delStatUserScrap(Params params);
	
	
	/**
	 * 뉴스레터 수신정보 조회
	 */
	public Record selectNewsletter(Params params);
	
	/**
	 * 뉴스레터 수신동의 저장 
	 */
	public Result saveNewsletterAgree(Params params);
	
	/**
	 * 유저 검색로그 조회
	 */
	public Paging searchSearchHisData(Params params);
	
	/**
	 * 청구 기본정보 조회
	 * @param params
	 * @return
	 */
	public Object selectExposeDefaultUpdInfo(Params params);
	
	/**
	 * 청구 기본정보 수정
	 * @param params
	 * @return
	 */
	public Result updateExposeDefaultUpdCUD(Params params);

	List<Record> selectOpenInfSearchPop(Params params);

	Result updateDvp(Params params);
	
	/**
     * 정보공개 나의 청구서 목록을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchMyOpnzAplList(Params params); 
    
    /**
	 * 기존 청구서 저장
	 * @param params
	 * @return
	 */
	public Result updateMyOpnzApl(Params params);
}
