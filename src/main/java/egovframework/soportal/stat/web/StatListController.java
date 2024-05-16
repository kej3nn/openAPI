package egovframework.soportal.stat.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.stat.service.StatPreviewService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.portal.infs.service.PortalInfsListService;
import egovframework.soportal.stat.service.StatListService;
import egovframework.soportal.stat.service.StatPortalDownService;

/**
 * 사용자 표준단위 정보 클래스
 * 
 * @author 	소프트온
 * @version	1.0
 * @since	2017/09/11
 */

@Controller
public class StatListController extends BaseController {

	protected static final Log logger = LogFactory.getLog(StatListController.class);
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource(name="statListService")
	protected StatListService statListService;
	
	@Resource(name="statPortalDownService")
	protected StatPortalDownService statPortalDownService;
	
	@Resource(name="statPreviewService")
	protected StatPreviewService statPreviewService;
	
	@Resource(name="portalInfsListService")
	protected PortalInfsListService portalInfsListService;

	/**
	 * 공통코드 값을 조회한다.
	 */
	@RequestMapping("/portal/stat/statOption.do")
    public String statOption(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.selectOption(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 통계 공통코드 값을 조회한다.
	 */
	@RequestMapping("/portal/stat/statSTTSOption.do")
    public String statSTTSOption(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.selectSTTSOption(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
    }
	
	/**
	 * 통계표 검색주기 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/statDtacycleList.do")
    public String statDtacycleList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.statDtacycleList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }

	/**
	 * 자료시점 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/statWrtTimeOption.do")
    public String statWrtTimeOption(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.statWrtTimeOption(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }

	/**
	 * 자료시점 조회[월/분기 시작년월/분기 및 종료년월/분기]
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/statQrtTimeOption.do")
    public String statQrtTimeOption(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.statQrtTimeOption(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 통계표 단위 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/statTblUi.do")
    public String statTblUi(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.statTblUi(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }

	/**
	 * 통계표 통계자료유형 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/statTblDtadvs.do")
    public String statTblDataType(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.statTblDtadvs(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 간편검색 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/easyStatPage.do")
	public String easyStatPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		/*
		if ( StringUtils.isNotEmpty(usrTblSeq) ) {
			//통계스크랩 파라미터가 넘어온 경우
			Params params = new Params();
			params.set("seqceNo", Integer.parseInt(usrTblSeq));
			// 통계스크랩 마스터 정보 조회 
			Record usrTbl = statListService.statUserTbl(params);
			if ( usrTbl != null && model != null ) {
				model.addAttribute("searchType", "U");
				model.addAttribute("firParam", usrTbl.getString("firParam"));
				model.addAttribute("statblId", usrTbl.getString("statblId"));
			}
			else {
				model.addAttribute("searchType", "");
			}
			model.addAttribute("searchVal", "주택1");
		}
		model.addAttribute("searchVal", "주택2");
		*/
		// 모바일 통계주제 세팅(selectbox)
		Params cateParam = new Params();
		cateParam.put("statGb", "SUBJ");
		model.addAttribute("cateTopList", statListService.statCateTopList(cateParam));
		
		return "/soportal/stat/easyStatSch";
	}
	
	@RequestMapping("/portal/stat/easyStat2Page.do")
	public String easyStat2Page(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		if ( StringUtils.isNotEmpty(usrTblSeq) ) {
			//통계스크랩 파라미터가 넘어온 경우
			Params params = new Params();
			params.set("seqceNo", Integer.parseInt(usrTblSeq));
			/* 통계스크랩 마스터 정보 조회 */
			Record usrTbl = statListService.statUserTbl(params);
			if (model != null) {
				if (usrTbl != null) {
					model.addAttribute("searchType", "U");
					model.addAttribute("firParam", usrTbl.getString("firParam"));
					model.addAttribute("statblId", usrTbl.getString("statblId"));
				}
				else {
					model.addAttribute("searchType", "");
				}
				model.addAttribute("searchVal", "주택1");
			}
		}
		if (model != null) {
			model.addAttribute("searchVal", "주택2");
		}

		// 모바일 통계주제 세팅(selectbox)
		Params cateParam = new Params();
		cateParam.put("statGb", "SUBJ");
		if (model != null) {
			model.addAttribute("cateTopList", statListService.statCateTopList(cateParam));
		}

		return "/soportal/stat/easyStatSch2";
	}	
	
	/**
	 * 간편검색 통계표 목록 조회 
	 */
	@RequestMapping(value="/portal/stat/easyStatList.do")
	public String statEasyList(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = statListService.statEasyList(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 메인화면 모바일 리스트 조회
	 */
	@RequestMapping(value="/portal/stat/easyStatMobileList.do")
	public String easyStatMobileList(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = statListService.statMobileListPaging(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 통계표 목록 조회 OpenApi 엑셀다운로드 전달 
	 */
	@RequestMapping("/portal/stat/easyStatApiExcel.do")
	public ModelAndView easyStatApiExcel(HttpServletRequest request, Model model) {
		ModelAndView modelAndView = new ModelAndView();
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = statListService.statEasyList(params);
        
        // 모델에 객체를 추가한다.
		modelAndView.addObject("result",result);
		modelAndView.addObject("downGubun", "API");
		modelAndView.setViewName("/hfportal/include/excelDownload");
		return modelAndView;
	}
	
	/**
	 * 메인화면 검색결과 리스트 조회
	 */
	@RequestMapping(value="/portal/stat/easyStatSearchList.do")
	public String easyStatSearchList(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = statListService.statEasySearchList(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
		
	/**
	 * 통계표 ID로 접근한 경우
	 */
	@RequestMapping(value="/portal/stat/easyStatPage/{statblId}.do")
	public String easyStatPage(@PathVariable("statblId") String statblId, ModelMap model) {
		model.addAttribute("statblId", statblId);
		model.addAttribute("directType", "directEasyType");
		StringBuffer sb = new StringBuffer();
		sb.append("statblId=" + statblId);
		sb.append("&viewLocOpt=B");		//기본보기
		sb.append("&wrttimeType=L");	//최근시점 검색
		//sb.append("&wrttimeOrder=A");	//정렬방식(오름차순)
		sb.append("&dtadvsVal=OD");		//통계자료유형(최초 원자료만 조회)
		
		Params params = new Params();
		params.set("statblId", statblId);
		params.set("optCd", "TN");
		List<Record> resultOptTN = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&wrttimeLastestVal=" + resultOptTN.get(0).getString("optVal"));			//최근시점 갯수
		
		params.set("optCd", "TO");
		List<Record> resultOptTO = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&wrttimeOrder=" + (resultOptTO.size() > 0 ? resultOptTO.get(0).getString("optVal") : "A"));				// 검색자료주기(오름/내림)
		
		params.set("optCd", "DC");
		List<Record> resultOptDC = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&dtacycleCd=" + resultOptDC.get(0).getString("optVal"));				//검색자료주기
		
		//params.set("dtacycleCd", "YY");
		params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
		List<Record> resultDta = (List<Record>) statListService.statWrtTimeOption(params);
		if ( resultDta.size() > 0 ) {
			sb.append("&wrttimeMinYear=" + resultDta.get(0).getString("code"));								//기간 년도 최소값
			sb.append("&wrttimeMaxYear=" + resultDta.get(resultDta.size() - 1).getString("code"));			//기간 년도 최대값
		}
		
		getWrttimeQt(sb, resultOptDC.get(0).getString("optVal"));	//주기에 따른 시점 세팅
		
		//미리보기 조회 파라미터(처음에만 화면 로드시에만 사용)
		model.addAttribute("firParam", sb.toString());
		
		model.addAttribute("searchType", "S");
		
		//통계표 정보 조회
		Map<String, Object> statTblDtl = statPreviewService.statTblDtl(params);
		model.addAttribute("statblNm", String.valueOf(statTblDtl.get("statblNm")));	//통계표 명
		
		model.addAttribute("searchVal", "주택");
		
		//주석리스트 조회
		model.addAttribute("cmmtList", statPreviewService.statCmmtList(params));
		return "/soportal/stat/easyStatSch";
	}
	
	/**
	 * 통계표 ID로 접근한 경우(간편통계 팝업)
	 */
	@RequestMapping(value="/portal/stat/selectServicePage.do/{statblId}")
	public String selectServicePage(@PathVariable("statblId") String statblId, HttpServletRequest request, Model model) {

		/* sheet인지 chart인지 구분값 전달 */
		String callStatType = "S"; //default 시트
		if(statblId.length() > 16){
			callStatType = statblId.substring(16);
			statblId = statblId.substring(0, 16);
		}
		model.addAttribute("callStatType", callStatType); //시트인지 차트인지 정보전달
		
		model.addAttribute("statblId", statblId);
		model.addAttribute("directType", "directEasyType");
		StringBuffer sb = new StringBuffer();
		sb.append("statblId=" + statblId);
		sb.append("&viewLocOpt=B");		//기본보기
		sb.append("&wrttimeType=L");	//최근시점 검색
		//sb.append("&wrttimeOrder=A");	//정렬방식(오름차순)
		sb.append("&dtadvsVal=OD");		//통계자료유형(최초 원자료만 조회)
		
		Params params = new Params();
		params.set("statblId", statblId);
		params.set("optCd", "TN");
		List<Record> resultOptTN = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&wrttimeLastestVal=" + resultOptTN.get(0).getString("optVal"));			//최근시점 갯수
		
		params.set("optCd", "TO");
		List<Record> resultOptTO = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&wrttimeOrder=" + (resultOptTO.size() > 0 ? resultOptTO.get(0).getString("optVal") : "A"));				// 검색자료주기(오름/내림)
		
		params.set("optCd", "DC");
		List<Record> resultOptDC = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&dtacycleCd=" + resultOptDC.get(0).getString("optVal"));				//검색자료주기
		
		//params.set("dtacycleCd", "YY");
		params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
		List<Record> resultDta = (List<Record>) statListService.statWrtTimeOption(params);
		if ( resultDta.size() > 0 ) {
			sb.append("&wrttimeMinYear=" + resultDta.get(0).getString("code"));								//기간 년도 최소값
			sb.append("&wrttimeMaxYear=" + resultDta.get(resultDta.size() - 1).getString("code"));			//기간 년도 최대값
		}
		
		getWrttimeQt(sb, resultOptDC.get(0).getString("optVal"));	//주기에 따른 시점 세팅
		
		//미리보기 조회 파라미터(처음에만 화면 로드시에만 사용)
		model.addAttribute("firParam", sb.toString());
		
		model.addAttribute("searchType", "S");
		
		//통계표 정보 조회
		Map<String, Object> statTblDtl = statPreviewService.statTblDtl(params);
		model.addAttribute("statblNm", String.valueOf(statTblDtl.get("statblNm")));	//통계표 명
		
		//주석리스트 조회
		model.addAttribute("cmmtList", statPreviewService.statCmmtList(params));
		
		// 파라미터 유지 여부
		Params reqParams = getParams(request, false);
		String isKeepSchParam = reqParams.getString("isKeepSchParam");
		model.addAttribute("isKeepSchParam", isKeepSchParam);
		
		// 파라미터 유지(sch, schHdn으로 넘어오는 것들)
		if ( StringUtils.equals("Y", isKeepSchParam) ) {
		}
		portalInfsListService.keepSearchParam(reqParams, model);
		
		model.addAttribute("meta", statListService.selectSttsMeta(params));
		
		return "/soportal/stat/easyStatSchInfs";
	}

	/**
	 * 통계표 ID로 접근한 경우 [메인화면에서 호출할 경우]
	 */
	@RequestMapping(value="/portal/stat/mainStatPage/{statblId}.do")
	public String mainStatPage(@PathVariable("statblId") String statblId, ModelMap model) {
		model.addAttribute("statblId", statblId);
		StringBuffer sb = new StringBuffer();
		sb.append("statblId=" + statblId);
		sb.append("&viewLocOpt=B");		//기본보기
		sb.append("&wrttimeType=L");	//최근시점 검색
		sb.append("&wrttimeOrder=A");	//정렬방식(오름차순)
		sb.append("&dtadvsVal=OD");		//통계자료유형(원자료)
		sb.append("&wrttimeLastestVal=10");	//최근시점 갯수
		
		Params params = new Params();
		params.set("statblId", statblId);
		params.set("optCd", "DC");
		List<Record> resultOptDC = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&dtacycleCd=" + resultOptDC.get(0).getString("optVal"));				//검색자료주기
		
		//params.set("dtacycleCd", "YY");
		params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
		List<Record> resultDta = (List<Record>) statListService.statWrtTimeOption(params);
		if ( resultDta.size() > 0 ) {
			sb.append("&wrttimeMinYear=" + resultDta.get(0).getString("code"));								//기간 년도 최소값
			sb.append("&wrttimeMaxYear=" + resultDta.get(resultDta.size() - 1).getString("code"));			//기간 년도 최대값
		}
		
		getWrttimeQt(sb, resultOptDC.get(0).getString("optVal"));	//주기에 따른 시점 세팅
		
		//미리보기 조회 파라미터(처음에만 화면 로드시에만 사용)
		model.addAttribute("firParam", sb.toString());
		
		model.addAttribute("searchType", "S");
		
		//통계표 정보 조회
		Map<String, Object> statTblDtl = statPreviewService.statTblDtl(params);
		model.addAttribute("statblNm", String.valueOf(statTblDtl.get("statblNm")));	//통계표 명
		
		model.addAttribute("searchVal", "주택");
		model.addAttribute("mainCall", "Y");	//메인화면에서 호출 여부
		//주석리스트 조회
		model.addAttribute("cmmtList", statPreviewService.statCmmtList(params));
		return "/soportal/stat/easyStatSch";
	}
	
	/**
	 * 전체목록 엑셀다운로드 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/easyStatListExcel.do")
	public ModelAndView statEasyExcel(HttpServletRequest request, Model model) {

		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
		ModelAndView modelAndView = new ModelAndView();              
		Object result = statListService.statEasyOriginList(params);
		
		modelAndView.addObject("result",result);
		modelAndView.setViewName("/soportal/stat/easyStatListExcel");
		return modelAndView;
	}
	
	/**
	 * 통계표 목록 상세조회
	 * @return 
	 */
	@RequestMapping("/portal/stat/selectEasyStatDtl.do")
	public String selectEasyStatDtl(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Map<String, Object> map = statListService.selectStatDtl(params);

        // 모델에 객체를 추가한다.
        addObject(model, map);
        
		return "jsonView";
	}
	
	/**
	 * 통계표 항목분류 리스트 조회
	 */
	@RequestMapping("/portal/stat/statEasyItmJson.do")
	public String statEasyItmJson(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = statListService.statItmJson(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
        
	}
	
	/**
	 * 통계표 목록 상세조회
	 */
	@RequestMapping("/portal/stat/selectStatEasyDtl.do")
	public String selectStatEasyDtl(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        debug("Request parameters: " + params);
        Object result = statListService.statEasyList(params);
        // 모델에 객체를 추가한다.
        addObject(model, result);
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 통계표 시트 헤더 설정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/statTblItm.do")
	public String statTblItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Map<String, Object> result = statListService.statTblItm(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 시트 미리보기 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/ststPreviewList.do")
	@ResponseBody
	public IBSheetListVO<Record> ststPreviewList(HttpServletRequest request, ModelMap model){
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        List<Record> list = statListService.ststPreviewList(params);
        
		return new IBSheetListVO<Record>(list, list == null?0:list.size());
	}
	
	/**
	 * 엑셀 파일을 다운로드 한다.
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value="/portal/stat/down2Excel.do")
	public void down2Excel(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			statPortalDownService.portalDown2Excel(request, response, params);
		} catch (DataAccessException e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); return false;</script>");
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); return false;</script>");
			EgovWebUtil.exLogging(e);
		} catch (Error e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); return false;</script>");
			EgovWebUtil.exLogging(e);
		}
	}
	
	/**
	 * CSV 파일을 다운로드 한다.
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value="/portal/stat/down2Csv.do")
	public void down2csv(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			statPortalDownService.portalDown2Csv(request, response, params);
		} catch (DataAccessException e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Error e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		}
	}
	
	/**
	 * TEXT 파일을 다운로드 한다.
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value="/portal/stat/down2Text.do")
	public void down2Text(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			statPortalDownService.portalDown2Text(request, response, params);
		} catch (DataAccessException e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Error e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		}
	}
	
	/**
	 * XML 파일을 다운로드 한다.
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value="/portal/stat/down2Xml.do")
	public void down2Xml(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			statPortalDownService.portalDown2Xml(request, response, params);
		} catch (DataAccessException e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Error e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		}
	}
	
	/**
	 * JSON 파일을 다운로드 한다.
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value="/portal/stat/down2Json.do")
	public void down2Json(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			statPortalDownService.portalDown2Json(request, response, params);
		} catch (DataAccessException e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Error e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		}
	}
	
	/**
	 * 주기에 따른 시점 append
	 * @param sb
	 * @param dtacycleCd
	 */
	public static void getWrttimeQt(StringBuffer sb, String dtacycleCd) {
		if ( "YY".equals(dtacycleCd) ) {		//년
			sb.append("&wrttimeStartQt=00");	//기간 시점 시작값
			sb.append("&wrttimeEndQt=00");		//기간 시점 종료값
			sb.append("&wrttimeMinQt=00");		//기간 시점 최소값
			sb.append("&wrttimeMaxQt=00");		//기간 시점 최대값
		} else if ( "HY".equals(dtacycleCd) ) {	//반기
			sb.append("&wrttimeStartQt=01");	//기간 시점 시작값
			sb.append("&wrttimeEndQt=02");		//기간 시점 종료값
			sb.append("&wrttimeMinQt=01");
			sb.append("&wrttimeMaxQt=02");
		} else if ( "QY".equals(dtacycleCd) ) {	//분기
			sb.append("&wrttimeStartQt=01");	//기간 시점 시작값
			sb.append("&wrttimeEndQt=04");		//기간 시점 종료값
			sb.append("&wrttimeMinQt=01");
			sb.append("&wrttimeMaxQt=04");
		} else if ( "MM".equals(dtacycleCd) ) {	//월
			sb.append("&wrttimeStartQt=01");	//기간 시점 시작값
			sb.append("&wrttimeEndQt=12");		//기간 시점 종료값
			sb.append("&wrttimeMinQt=01");
			sb.append("&wrttimeMaxQt=12");
		}
	}
	
	/**
	 * 통계스크랩 등록
	 */
	@RequestMapping("/portal/stat/insertStatUserTbl.do")
    public String insertStatUserTbl(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        Object result = statListService.saveStatUserTbl(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
    }
	
	/**
	 * 통계스크랩 수정
	 */
	@RequestMapping("/portal/stat/updateStatUserTbl.do")
    public String updateStatUserTbl(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        Object result = statListService.saveStatUserTbl(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
    }
	
	/**
	 * 메타데이터 확인 로그
	 */
	@RequestMapping("/portal/stat/insertLogSttsStat.do")
	@ResponseBody
    public void insertLogSttsStat(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        statListService.insertLogSttsStat(params);
    }
	
	/**
	 * 통계표 열람 로그
	 */
	@RequestMapping("/portal/stat/insertLogSttsTbl.do")
	@ResponseBody
    public void insertLogSttsTbl(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        statListService.insertLogSttsTbl(params);
    }

	
	/**
	 * 통계표 다운로드(HWP) 로그
	 * @throws Exception 
	 */
	@RequestMapping("/portal/stat/insertLogSttsHwp.do")
	@ResponseBody
    public void insertLogSttsHwp(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        /* 통계표 변환저장 로그 기록 */
		params.set("saveExt", "HWP");
		try {
			statPortalDownService.portalDown2Hwp(request, params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
    }
	
	/**
	 * 통계주제 최상위 레벨
	 */
	@RequestMapping("/portal/stat/statCateTopList.do")
    public String statCateTopList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.statCateTopList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }

	/**
	 * 통계표이력 검색주기 조회 
	 */
	@RequestMapping("/portal/stat/statHistDtacycleList.do")
    public String statHistDtacycleList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.statHistDtacycleList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }

	/**
	 * 통계표 이력 주기 리스트 조회
	 */
	@RequestMapping("/portal/stat/statHisSttsCycleList.do")
    public String statHisSttsCycleList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.statHisSttsCycleList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 간편검색 페이지 이동(영문)
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/easyStatEngPage.do")
	public String easyStatEngPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		if ( StringUtils.isNotEmpty(usrTblSeq) ) {
			//통계스크랩 파라미터가 넘어온 경우
			Params params = new Params();
			params.set("seqceNo", Integer.parseInt(usrTblSeq));
			/* 통계스크랩 마스터 정보 조회 */
			Record usrTbl = statListService.statUserTbl(params);
			if ( usrTbl != null ) {
				if(model != null) model.addAttribute("searchType", "U");
				if(model != null) model.addAttribute("firParam", usrTbl.getString("firParam"));
				if(model != null) model.addAttribute("statblId", usrTbl.getString("statblId"));
			}
			else {
				model.addAttribute("searchType", "");
			}
		}
		
		// 모바일 통계주제 세팅(selectbox)
		Params cateParam = new Params();
		cateParam.put("statGb", "SUBJ");
		model.addAttribute("cateTopList", statListService.statCateTopList(cateParam));
		return "/soportal/stat/easyStatEngSch";
	}	
	
	/**
	 * 통계표 ID로 접근한 경우
	 */
	@RequestMapping(value="/portal/stat/easyStatEngPage/{statblId}.do")
	public String easyStatEngPage(@PathVariable("statblId") String statblId, ModelMap model) {
		model.addAttribute("statblId", statblId);
		StringBuffer sb = new StringBuffer();
		sb.append("statblId=" + statblId);
		sb.append("&viewLocOpt=B");		//기본보기
		sb.append("&wrttimeType=L");	//최근시점 검색
		sb.append("&wrttimeOrder=A");	//정렬방식(오름차순)
		sb.append("&dtadvsVal=OD");		//통계자료유형(최초 원자료만 조회)
		sb.append("&langGb=ENG");		//
		
		Params params = new Params();
		params.set("statblId", statblId);
		params.set("optCd", "TN");
		List<Record> resultOptTN = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&wrttimeLastestVal=" + resultOptTN.get(0).getString("optVal"));			//최근시점 갯수
		
		params.set("optCd", "DC");
		List<Record> resultOptDC = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&dtacycleCd=" + resultOptDC.get(0).getString("optVal"));				//검색자료주기
		
		//params.set("dtacycleCd", "YY");
		params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
		List<Record> resultDta = (List<Record>) statListService.statWrtTimeOption(params);
		if ( resultDta.size() > 0 ) {
			sb.append("&wrttimeMinYear=" + resultDta.get(0).getString("code"));								//기간 년도 최소값
			sb.append("&wrttimeMaxYear=" + resultDta.get(resultDta.size() - 1).getString("code"));			//기간 년도 최대값
		}
		
		getWrttimeQt(sb, resultOptDC.get(0).getString("optVal"));	//주기에 따른 시점 세팅
		
		//미리보기 조회 파라미터(처음에만 화면 로드시에만 사용)
		model.addAttribute("firParam", sb.toString());
		
		model.addAttribute("searchType", "S");
		
		//통계표 정보 조회
		Map<String, Object> statTblDtl = statPreviewService.statTblDtl(params);
		model.addAttribute("statblNm", String.valueOf(statTblDtl.get("statblNm")));	//통계표 명
		
		//주석리스트 조회
		model.addAttribute("cmmtList", statPreviewService.statCmmtList(params));
		return "/soportal/stat/easyStatEngSch";
	}
	
	/**
	 * 간편통계 시트 셀 제한시 다운로드(대용량)
	 */
	@RequestMapping("/portal/stat/downloadStatSheetData.do")
	public void downloadStatSheetData(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        statListService.downloadStatSheetDataCUD(request, response, params);
	}

	/**
	 * 통계설명 자료 데이터 호출
	 */
	@RequestMapping("/portal/stat/selectContentsList.do")
    public String selectContentsList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.selectContentsList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";

	}

	/**
	 * 통계설명 자료 데이터 호출(파일다운로드 목록)
	 */
	@RequestMapping("/portal/stat/selectContentsFileList.do")
    public String selectContentsFileList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.selectContentsFileList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";

	}

	/**
	 * 통계컨텐츠 정보 데이터 호출
	 */
	@RequestMapping("/portal/stat/selectContentsNabo.do")
    public String selectContentsNabo(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.selectContentsNabo(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";

	}

	/**
	 * 통계컨텐츠 정보 목록 리스트만 호출
	 */
	@RequestMapping("/portal/stat/selectContentsNaboList.do")
    public String selectContentsNaboList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.selectContentsNaboList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";

	}

	/**
	 * 통계 컨턴츠 상세분석 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/selectDtlAnalysisList.do")
    public String selectDtlAnalysisList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.selectDtlAnalysisList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";

	}
	
	/**
	 * 주석을 조회한다.
	 */
	@RequestMapping("/portal/stat/selectStatCmmtList.do")
    public String selectStatCmmtList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.selectStatCmmtList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";

	}
	
	/**
	 * 평가점수를 등록한다.
	 */
	@RequestMapping("/portal/stat/insertSttsTblAppr.do")
    public String insertSttsTblAppr(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = statListService.insertSttsTblAppr(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
}