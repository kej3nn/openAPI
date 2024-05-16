package egovframework.portal.bpm.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.bpm.service.BpmDownService;
import egovframework.portal.bpm.web.BpmMstController;

@Service(value="bpmDownService")
public class BpmDownServiceImpl extends BaseService implements BpmDownService {

	@Resource(name="bpmPrcDao")
	private BpmPrcDao bpmPrcDao;
	
	@Resource(name="bpmCmpDao")
	private BpmCmpDao bpmCmpDao;
	
	@Resource(name="bpmDateDao")
	private BpmDateDao bpmDateDao;
	
	@Resource(name="bpmCohDao")
	private BpmCohDao bpmCohDao;
	
	@Resource(name="bpmPetDao")
	private BpmPetDao bpmPetDao;

	@Override
	public Map<String, Object> setPrcData(Params params) {
		String gId = params.getString("gubunId");
		String gubun = params.getString("gubun");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if ( StringUtils.isNotEmpty(gId) && BpmMstController.GUBUN_NAMES.containsKey(gId) ) {
			if (StringUtils.equals(gId, "PA")) {
				map.put("header", new ArrayList<String>(Arrays.asList("일시", "회기", "차수", "제목")));
				map.put("colId", new ArrayList<String>(Arrays.asList("meettingDateTime", "meetingsession", "cha", "title")));
				map.put("data", bpmPrcDao.searchPrcDate(params));
				
			} 
			else if ( StringUtils.equals(gId, "PB") ) {
				int searchParamCnt = 0;
				if (StringUtils.isBlank(params.getString("procResultCd")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("frRgsProcDt")))	searchParamCnt++;
				if (StringUtils.isBlank(params.getString("toRgsProcDt")))	searchParamCnt++;
				if (StringUtils.isBlank(params.getString("billName")))		searchParamCnt++;
				
				if ( searchParamCnt > 2 ) {
					throw new ServiceException("2가지 이상 조회조건을 입력하세요.");
				}
				if (StringUtils.equals(gubun, "LAW")) {
						
					map.put("header2", new ArrayList<String>(Arrays.asList("의안구분", "의안번호", "의안명", "제안자구분", "제안자", "소관위원회", "의결결과", "표결현황", "", "", "처리기간", "제안일", "소관위 심사정보", "", "", "법사위상정일", "법사위 체게자구심사정보", "", "", "본회의", "", "정부이송일", "공포일자")));
					map.put("header", new ArrayList<String>(Arrays.asList("의안구분", "의안번호", "의안명", "제안자구분", "제안자", "소관위원회", "의결결과", "표결현황 찬성", "표결현황 반대", "표결현황 기권", "처리기간", "제안일", "소관위심사정보 회부일", "소관위심사정보 상정일", "소관위심사정보 처리일", "법사위상정일", "법사위체계자구심사정보 회부일", "법사위체계자구심사정보 상정일", "법사위체계자구심사정보 처리일", "본회의 상정일", "본회의 의결일", "정부이송일", "공포일자")));
					map.put("colId", new ArrayList<String>(Arrays.asList("billKind", "billNo", "billName", "proposerKindCd", "proposer", "committeeName", "procResultCd", "yesTcnt", "noTcnt", "blankTcnt", "procPrd", "proposeDt", "committeeSubmitDt", "committeePresentDt", "committeeProcDt", "", "lawSubmitDt", "lawPresentDt", "lawProcDt", "rgsPresentDt", "rgsProcDt", "currTransDt", "announceDt")));
					map.put("data", bpmPrcDao.searchPrcItmPrcLaw(params));
				} else{
					map.put("header2", new ArrayList<String>(Arrays.asList("의안구분", "의안번호", "의안명", "의안결과", "표결현황", "", "", "처리기간", "제안일", "예결위 심사정보", "", "", "본회의 심의정보", "", "정부이송일")));
					map.put("header", new ArrayList<String>(Arrays.asList("의안구분", "의안번호", "의안명", "의안결과", "표결현황 찬성", "표결현황 반대", "표결현황 기권", "처리기간", "제안일", "예결위 심사정보 회부일", "예결위 심사정보 상정일", "예결위 심사정보 처리일", "본회의 심의정보 상정일", "본회의 심의정보 의결일", "정부이송일")));
					map.put("colId", new ArrayList<String>(Arrays.asList("billKind", "billNo", "billName", "procResultCd", "yesTcnt", "noTcnt", "blankTcnt", "procPrd", "proposeDt", "bdgSubmitDt", "bdgPresentDt", "bdgProcDt", "rgsPresentDt", "rgsProcDt", "announceDt")));
					map.put("data", bpmPrcDao.searchPrcItmPrcBdg(params));
				}
			}
			else if ( StringUtils.equals(gId,"PC" )) {
				int searchParamCnt = 0;
				if (StringUtils.isBlank(params.getString("unitCd")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("title")))	searchParamCnt++;
				if (StringUtils.isBlank(params.getString("frConfDate")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("toConfDate")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("subName")))		searchParamCnt++;
				
				if ( searchParamCnt > 3 ) {
					throw new ServiceException("2가지 이상 조회조건을 입력하세요.");
				}
				map.put("header", new ArrayList<String>(Arrays.asList("대수", "회의날짜", "회의명", "안건명")));
				map.put("colId", new ArrayList<String>(Arrays.asList("daeNum", "confDate", "title", "subName")));
				map.put("data", bpmPrcDao.searchPrcPrcd(params));
			}
		}
		
		return map;
	}

