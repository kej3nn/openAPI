package egovframework.portal.assm.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.util.UtilString;
import egovframework.portal.assm.service.AssmMemberService;
import egovframework.portal.assm.web.AssmMemberController;
import egovframework.portal.assm.web.DownloadAssmExcel;

/**
 * 국회의원 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Service(value="AssmMemberService")
public class AssmMemberServiceImpl extends BaseService implements AssmMemberService {

	@Resource(name="AssmMemberDao")
	private AssmMemberDao assmMemberDao;
	
	@Resource(name="AssmLawmDao")
	private AssmLawmDao assmLawmDao;
	
	@Resource(name="AssmPdtaDao")
	private AssmPdtaDao assmPdtaDao;
	
	@Resource(name="AssmSchdDao")
	private AssmSchdDao assmSchdDao;
	
	@Resource(name="AssmNotiDao")
	private AssmNotiDao assmNotiDao;
	
	@Resource(name="AssmMemberSchDao")
	private AssmMemberSchDao assmMemberSchDao;
	
	/**
	 * 국회 관련 공통코드 조회
	 */
	public List<Record> searchAssmCommCd(Params params) {
		return assmMemberDao.searchAssmCommCd(params);
	}
	
	/**
	 * 현재 국회대수를 조회한다.
	 */
	@Override
	public void setModelInCurrentAssmMemberUnit(Model model) {
		Record currentAssmUnitInfo = assmMemberDao.selectCurrentAssmUnit();
		model.addAttribute("unitCd", currentAssmUnitInfo.getString("unitCd"));
		model.addAttribute("unitNm", currentAssmUnitInfo.getString("unitNm"));
	}
	
	/**
	 * 국회의원 각종 코드관련 정보를 로드한다.
	 * @param model
	 * @param params
	 */
	public void loadAssmMemberCode(Model model, Params params) {
		
		// 파라미터로 받아온 MonaCd로 EmpNo를 조회하여 모델에 세팅한다.
		setModelInConvertMonaCdToEmpNo(model, params);
		
		// 국회의원 대수정보를 조회하여 모델에 세팅한다.
		setModelInAssmMemberUnit(model, params);
	}
	
	/**
	 * 파라미터로 받아온 MonaCd로 EmpNo를 조회하여 모델에 세팅한다.
	 */
	public String setModelInConvertMonaCdToEmpNo(Model model, Params params) {
		String paramMonaCd = params.getString("monaCd");
		String monaCd = UtilString.SQLInjectionFilter2(paramMonaCd);
		Params schParams = new Params();
		schParams.put("monaCd", monaCd);
		
		// MONA_CD(임시로 부여한 EMP_NO)로 EMP_NO를 조회한다.
		String empNo = StringUtils.defaultString(assmMemberDao.selectAssmEmpNoByMonaCd(schParams));
		
		if ( StringUtils.isBlank(empNo) ) {
			//throw new SystemException("잘못된 요청입니다.[EN]");
			params.put("empNo", "99"); // MONA_CD랑 EMP_NO가 매핑이 안될때 임의 99 세팅 
		}
		
		model.addAttribute("monaCd", monaCd);
		model.addAttribute("empNo", empNo);
		params.put("empNo", empNo);
		return empNo;
	}
	
	/**
	 * 국회의원 대수정보를 조회하여 모델에 세팅한다.
	 */
	public void setModelInAssmMemberUnit(Model model, Params params) {
		String unitCd = params.getString("unitCd");
		
		if ( StringUtils.isNotBlank(unitCd) ) {
			if ( !checkValidUnitCd(unitCd) ) {
				//throw new SystemException("잘못된 요청입니다.[UC]");
				params.put("unitCd", "99");  // unitCd NULL 이거나 잘못된 경우 임의로 99 세팅
			}
			model.addAttribute("unitCd", unitCd);
			model.addAttribute("unitNm", StringUtils.substring(unitCd, 4));
			params.put("unitCd", unitCd);
			model.addAttribute("isHistMemberSch", "Y");		// 역대 국회의원 검색 여부
		}
		else {
			Record unit = assmMemberDao.selectAssmMaxUnit(params);
			model.addAttribute("unitCd", unit.getString("unitCd"));
			model.addAttribute("unitNm", unit.getString("unitNm"));
			params.put("unitCd", unit.getString("unitCd"));
			model.addAttribute("isHistMemberSch", "N");
		}
	}
	
	/**
	 * 국회의원 대수코드가 정상인지 확인한다.
	 */
	public boolean checkValidUnitCd(String unitCd) {
		String unitCdPrefix = "1000";
		boolean isValid = false;
		
		System.out.print("##########StringUtils.length(unitCd)="+ StringUtils.length(unitCd));
		System.out.print("##########StringUtils.substring(unitCd, 0, 4)="+ StringUtils.substring(unitCd, 0, 4));
		System.out.print("##########startsWith="+ StringUtils.startsWith(unitCdPrefix, StringUtils.substring(unitCd, 0, 4)));
		
		if ( StringUtils.isNotBlank(unitCd) ) {
			if ( StringUtils.length(unitCd) == 6 
					&& StringUtils.startsWith(unitCdPrefix, StringUtils.substring(unitCd, 0, 4))) {
				return true;
			}
			else {
				return false;
			}
		}
		else {
			isValid = true;
		}
		
		return isValid;
	}
	
	
	/**
	 * 국회의원의 최종 회차를 구한다.
	 */
	/*@Override
	public void selectAssmMaxUnit(Model model, String empNo) {
		Params params = new Params();
		params.put("empNo", empNo);
		
		if ( StringUtils.isNotEmpty(empNo) ) {
			Record unit = assmMemberDao.selectAssmMaxUnit(params);
			model.addAttribute("unitCd", unit.getString("unitCd"));
			model.addAttribute("unitNm", unit.getString("unitNm"));
		}
	}*/
	
	/**
	 * 국회의원 정보를 모델에 저장한다.
	 */
