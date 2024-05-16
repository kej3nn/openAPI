package egovframework.portal.infs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 사전정보공개 컨텐츠를 관리하는 DB 접근 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/12
 */
@Repository(value="portalInfsContDao")
public class PortalInfsContDao extends BaseDao {
	
	/**
	 * 정보분류 트리 목록을 조회한다.
	 */
	public List<Record> selectInfoCateTree(Params params) {
		return (List<Record>) list("portalInfsContDao.selectInfoCateTree", params);
	}

	/**
	 * 정보셋 상세 조회
	 */
	public Record selectInfsDtl(Params params) {
		return (Record) select("portalInfsContDao.selectInfsDtl", params);
	}
	
	/**
	 * 정보셋 설명 조회
	 */
	public List<Record> selectInfsExp(Params params) {
		return (List<Record>) list("portalInfsContDao.selectInfsExp", params);
	}
	
	/**
	 * 정보셋에 연결된 문서 목록 조회
	 */
	public List<Record> selectDocInfRel(Params params) {
		params.set("opentyTag", "D");
		return (List<Record>) list("portalInfsContDao.selectInfsRel", params);
	}
	
	/**
	 * 정보셋에 연결된 공공데이터 목록 조회
	 */
	public List<Record> selectOpenInfRel(Params params) {
		params.set("opentyTag", "O");
		return (List<Record>) list("portalInfsContDao.selectInfsRel", params);
	}
	
	/**
	 * 정보셋에 연결된 통계데이터 목록 조회
	 */
	public List<Record> selectSttsTblRel(Params params) {
		params.set("opentyTag", "S");
		return (List<Record>) list("portalInfsContDao.selectInfsRel", params);
	}
	
	/**
	 * 정보공개 컨텐츠 모바일 조회(페이징)
	 */
	public Paging selectInfsContPaging(Params params, int page, int rows) {
		return search("portalInfsContDao.selectInfsContPaging", params, page, rows, PAGING_MANUAL);
    } 
	
	/**
	 * 정보공개 컨텐츠 목록 검색
	 */
	public List<Record> searchInfsCont(Params params) {
		return (List<Record>) list("portalInfsContDao.selectInfsContPaging", params);
	}
	
	/**
	 * 정보셋 조회 로그를 등록한다.
	 */
	public Object insertLogInfs(Params params) {
		return insert("portalInfsContDao.insertLogInfs", params);
	}
	
	/**
	 * 정보분류 부모ID가 속한 하위의 카테고리를 조회한다.
	 */
	public List<?> selectInfoCateChild(Params params) {
		return list("portalInfsContDao.selectInfoCateChild", params);
	}
	
	/**
	 * 모바일에서 분류ID로 바로가기할때 파라미터로 넘어오는 분류 ID의 전체 CATE_ID를 가져온다. 
	 */
	public Record selectInfoCateFullPathCateId(Params params) {
		return (Record) select("portalInfsContDao.selectInfoCateFullPathCateId", params);
	}
}
