package egovframework.portal.assm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회의원 검색 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Repository(value="AssmMemberSchDao")
public class AssmMemberSchDao extends BaseDao {

	
	/**
	 * 국회의원 관련 공통코드를 검색한다.
	 */
	public List<Record> searchAssmMembCommCd(Params params) {
		return (List<Record>) list("assmMemberSchDao.searchAssmMembCommCd", params);
	}
	
	/**
	 * 국회의원 검색 페이징 처리
	 */
	public Paging searchAssmMemberSchPaging(Params params, int page, int rows) {
		return search("assmMemberSchDao.searchAssmMemberSchPaging", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 국회의원 조회
	 */
	public List<Record> selectAssmMemberSch(Params params) {
		return (List<Record>) list("assmMemberSchDao.searchAssmMemberSchPaging", params);
	}
	
	/**
	 * 현직 국회의원 회차의 재적수를 구한다
	 */
	public int searchAssmMemberAllCnt() {
		return (Integer) select("assmMemberSchDao.searchAssmMemberAllCnt");
	}
	
	/**
	 * 대수에 맞는 국회의원 회차의 재적수를 구한다
	 */
	public int searchAssmHistMemberAllCnt(Params params) {
		return (Integer) select("assmMemberSchDao.searchAssmHistMemberAllCnt", params);
	}
	
	/**
	 * 우편번호 선거구 매핑정보
	 */
	public List<Record> searchAssmNaElectCd(Params params) {
		return (List<Record>) list("assmMemberSchDao.searchAssmNaElectCd", params);
	}
	
	
}

