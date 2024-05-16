package egovframework.portal.infs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.util.UtilTree;
import egovframework.portal.infs.service.PortalInfsContService;

/**
 * 사전정보공개 컨텐츠를 관리하는 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/12
 */
@Service(value="portalInfsContService")
public class PortalInfsContServiceImpl extends BaseService implements PortalInfsContService {

	@Resource(name="portalInfsContDao")
	protected PortalInfsContDao portalInfsContDao;

	/**
	 * 정보분류 트리 목록을 조회한다.
	 */
	@Override
	public List<Map<String, Object>> selectInfoCateTree(Params params) {
		List<Record> list = portalInfsContDao.selectInfoCateTree(params);
		
		return UtilTree.convertorTreeData(list, "T", "infsId", "parInfsId", "infsNm", "gubunTag", "vOrder");
	}

	/**
	 * 정보셋 상세 조회
	 */
	@Override
	public Record selectInfsDtl(Params params) {
		// 정보셋 로그 등록
		portalInfsContDao.insertLogInfs(params);
		
		return portalInfsContDao.selectInfsDtl(params);
	}
	
	/**
	 * 정보셋 설명 조회
	 */
	@Override
	public List<Record> selectInfsExp(Params params) {
		return portalInfsContDao.selectInfsExp(params);
	}

	/**
	 * 정보셋에 연결된 데이터들 조회(문서, 공개, 통계)
	 */
	@Override
	public Map<String, List<Record>> selectInfsRel(Params params) {
		Map<String, List<Record>> map = new HashMap<String, List<Record>>(); 
		
		map.put("docList", portalInfsContDao.selectDocInfRel(params));			// 문서
		map.put("openList", portalInfsContDao.selectOpenInfRel(params));		// 공개
		map.put("sttsList", portalInfsContDao.selectSttsTblRel(params));		// 통계
		
		return map;
	}

	/**
	 * 정보공개 컨텐츠 모바일 조회(페이징)
	 */
	@Override
	public Paging selectInfsContPaging(Params params) {
		return portalInfsContDao.selectInfsContPaging(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 정보공개 컨텐츠 목록 검색
	 */
	public List<Record> searchInfsCont(Params params) {
		return portalInfsContDao.searchInfsCont(params);
	}
	
	/**
	 * 정보분류 트리 목록을 조회한다.(전체목록 엑셀 다운로드 할때 사용)
	 */
	@Override
	public List<Record> selectInfoCateTreeExcel(Params params) {
		return portalInfsContDao.selectInfoCateTree(params);
	}

	/**
	 * 정보분류 부모ID가 속한 하위의 카테고리를 조회한다. 
	 */
	@Override
	public List<Record> selectInfoCateChild(Params params) {
		return (List<Record>) portalInfsContDao.selectInfoCateChild(params);
	}

	/**
	 * 모바일에서 분류ID로 바로가기할때 파라미터로 넘어오는 분류 ID의 전체 CATE_ID를 가져온다.
	 */
	@Override
	public Record selectInfoCateFullPathCateId(Params params) {
		return portalInfsContDao.selectInfoCateFullPathCateId(params);
	}
}
