package egovframework.ggportal.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * MyPage DAO
 * @author 장홍식
 *
 */
@Repository("ggportalMyPageDao")
public class PortalMyPageDao extends BaseDao {

	
	public List<?> searchOpenAPI(Params params) {
		return search("PortalMyPageDao.searchOpenAPI", params);
	}
	
	public int updateDiscardActKey(Params params) {
		return update("PortalMyPageDao.updateDiscardActKey", params);
	}
	
	public Object selectUserInfo(Params params) {
		return select("PortalMyPageDao.selectUserInfo", params);
	}
	
	public int updateUserInfo(Params params) {
		return update("PortalMyPageDao.updateUserInfo", params);
	}
	
	public int deleteUserKey(Params params) {
		return delete("PortalMyPageDao.deleteUserKey", params);
	}
	
	public int deleteUserInfo(Params params) {
		return delete("PortalMyPageDao.deleteUserInfo", params);
	}
	
	public List<?> selectListUseActKey(Params params) {
		return search("PortalMyPageDao.selectListUseActKey", params);
	}
	
	public Paging selectStatUserScrapList(Params params, int page, int rows) {
        return search("PortalMyPageDao.selectStatUserScrapList", params, page, rows, PAGING_MANUAL, false);
    } 
	
	/**
	 * 통계 스크랩 삭제
	 * @param params
	 * @return
	 */
	public int delStatUserScrap(Params params) {
		return delete("PortalMyPageDao.delStatUserScrap", params);
	}
	public int delStatUserItmScrap(Params params) {
		return delete("PortalMyPageDao.delStatUserItmScrap", params);
	}
	public int delStatUserItmMScrap(Params params) {
		return delete("PortalMyPageDao.delStatUserItmMScrap", params);
	}
	
	/**
	 * 뉴스레터 수신정보 조회
	 */
	public Record selectNewsletter(Params params) {
		return (Record) select("PortalMyPageDao.selectNewsletter", params);
	}
	/**
	 * 뉴스레터 수신등록
	 */
	public int saveNewsletterAgree(Params params) {
		return update("PortalMyPageDao.saveNewsletterAgree", params);
	}
	
	/**
     * 유저별 검색로그 조회
     */
    public Paging searchSearchHisData(Params params, int page, int rows) {
    	return search("PortalMyPageDao.searchSearchHisData", params, page, rows);
    }
    
    /**
     * 청구 기본정보 조회
     */
    public Object selectExposeDefaultUpdInfo(Params params) {
		return select("PortalMyPageDao.selectExposeDefaultUpdInfo", params);
	}
    
    /**
     * 청구 기본정보 수정
     */
    public int updateExposeDefaultUpd(Params params) {
		return update("PortalMyPageDao.updateExposeDefaultUpd", params);
	}

	public List<Record> selectOpenInfSearchPop(Params params) {
		return (List<Record>) list("PortalMyPageDao.selectOpenInfSearchPop", params);
	}

	public Object updateDvp(Params params) {
		return update("PortalMyPageDao.updateDvp", params);
	}
	
	/**
     * 정보공개 나의 청구서 목록을 조회한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging searchMyOpnzAplList(Params params, int page, int rows) {
        return search("PortalMyPageDao.searchMyOpnzAplList", params, page, rows, PAGING_MANUAL);
    }
    
    /**
     * 청구서 조회
     * @param params
     * @return
     */
  	public List<Record> getOpnAplNoList(Params params) {
          return (List<Record>) list("PortalMyPageDao.getOpnAplNoList", params);
      }
  	
    /**
     * 기존 청구서 저장
     */
    public int updateMyOpnzApl(Record record) {
		return update("PortalMyPageDao.updateMyOpnzApl", record);
	}
}
