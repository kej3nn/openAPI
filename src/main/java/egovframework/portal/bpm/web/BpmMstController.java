package egovframework.portal.bpm.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmMemberService;
import egovframework.portal.bpm.service.BpmDownService;

@Controller
public class BpmMstController extends BaseController {
	
	/**
	 * 구분코드 맵
	 */
	public static final Map<String, String> GUBUN_NAMES = new HashMap<String, String>();
	static {
		// 본회의 안건처리
		GUBUN_NAMES.put("PA", "");	// 본회의 일정		
		GUBUN_NAMES.put("PB", "");	// 본회의 안건처리
		GUBUN_NAMES.put("PC", "");	// 본회의 회의록
		
		// 위원회
		GUBUN_NAMES.put("CA", "");		// 위원회 구성		
		GUBUN_NAMES.put("CB", "CB");	// 위원회 명단
		GUBUN_NAMES.put("CC", "");	// 위원회 일정
		GUBUN_NAMES.put("CD", "");	// 계류법안
		GUBUN_NAMES.put("CE", "");	// 위원회 자료실
		GUBUN_NAMES.put("CF", "");	// 위원회 회의록
		
		// 날짜별 의정활동 공개
		GUBUN_NAMES.put("DA", "");	// 날짜별 의정활동 공개
		
		// 인사청문회
		GUBUN_NAMES.put("HA", "");
		
		// 청원
		GUBUN_NAMES.put("EA", "");	// 국회의원 청원
		GUBUN_NAMES.put("EB", "");	// 국민동의 청원
	}
	
	/**
	 * 구분코드 맵
	 */
	public static final Map<String, String> GUBUN_NAMES_TXT = new HashMap<String, String>();
	static {
		// 본회의 안건처리
		GUBUN_NAMES_TXT.put("PA", "본회의 일정");	// 본회의 일정		
		GUBUN_NAMES_TXT.put("PB", "본회의 안건처리");	// 본회의 안건처리
		GUBUN_NAMES_TXT.put("PC", "본회의 회의록");	// 본회의 회의록
		           
		// 위원회     
		GUBUN_NAMES_TXT.put("CA", "위원회 현황");		// 위원회 구성		
		GUBUN_NAMES_TXT.put("CB", "위원회 명단");	// 위원회 명단
		GUBUN_NAMES_TXT.put("CC", "위원회 일정");		// 위원회 일정
		GUBUN_NAMES_TXT.put("CD", "계류의안");	// 계류법안
		GUBUN_NAMES_TXT.put("CE", "위원회 자료실");	// 위원회 자료실
		GUBUN_NAMES_TXT.put("CF", "위원회 회의록");	// 위원회 회의록
		          
		// 날짜별 의정활동 공개
		GUBUN_NAMES_TXT.put("DA", "날짜별 의정활동 공개");	// 날짜별 의정활동 공개
		           
		// 인사청문회      
		GUBUN_NAMES_TXT.put("HA", "인사청문회");
				
		// 청원      
		GUBUN_NAMES_TXT.put("EA", "의원소개청원");	// 의원소개 청원
		GUBUN_NAMES_TXT.put("EB", "국민동의청원");	// 국민동의 청원
	}
	
	@Resource(name="bpmDownService")
	private BpmDownService bpmDownService;
	
	@Resource(name="AssmMemberService")
	private AssmMemberService assmMemberService;
	
	@RequestMapping("/portal/bpm/downExcel.do")
	public void downExcel(HttpServletResponse response, HttpServletRequest request) {
		Params params = getParams(request, false);
		
		String gId = params.getString("gubunId");
		
		Map<String, Object> svcMap = new HashMap<String, Object>();
		
		try {
			if ( StringUtils.isNotEmpty(gId) && GUBUN_NAMES.containsKey(gId) ) {
				// 본회의
				if ( StringUtils.startsWith(gId, "P") ) {
					svcMap = bpmDownService.setPrcData(params);
				}
				// 위원회
				else if ( StringUtils.startsWith(gId, "C") ) {
					svcMap = bpmDownService.setCmpData(params);
				}
				// 날짜별 의정활동
				else if ( StringUtils.startsWith(gId, "D") ) {
					svcMap = bpmDownService.setDateData(params);
				}
				// 인사청문회
				else if ( StringUtils.startsWith(gId, "H") ) {
					svcMap = bpmDownService.setCohData(params);
				}
				// 청원
				else if ( StringUtils.startsWith(gId, "E") ) {
					svcMap = bpmDownService.setPetData(params);
				}
				
				// 의정과 국회의원 구분
				params.set("GUBUN_ASSM_BPM", "BPM");
				// 다운로드 진행
				assmMemberService.procDownloadExcel(request, response, params, svcMap);
			}
		}
		catch(ServiceException e) {
			EgovWebUtil.exLogging(e);
			throw new ServiceException(e.getMessage());
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
}