	@Override
	public Map<String, Object> setCmpData(Params params) {
		
		String gId = params.getString("gubunId");
	
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if ( StringUtils.isNotEmpty(gId) && BpmMstController.GUBUN_NAMES.containsKey(gId) ) {
			// 위원회 명단
			if ( StringUtils.equals(gId, "CA") ) {			// 위원회 현황
				map.put("header", new ArrayList<String>(Arrays.asList("위원회 종류", "위원회명", "위원정수", "현원", "더불어민주당", "자유한국당",  "바른미래당", "비교섭단체", "위원장", "간사")));
				map.put("colId", new ArrayList<String>(Arrays.asList("cmtDivNm", "committeeName", "limitCnt", "currCnt", "poly1Cnt", "poly2Cnt", "poly3Cnt", "poly99Cnt", "hgNm", "hgNmList")));
				map.put("data", bpmCmpDao.searchCmpCond(params));
			}
			else if ( StringUtils.equals(gId, BpmMstController.GUBUN_NAMES.get("CB")) ) {
				map.put("header", new ArrayList<String>(Arrays.asList("위원회명", "구성", "사진", "위원명", "소속정당", "선거구",  "전화번호", "보좌관", "선임비서관", "비서관")));
				map.put("colId", new ArrayList<String>(Arrays.asList("deptNm", "jobResNm", "deptImgUrl", "hgNm", "polyNm", "origNm", "telNo", "staff", "secretary", "secretary2")));
				map.put("data", bpmCmpDao.selectCmpList(params));
				/*
				List<Record> data = new ArrayList<Record>();
				Record r = null;
				r = new Record();
				r.put("c1", "국회운영위원회");
				r.put("c2", "자유한국당 원내대표");
				r.put("c3", "http://www.assembly.go.kr/photo/9770903.jpg");
				r.put("c4", "나경원");
				r.put("c5", "자유한국당 서울 동작구");
				r.put("c6", "02-784-6811");
				r.put("c7", "박운기, 홍성자");
				data.add(r);
				
				r = new Record();
				r.put("c1", "정보위원회,국방위원회");
				r.put("c2", "더불어민주당 원내대표");
				r.put("c3", "http://www.assembly.go.kr/photo/9770676.jpg");
				r.put("c4", "홍영표");
				r.put("c5", "더불어민주당 인천 부평구을");
				r.put("c6", "02-784-3143");
				r.put("c7", "서희철, 윤낙영");
				data.add(r);
				
				r = new Record();
				r.put("c1", "기획재정위원회");
				r.put("c2", "정의당 원내대표");
				r.put("c3", "http://www.assembly.go.kr/photo/9770869.jpg");
				r.put("c4", "심상정");
				r.put("c5", "정의당 고양시 갑");
				r.put("c6", "02-784-9530");
				r.put("c7", "심블리");
				data.add(r);
				
				map.put("data", data);*/
			}
			else if ( StringUtils.equals(gId, "CC") ) {			// 위원회 일정
				int searchParamCnt = 0;
				if (StringUtils.isBlank(params.getString("cmitCd")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("frMeetingDate")))	searchParamCnt++;
				if (StringUtils.isBlank(params.getString("toMeetingDate")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("title")))		searchParamCnt++;
				
				if ( searchParamCnt > 2 ) {
					throw new ServiceException("2가지 이상 조회조건을 입력하세요.");
				}
				map.put("header", new ArrayList<String>(Arrays.asList("위원회", "일시", "구분", "회기", "차수")));
				map.put("colId", new ArrayList<String>(Arrays.asList("committeeName", "meettingDateTime", "title", "meetingsession", "cha")));
				map.put("data", bpmCmpDao.searchCmpDate(params));
			}
			else if ( StringUtils.equals(gId, "CD") ) {			// 계류의안
				int searchParamCnt = 0;
				if (StringUtils.isBlank(params.getString("cmitCd")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("billName")))		searchParamCnt++;
				
				if ( searchParamCnt > 1 ) {
					throw new ServiceException("1가지 이상 조회조건을 입력하세요.");
				}
				map.put("header", new ArrayList<String>(Arrays.asList("의안번호", "위원회", "의안명", "제안자구분", "제안자", "제안일자")));
				map.put("colId", new ArrayList<String>(Arrays.asList("billNo", "cmitNm", "billName", "proposerKind", "proposer", "proposeDt")));
				map.put("data", bpmCmpDao.searchCmpMoob(params));
			}
			else if ( StringUtils.equals(gId, "CE") ) {			// 위원회 자료실 
				int searchParamCnt = 0;
				if (StringUtils.isBlank(params.getString("siteId")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("frCreateDt")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("toCreateDt")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("articleTitle")))		searchParamCnt++;
				
				if ( searchParamCnt > 2 ) {
					throw new ServiceException("2가지 이상 조회조건을 입력하세요.");
				}

				map.put("header", new ArrayList<String>(Arrays.asList("위원회명", "제목", "작성일")));
				map.put("colId", new ArrayList<String>(Arrays.asList("writerNm", "articleTitle", "createDt")));
				map.put("data", bpmCmpDao.searchCmpRefR(params));
			}
			else if ( StringUtils.equals(gId, "CF") ) {			// 위원회 회의록
				int searchParamCnt = 0;
				if (StringUtils.isBlank(params.getString("unitCd")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("frConfDate")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("toConfDate")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("className")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("title")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("commName")))		searchParamCnt++;
				if (StringUtils.isBlank(params.getString("subName")))		searchParamCnt++;
				
				if ( searchParamCnt > 4 ) {
					throw new ServiceException("2가지 이상 조회조건을 입력하세요.");
				}
				map.put("header", new ArrayList<String>(Arrays.asList("일시", "회의명", "안건", "회의록", "영산회의록", "요약정보")));
				map.put("colId", new ArrayList<String>(Arrays.asList("daeNum", "confDate", "className", "commName", "title", "subName")));
				map.put("data", bpmCmpDao.searchCmpReport(params));
			}
		}
		
		
		return map;
	}