/*	@Override
	public void putModelInAssmMemberDtl(Model model, Params params) {
//		Params infoParam = new Params();
//		infoParam.set("empNo", empNo);
//		infoParam.set("unitCd", StringUtils.isNotBlank(unitCd) ? unitCd : (String) model.asMap().get("unitCd"));
		model.addAttribute("meta", selectAssmMemberDtl(params));
	}*/
	
	/**
	 * 역대 국회의원 대수 코드 목록을 조회한다. (현재 보유하고 있는 데이터 코드 기준)
	 */
	@Override
	public List<Record> selectAssmHistUnitCodeList(Params params) {
		return assmMemberDao.selectAssmHistUnitCodeList(params);
	}
	
	/**
	 * 국회의원 개인신상 상세정보를 조회
	 */
	@Override
	public Record selectAssmMemberDtl(Params params) {
		return assmMemberDao.selectAssmMemberDtl(params);
	}

	/**
	 * 국회의원 인적정보 조회
	 */
	@Override
	public List<Record> selectAssmMemberInfo(Params params) {
		return assmMemberDao.selectAssmMemberInfo(params);
	}
	
	/**
	 * 선거이력 조회
	 */
	@Override
	public List<Record> selectElectedInfo(Params params) {
		return assmMemberDao.selectElectedInfo(params);
	}
	
	/**
	 * SNS 정보 조회
	 */
	@Override
	public Record selectAssemSns(Params params) {
		return assmMemberDao.selectAssemSns(params);
	}

	/**
	 * 화면의 조회결과의 데이터를 엑셀로 다운로드 한다.
	 */
	@Override
	public void downloadExcel(HttpServletRequest request, HttpServletResponse response, Params params) {
		
		String gId = params.getString("gubunId");
		
		Map<String, Object> svcMap = new HashMap<String, Object>();
		
		try {
			
			if ( StringUtils.isNotEmpty(gId) && AssmMemberController.GUBUN_NAMES.containsKey(gId) ) {
				
				// 의정활동
				if ( gId.startsWith("A") ) {
					svcMap = getLawmData(params);
				}
				// 의원실알림
				else if ( gId.startsWith("N") ) {
					svcMap = getNotiData(params);
				}
				// 의원 일정
				else if ( gId.startsWith("S") ) {
					svcMap = getSchdData(params);
				}
				// 정책자료보고서
				else if ( gId.startsWith("P") ) {
					svcMap = getPdtaData(params);
				}
				// 의원검색 
				else if ( gId.startsWith("M") ) {
					svcMap = getMemberData(params);
				}
			}
			else {
				throw new SystemException("다운로드 중 에러가 발생하였습니다.");
			}
			
			
			// 의정과 국회의원 구분
			params.set("GUBUN_ASSM_BPM", "ASSM");
			// 다운로드 진행
			procDownloadExcel(request, response, params, svcMap);
			
		} 
		catch(DataAccessException e) {
			EgovWebUtil.exLogging(e);
		}
		catch(Exception e) {
			EgovWebUtil.exLogging(e);
			throw new SystemException("다운로드중 에러가 발생하였습니다.");
		}
		
	}
	


	/**
	 * 데이터를 확인하여 엑셀 다운로드를 진행한다.
	 * @param request
	 * @param response
	 * @param params
	 * @param svcMap
	 */
	public void procDownloadExcel(HttpServletRequest request, HttpServletResponse response, Params params, Map<String, Object> svcMap) {
		// 헤더 데이터
		List<String> header = (List<String>) svcMap.get("header");
		
		// 컬럼 ID
		List<String> colIds = (List<String>) svcMap.get("colId");
		
		// DB에서 조회된 데이터
		List<Record> data = (List<Record>) svcMap.get("data");
		
		// 컬럼 ID로 추출한 데이터 
		List<ArrayList<Object>> colData = new ArrayList<ArrayList<Object>>();
		ArrayList<Object> dataRow = null;
		
		if ( header.size() > 0 && header.size() == colIds.size() ) {

			for ( Record rcd : data ) {
				
				dataRow = new ArrayList<Object>();
				
				for ( String colId : colIds ) {
					
					if ( StringUtils.isNotEmpty(colId) && rcd.get(colId) != null ) {
						dataRow.add(rcd.get(colId));
					}
					else {
						dataRow.add("");
					}
				}
				
				colData.add(dataRow);
				
			}
			
			// 다운로드 수행
			DownloadAssmExcel.downloadXls(response, request, params, header, colData);
		}
	}
	
	/**
	 * 데이터를 확인하여 엑셀 다운로드를 진행한다.(인적정보)
	 * @param request
	 * @param response
	 * @param params
	 * @param svcMap
	 */
	public void procInfoDownloadExcel(HttpServletRequest request, HttpServletResponse response, Params params, Map<String, Object> svcMap) {
		// 헤더 데이터
		List<String> header = (List<String>) svcMap.get("header");
		
		// 컬럼 ID
		List<String> colIds = (List<String>) svcMap.get("colId");
		
		// DB에서 조회된 데이터
		List<Record> data = (List<Record>) svcMap.get("data");
		
		// 컬럼 ID로 추출한 데이터 
		List<ArrayList<Object>> colData = new ArrayList<ArrayList<Object>>();
		ArrayList<Object> dataRow = null;
		
		if ( header.size() > 0 && header.size() == colIds.size() ) {

			for ( Record rcd : data ) {
				
				dataRow = new ArrayList<Object>();
				
				for ( String colId : colIds ) {
					
					if ( StringUtils.isNotEmpty(colId) && rcd.get(colId) != null ) {
						dataRow.add(rcd.get(colId));
					}
					else {
						dataRow.add("");
					}
				}
				
				colData.add(dataRow);
				
			}
			
			// 다운로드 수행
			DownloadAssmExcel.downloadInfoXls(response, request, params, header, colData, svcMap);
		}
	}
	
	/**
	 * 의원검색 엑셀 데이터 조회
	 */
	
	private Map<String, Object> getMemberData(Params params) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String gId = params.getString("gubunId");
		
		if ( StringUtils.equals(gId, "MA") ) {
//			map.put("header", new ArrayList<String>(Arrays.asList("대수", "의원명", "사진", "정당", "소속위원회" , "지역", "성별", "당선횟수", "당선방법")));
//			map.put("colId", new ArrayList<String>(Arrays.asList("unitNm", "hgNm", "deptImgUrl" , "polyNm", "cmitNm", "origNm", "sexGbnNm", "reeleGbnNm", "eleGbnNm")));
			map.put("header", new ArrayList<String>(Arrays.asList("대수", "의원명", "정당", "소속위원회" , "지역", "성별", "당선횟수", "당선방법")));
			map.put("colId", new ArrayList<String>(Arrays.asList("unitNm", "hgNm" , "polyNm", "cmitNm", "origNm", "sexGbnNm", "reeleGbnNm", "eleGbnNm")));
			
			map.put("data", assmMemberSchDao.selectAssmMemberSch(params));
		}
		
		return map;
	}
	/**
	 * 의정활동 엑셀 데이터 조회
	 */
	private Map<String, Object> getLawmData(Params params)  {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String gId = params.getString("gubunId");

		if ( StringUtils.equals(gId, "AD") ) {
			params.set("represent", "대표발의");
//			map.put("header", new ArrayList<String>(Arrays.asList("의안명", "소관위원회", "대표발의자", "공동발의자", "작성일", "처리상태")));
//			map.put("colId", new ArrayList<String>(Arrays.asList("billName", "committee", "proposer", "", "proposeDt", "procResult")));
			map.put("header", new ArrayList<String>(Arrays.asList("의안명", "제안자", "소관위원회", "작성일", "처리상태")));
			map.put("colId", new ArrayList<String>(Arrays.asList("billName", "proposer", "committee", "proposeDt", "procResult")));
			
			map.put("data", assmLawmDao.selectLawmMotnLgsb(params));
		}
		else if ( StringUtils.equals(gId, "AC") ) {
			params.set("represent", "공동발의");
			map.put("header", new ArrayList<String>(Arrays.asList("의안명", "제안자", "소관위원회", "작성일", "처리상태")));
			map.put("colId", new ArrayList<String>(Arrays.asList("billName", "proposer", "committee", "proposeDt", "procResult")));
			map.put("data", assmLawmDao.selectLawmMotnLgsb(params));
		}
		else if ( StringUtils.equals(gId, "AR") ) { // 표결현황
			map.put("header", new ArrayList<String>(Arrays.asList("의결일자", /*"의안번호",*/ "의안명", "소관위원회", "표결정보", "표결결과")));
			map.put("colId", new ArrayList<String>(Arrays.asList("voteendDt", /*"billNo",*/  "billName", "currCommittee", "resultVote", "result")));
			map.put("data", assmLawmDao.selectLawmVoteCond(params));
		}else if ( StringUtils.equals(gId, "AD_2") ) {
			params.set("represent", "대표발의");
			map.put("header", new ArrayList<String>(Arrays.asList("의안명",  "제안자" , "소관위원회", "작성일", "처리상태")));
			map.put("colId", new ArrayList<String>(Arrays.asList("billName","proposer", "committee",  "proposeDt", "procResult")));
			map.put("data", assmLawmDao.selectLawmMotnLgsb(params));
		}
		else if ( StringUtils.equals(gId, "AC_2") ) {
			params.set("represent", "공동발의");
			map.put("header", new ArrayList<String>(Arrays.asList("의안명", "소관위원회", "제안자", "작성일", "처리상태")));
			map.put("colId", new ArrayList<String>(Arrays.asList("billName", "committee", "proposer", "proposeDt", "procResult")));
			map.put("data", assmLawmDao.selectLawmMotnLgsb(params));
		}
		else if ( StringUtils.equals(gId, "AS") ) {  // 상임위 활동x`
			map.put("header", new ArrayList<String>(Arrays.asList("대수", "회기", "차수", "위원회", "회의일", "작성일")));
			map.put("colId", new ArrayList<String>(Arrays.asList("daeNum", "sesNum", "degreeNum", "commName" , "confDate", "regDate")));
			map.put("data", assmLawmDao.searchLawmSdcmAct(params));
		}else if ( StringUtils.equals(gId, "AV") ) {  // 영상회의록 
			map.put("header", new ArrayList<String>(Arrays.asList("날짜", "회의명/내용", "분초")));
			map.put("colId", new ArrayList<String>(Arrays.asList("takingDate", "title", "recTime")));   
			map.put("data", assmLawmDao.selectCombLawmVideoMnts(params));
		}else if ( StringUtils.equals(gId, "AO") ) {  // 연구단체
			map.put("header", new ArrayList<String>(Arrays.asList("대수", "분야별", "연구단체")));
			map.put("colId", new ArrayList<String>(Arrays.asList("regdaesu", "reTopicName", "reName")));
		    map.put("data", assmLawmDao.searchLawmRschOrg(params));
		}else if ( StringUtils.equals(gId, "AP") ) {  // 청원현황 
			map.put("header", new ArrayList<String>(Arrays.asList("구분","청원번호", "청원명", "청원인" ,"소개의원", "접수일", "회부일", "소관위원회", "의결일자", "의결결과")));
			map.put("colId", new ArrayList<String>(Arrays.asList("passGubun", "billNo", "billName", "proposer", "approver", "proposeDt", "committeeDt", "cmitNm", "procDt", "procResultCd")));
			map.put("data", assmLawmDao.searchCombLawmPttnReport(params));
		}
		
		
		
		return map;
	}
	
	/**
	 * 정책자료&보고서 엑셀 데이터 조회
	 */
	private Map<String, Object> getPdtaData(Params params) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String gId = params.getString("gubunId");

		if ( StringUtils.equals(gId, "PA") ) {	// 전체
			map.put("header", new ArrayList<String>(Arrays.asList("구분", "제목", "등록일자")));
			map.put("colId", new ArrayList<String>(Arrays.asList("rptDivNm", "rptTit", "rptDt")));
			map.put("data", assmPdtaDao.selectAssmPdta(params));
		}
		
		if ( StringUtils.equals(gId, "PS") ) {	// 정책세미나
			map.put("header", new ArrayList<String>(Arrays.asList("제목", "주최", "일시")));
			map.put("colId", new ArrayList<String>(Arrays.asList("rptTit", "rptAutNm", "rptDt")));
			params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PS"));
			map.put("data", assmPdtaDao.selectAssmPdta(params));
		}
		
		if ( StringUtils.equals(gId, "PR") ) {	// 정책자료실
			map.put("header", new ArrayList<String>(Arrays.asList("제목", "발행처", "발행년")));
			map.put("colId", new ArrayList<String>(Arrays.asList("rptTit", "rptAutNm", "rptDt")));
			params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PR"));
			map.put("data", assmPdtaDao.selectAssmPdta(params));
		}
		
		if ( StringUtils.equals(gId, "PP") ) {	// 의정보고서
			map.put("header", new ArrayList<String>(Arrays.asList("제목", "발행처", "발행년")));
			map.put("colId", new ArrayList<String>(Arrays.asList("rptTit", "rptAutNm", "rptDt")));
			params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PP"));
			map.put("data", assmPdtaDao.selectAssmPdta(params));
		}
		
		if ( StringUtils.equals(gId, "PV") ) {	// 연구용역 연구보고서
			params.set("rptDivCd", "RESHR");
			map.put("header", new ArrayList<String>(Arrays.asList("보고서명", "작성자", "작성일")));
			map.put("colId", new ArrayList<String>(Arrays.asList("rptTit", "rptAutNm", "rptDt")));
			params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PV"));
			map.put("data", assmPdtaDao.selectAssmPdta(params));
		}
		
		if ( StringUtils.equals(gId, "PO") ) {	// 연구단체 활동보고서
			params.set("rptDivCd", "OREPORT");
			map.put("header", new ArrayList<String>(Arrays.asList("제목", "연도", "연구단체명")));
			map.put("colId", new ArrayList<String>(Arrays.asList("rptTit", "rptDt", "rptAutNm")));
			params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PO"));
			map.put("data", assmPdtaDao.selectAssmPdta(params));
		}
		if ( StringUtils.equals(gId, "PL") ) {	// 지역현안 입법지원 토론회 개최내역
			map.put("header", new ArrayList<String>(Arrays.asList("제목", "주최자", "개최일")));
			map.put("colId", new ArrayList<String>(Arrays.asList("rptTit", "rptAutNm", "rptDt")));
			params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PL"));
			map.put("data", assmPdtaDao.selectAssmPdta(params));
		}
		if ( StringUtils.equals(gId, "PB") ) {	// 의원 저서
			params.set("rptDivCd", "ABOOK");
			map.put("header", new ArrayList<String>(Arrays.asList("저서", "저자", "출판일")));
			map.put("colId", new ArrayList<String>(Arrays.asList("rptTit", "rptAutNm", "rptDt")));
			params.set("rptDivCd", AssmMemberController.GUBUN_NAMES.get("PB"));
			map.put("data", assmPdtaDao.selectAssmPdta(params));
		}
		
		return map;
	}
	
	/**
	 * 의원일정 엑셀 데이터 조회
	 */
	private Map<String, Object> getSchdData(Params params) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String gId = params.getString("gubunId");

		if ( StringUtils.equals(gId, "SA") ) {	// 전체
			map.put("header", new ArrayList<String>(Arrays.asList("구분", "제목", "일자", "시간")));
			map.put("colId", new ArrayList<String>(Arrays.asList("gubunNm", "title", "meetingDate", "meetingTime")));
			map.put("data", assmSchdDao.selectAssmSchd(params));
		}
		if ( StringUtils.equals(gId, "SR") ) {	// 본회의 의사일정
			params.set("gubun", "ASSEM");
			map.put("header", new ArrayList<String>(Arrays.asList("회기", "차수", "제목", "일시")));
			map.put("colId", new ArrayList<String>(Arrays.asList("meetingsession","cha" , "title", "meetingDateTime")));
			map.put("data", assmSchdDao.selectAssmSchd(params));
		}
		if ( StringUtils.equals(gId, "SC") ) {	// 위원호의사일정
			params.set("gubun", "CMMTT");
			map.put("header", new ArrayList<String>(Arrays.asList("위원회", "회기", "차수", "제목", "일시")));
			map.put("colId", new ArrayList<String>(Arrays.asList("committeeName", "meetingsession", "cha", "title", "meetingDateTime")));
			map.put("data", assmSchdDao.selectAssmSchd(params));
		}
		
		return map;
	}
	
	/**
	 * 의원실 알림 엑셀 데이터 조회
	 */
	private Map<String, Object> getNotiData(Params params) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String gId = params.getString("gubunId");

		if ( StringUtils.equals(gId, "NA") ) {	// 전체
			map.put("header", new ArrayList<String>(Arrays.asList("구분", "제목", "작성일")));
			map.put("colId", new ArrayList<String>(Arrays.asList("bbsNm", "titleV", "regDtD")));
			map.put("data", assmNotiDao.selectAssmNoti(params));
		}
		
		if ( StringUtils.equals(gId, "NR") ) {	// 의원실 채용
			params.set("bbsCdN", "6");
			map.put("header", new ArrayList<String>(Arrays.asList("제목", "작성일", "상태", "조회수")));
			map.put("colId", new ArrayList<String>(Arrays.asList("titleV", "regDtD", "useYn", "readCntN")));
			map.put("data", assmNotiDao.selectAssmNoti(params));
		}
		if ( StringUtils.equals(gId, "NI") ) {	// 기자회
			params.set("bbsCdN", "P");
			map.put("header", new ArrayList<String>(Arrays.asList("회견일", "회견시간", "제목", "발언자")));
			map.put("colId", new ArrayList<String>(Arrays.asList("startDtV", "endDtV", "titleV", "person")));
			map.put("data", assmNotiDao.selectAssmNoti(params));
		}
		
		return map;
	}

	@Override
	public void downExcelMembInfo(HttpServletRequest request, HttpServletResponse response, Params params) {
		Map<String, Object> svcMap = new HashMap<String, Object>();
		Record sns = null;
		try {
			// 역대 국회의원 다운로드인경우 소속위원회 제거
			/*if ( StringUtils.equals(params.getString("isHistMemberSch"), "Y") ) {
				svcMap.put("header", new ArrayList<String>(Arrays.asList("이름", "한자", "영문이름", "생년월일", "사진", "정당", "선거구")));
				svcMap.put("colId", new ArrayList<String>(Arrays.asList( "hgNm", "hjNm", "engNm", "bthDate", "deptImgUrl", "polyNm", "origNm")));
			}
			else {
				svcMap.put("header", new ArrayList<String>(Arrays.asList("이름", "한자", "영문이름", "생년월일", "사진", "정당", "선거구", "소속위원회", "당선횟수", "사무실전화", "홈페이지", "이메일", "보좌관", "비서관", "비서")));
				svcMap.put("colId", new ArrayList<String>(Arrays.asList( "hgNm", "hjNm", "engNm", "bthDate", "deptImgUrl", "polyNm", "origNm", "cmits", "reeleGbnNm", "telNo","homepage", "eMail", "staff", "secretary", "secretary2")));
			}
			*/
			if ( StringUtils.equals(params.getString("isHistMemberSch"), "Y") ) {
				svcMap.put("header", new ArrayList<String>(Arrays.asList("이름", "한자", "영문이름", "생년월일", "정당", "선거구")));
				svcMap.put("colId", new ArrayList<String>(Arrays.asList( "hgNm", "hjNm", "engNm", "bthDate", "polyNm", "origNm")));
			}
			else {
				svcMap.put("header", new ArrayList<String>(Arrays.asList("이름", "한자", "영문이름", "생년월일", "정당", "선거구", "소속위원회", "당선횟수", "사무실전화", "홈페이지", "이메일", "보좌관", "선임비서관", "비서관")));
				svcMap.put("colId", new ArrayList<String>(Arrays.asList( "hgNm", "hjNm", "engNm", "bthDate", "polyNm", "origNm", "cmits", "reeleGbnNm", "telNo","homepage", "eMail", "staff", "secretary", "secretary2")));
			}
			
			// 국회의원 기본정보
			Record meta = assmMemberDao.selectAssmMemberDtl(params);
			List<Record> list = new ArrayList<Record>();
			list.add(meta);	
			svcMap.put("data", list);
			
			if ( StringUtils.equals("P98", params.getString("profileCd")) ) {			// 선거이력
				svcMap.put("data2", assmMemberDao.selectElectedInfo(params));
			}
			else if ( StringUtils.equals("P99", params.getString("profileCd")) ) {		// SNS
				List<Record> snsData = new ArrayList<Record>();
				
				if ( StringUtils.isNotBlank(meta.getString("tUrl")) ) {
					sns = new Record();
					sns.put("profileCd", "P99");
					sns.put("gubun", "트위터");
					sns.put("url", meta.getString("tUrl"));
					snsData.add(sns);
				}
				if ( StringUtils.isNotBlank(meta.getString("fUrl")) ) {
					sns = new Record();
					sns.put("profileCd", "P99");
					sns.put("gubun", "페이스북");
					sns.put("url", meta.getString("fUrl"));
					snsData.add(sns);
				}
				if ( StringUtils.isNotBlank(meta.getString("iUrl")) ) {
					sns = new Record();
					sns.put("profileCd", "P99");
					sns.put("gubun", "인스타그램");
					sns.put("url", meta.getString("iUrl"));
					snsData.add(sns);
				}
				if ( StringUtils.isNotBlank(meta.getString("yUrl")) ) {
					sns = new Record();
					sns.put("profileCd", "P99");
					sns.put("gubun", "유튜브");
					sns.put("url", meta.getString("yUrl"));
					snsData.add(sns);
				}
				if ( StringUtils.isNotBlank(meta.getString("bUrl")) ) {
					sns = new Record();
					sns.put("profileCd", "P99");
					sns.put("gubun", "블로그");
					sns.put("url", meta.getString("bUrl"));
					snsData.add(sns);
				}
				
				svcMap.put("data2", snsData);
			}
			else {
				svcMap.put("data2", assmMemberDao.selectAssmMemberInfo(params));
			}
			
			//params.set("profileCd", "P10");
			// 의정과 국회의원 구분
			params.set("GUBUN_ASSM_BPM", "ASSM");
			// 다운로드 진행
			procInfoDownloadExcel(request, response, params, svcMap);
			
		} 
		catch(DataAccessException e) {
			EgovWebUtil.exLogging(e);
		}
		catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exLogging(e);
			throw new SystemException("다운로드중 에러가 발생하였습니다.");
		}
		
	}

	/**
	 * URL 코드로 MONA_CD 조회
	 */
	@Override
	public String selectAssmMemberUrlByMonaCd(Params params) {
		return assmMemberDao.selectAssmMemberUrlByMonaCd(params);
	}
	
	/**
	 * URL 코드로 MONA_CD 조회(영문명으로)
	 */
	@Override
	public String selectAssmMemberUrlByMonaCdChkEngnm(Params params) {
		return assmMemberDao.selectAssmMemberUrlByMonaCdChkEngnm(params);
	}
	
	/**
	 * 국회의원 사진이미지 파일 생성한다.
	 * @param model
	 * @param params
	 */
	@Override
	public void makeAssmPicture() {
		
			Params params = new Params();
		
			// 파일변환이 안되어 있는 국회의원 사진 이미지 정보를 조회
			List<?> dataList = assmMemberDao.selectAssmPicture(params);
	        for (int i = 0; i < dataList.size(); i++) {
	            Record data = (Record) dataList.get(i);
	            
	            String empNo = data.getString("empNo");
	            Blob pic = (Blob) data.get("pic");

	            if(pic != null){
	            	params.put("empNo", empNo);
		            try {
						blobToFile(empNo, pic);
					} catch (Exception e) {
						EgovWebUtil.exLogging(e);
					}
		            //파일생성 후 상태값을 변경한다.
		            assmMemberDao.updateAssmPicture(params);
	            }
	            
	        }
			
	}

	/**
	 * 국회의원 사진을 해당 위치에 저장한다.
	 * @param String empNo
	 * @param Blob pic
	 */
	public void blobToFile(String empNo, Blob pic) throws Exception{

		BufferedInputStream bis = new BufferedInputStream(pic.getBinaryStream());

		String makeFile = EgovProperties.getProperty("Globals.AssmMemberPictuerPath")+empNo+".jpg";

		BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(makeFile),4096);

		int readBlob = bis.read();
		while (readBlob != -1)
		{
		          bos.write(readBlob);
		          readBlob = bis.read();
		}
		bis.close();
		bos.close();
	}
	
	/**
	 * 메뉴정보를 로그에 담는다.
	 * @param model
	 * @param params
	 */
	@Override
	public void insertLogMenu(Params params) {
		//메뉴정보를 로그에 담는다.
		assmMemberDao.insertLogMenu(params);
	}	
	
}
