package egovframework.portal.assm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회의원 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Repository(value="AssmMemberDao")
public class AssmMemberDao extends BaseDao {
	
	/**
	 * MONA_CD(임시로 부여한 EMP_NO)로 EMP_NO를 조회한다.
	 */
	public String selectAssmEmpNoByMonaCd(Params params) {
		return (String) select("assmMemberDao.selectAssmEmpNoByMonaCd", params);
	}
	
	/**
	 * 국회 관련 공통코드를 검색한다.
	 */
	public List<Record> searchAssmCommCd(Params params) {
		return (List<Record>) list("assmMemberDao.searchAssmCommCd", params);
	}
	
	/**
	 * 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
	 */
	List<Record> selectAssmHistUnitCodeList(Params params) {
		return (List<Record>) list("assmMemberDao.selectAssmHistUnitCodeList", params);
	}
	
	/**
	 * 국회의원의 최종 회차를 구한다.
	 */
	public Record selectAssmMaxUnit(Params params) {
		return (Record) select("assmMemberDao.selectAssmMaxUnit", params);
	}
	
	/**
	 * 현재 국회대수를 조회한다.
	 */
	public Record selectCurrentAssmUnit() {
		return (Record) select("assmMemberDao.selectCurrentAssmUnit");
	}
	
	/**
	 * 국회의원 개인신상 상세정보를 조회
	 */
	Record selectAssmMemberDtl(Params params) {
		return (Record) select("assmMemberDao.selectAssmMemberDtl", params);
	}
	
	/**
	 * 국회의원 인적정보 조회
	 */
	List<Record> selectAssmMemberInfo(Params params) {
		return (List<Record>) list("assmMemberDao.selectAssmMemberInfo", params);
	}
	
	/**
	 * 선거이력 조회
	 */
	List<Record> selectElectedInfo(Params params) {
		return (List<Record>) list("assmMemberDao.selectElectedInfo", params);
	}
	
	/**
	 * SNS 정보 조회
	 */
	Record selectAssemSns(Params params) {
		return (Record) list("assmMemberDao.selectAssemSns", params);
	}
	
	/**
	 * URL 코드로 MONA_CD 조회
	 */
	public String selectAssmMemberUrlByMonaCd(Params params) {
		return (String) select("assmMemberDao.selectAssmMemberUrlByMonaCd", params);
	}
	
	/**
	 * URL 코드로 MONA_CD 조회(영문명으로)
	 */
	public String selectAssmMemberUrlByMonaCdChkEngnm(Params params) {
		return (String) select("assmMemberDao.selectAssmMemberUrlByMonaCdChkEngnm", params);
	}
	
	/**
	 * 파일변환이 안되어 있는 국회의원 사진 이미지 정보를 조회
	 */
	List<Record> selectAssmPicture(Params params) {
		return (List<Record>) list("assmMemberDao.selectAssmPicture", params);
	}
	
	/**
	 * 파일변환 후 상태값 수정
	 */
	public Object updateAssmPicture(Params params) {
		return update("assmMemberDao.updateAssmPicture", params);
	}

	/**
	 * 메뉴정보를 로그에 담는다.
	 */
	public Object insertLogMenu(Params params) {
		return insert("assmMemberDao.insertLogMenu", params);
	}
}
