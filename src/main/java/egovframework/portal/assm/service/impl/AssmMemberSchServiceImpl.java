package egovframework.portal.assm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.assm.service.AssmMemberSchService;

/**
 * 국회의원 검색 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Service(value="AssmMemberSchService")
public class AssmMemberSchServiceImpl extends BaseService implements AssmMemberSchService {

	@Resource(name="AssmMemberSchDao")
	private AssmMemberSchDao assmMemberSchDao;

	/**
	 * 국회의원 관련 공통코드를 검색한다.
	 */
	@Override
	public List<Record> searchAssmMembCommCd(Params params) {
		return assmMemberSchDao.searchAssmMembCommCd(params);
	}
	
	/**
	 * 국회의원 검색 페이징 처리
	 */
	@Override
	public Paging searchAssmMemberSchPaging(Params params) {
		return assmMemberSchDao.searchAssmMemberSchPaging(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 국회의원 조회
	 */
	@Override
	public List<Record> selectAssmMemberSchPaging(Params params) {
		return assmMemberSchDao.selectAssmMemberSch(params);
	}

	/**
	 * 현직 국회의원 회차의 재적수를 구한다
	 */
	public int searchAssmMemberAllCnt() {
		return assmMemberSchDao.searchAssmMemberAllCnt();
	}
	
	/**
	 * 대수에 맞는 국회의원 회차의 재적수를 구한다
	 */
	public int searchAssmHistMemberAllCnt(Params params) {
		return assmMemberSchDao.searchAssmHistMemberAllCnt(params);
	}

	/**
	 * 우편번호 선거구 매핑정보
	 */
	@Override
	public List<Record> searchAssmNaElectCd(Params params) {
		
		String gubun = "N";
		String sidoCd = params.getString("sidoCd");		// 시도 구분
		String sigungu = params.getString("sigungu");	// 시군구 구분
		
		if ( StringUtils.isNotBlank(sigungu) ) {
			gubun = "dong";
		}
		else if ( StringUtils.isNotBlank(sidoCd) ) {
			gubun = "sigungu";
		}
		
		params.set("gubun", gubun);
		
		return assmMemberSchDao.searchAssmNaElectCd(params);
	}
}