	@Override
	public Map<String, Object> setDateData(Params params) {
		String gId = params.getString("gubunId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if ( StringUtils.equals(gId, "DA") ) {			// 날짜별 의정활동 공걔
			int searchParamCnt = 0;
			if (StringUtils.isNotBlank(params.getString("stage")))		searchParamCnt++;
			if (StringUtils.isNotBlank(params.getString("actStatus")))	searchParamCnt++;
			if (StringUtils.isNotBlank(params.getString("committee")))	searchParamCnt++;
			if (StringUtils.isNotBlank(params.getString("frDt")))		searchParamCnt++;
			if (StringUtils.isNotBlank(params.getString("toDt")))		searchParamCnt++;
			if (StringUtils.isNotBlank(params.getString("billNm")))		searchParamCnt++;
			
			if ( searchParamCnt < 1 ) {
				throw new ServiceException("2가지 이상 조회조건을 입력하세요.");
			}
			map.put("header", new ArrayList<String>(Arrays.asList("일자", "의정활동 구분", "단계", "의안명(국정감사명)", "세부단계", "소관위원회명", "처리상태")));
			map.put("colId", new ArrayList<String>(Arrays.asList("dt", "billKind", "stage", "billNm", "dtlStage", "committee","actStatus")));
			map.put("data", bpmDateDao.searchDate(params));
		}
		
		return map;
	}

	@Override
	public Map<String, Object> setCohData(Params params) {
		
		String gId = params.getString("gubunId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if ( StringUtils.equals(gId, "HA") ) {			// 인사청문회
			map.put("header", new ArrayList<String>(Arrays.asList("직위정보", "후보자명", "소관위원회", "제안일자", "소관위 회부일", "소관위 상정일", "소관위 처리일", "처리결과")));
			map.put("colId", new ArrayList<String>(Arrays.asList("appointGrade", "appointName", "currCommiittee", "proposeDt", "submitDt", "presentDt", "procDt", "procResult")));
			map.put("data", bpmCohDao.searchCoh(params));
		}
		
		return map;
	}

	@Override
	public Map<String, Object> setPetData(Params params) {
		String gId = params.getString("gubunId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if ( StringUtils.equals(gId, "EA") ) {			// 국회의원 청원
			map.put("header", new ArrayList<String>(Arrays.asList("구분", "청원번호","청원명" ,"청원인", "소개의원", "접수일", "회부일", "소관위원회", "의결일자", "의결결과")));
			map.put("colId", new ArrayList<String>(Arrays.asList("passGubun", "billNo", "billName", "proposer", "approver", "proposeDt","committeeDt", "cmitNm", "procDt", "procResultCd")));
			map.put("data", bpmPetDao.searchPetAssmMemb(params));
		}
		else if ( StringUtils.equals(gId, "EB") ) {			// 국민동의 청원
			map.put("header", new ArrayList<String>(Arrays.asList("구분", "청원번호","청원명" ,"청원인", "접수일", "회부일", "소관위원회", "의결일자", "의결결과")));
			map.put("colId", new ArrayList<String>(Arrays.asList("passGubun", "billNo", "billName", "proposer", "proposeDt","committeeDt", "cmitNm", "procDt", "procResultCd")));
			map.put("data", bpmPetDao.searchPetAprvNa(params));
		}
		
		return map;
	}
}
