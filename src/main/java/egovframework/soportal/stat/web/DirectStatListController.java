package egovframework.soportal.stat.web;

import java.io.PrintWriter;
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

import egovframework.admin.stat.service.StatPreviewService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSheetListVO;
import egovframework.soportal.stat.service.DirectStatListService;
import egovframework.soportal.stat.service.StatListService;
import egovframework.soportal.stat.service.StatPortalDownService;

/**
 * 사용자 표준단위 정보 클래스
 * 
 * @author 	소프트온
 * @version	1.0
 * @since	2018/06/21
 */

@Controller
public class DirectStatListController extends BaseController {

	protected static final Log logger = LogFactory.getLog(DirectStatListController.class);

	@Resource(name="statListService")
	protected StatListService statListService;
	
	@Resource(name="statPreviewService")
	protected StatPreviewService statPreviewService;
	
	@Resource(name="directStatListService")
	protected DirectStatListService directStatListService;
	
	@Resource(name="statPortalDownService")
	protected StatPortalDownService statPortalDownService;

	/**
	 * 통계조회[NABO] 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/directStatPage.do")
	public String directStatPage(ModelMap model
			, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq
			, @RequestParam(value="searchVal", required=false) String searchVal) {
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
			model.addAttribute("searchVal", searchVal);
		}
		model.addAttribute("searchVal", searchVal);
		
		// 모바일 통계주제 세팅(selectbox)
		Params cateParam = new Params();
		cateParam.put("statGb", "SUBJ");
		model.addAttribute("cateTopList", statListService.statCateTopList(cateParam));
		
		return "/soportal/stat/directStatSch";
	}	
	
	@RequestMapping(value="/portal/stat/directStatPage/{statblId}.do")
	public String directStatPage(@PathVariable("statblId") String statblId, ModelMap model) {
		model.addAttribute("statblId", statblId);
		model.addAttribute("directType", "directType");
		
		// 모바일 통계주제 세팅(selectbox)
		Params cateParam = new Params();
		cateParam.put("statGb", "SUBJ");
		model.addAttribute("cateTopList", statListService.statCateTopList(cateParam));
		
		// 카테고리정보(최상위 카테고리ID)
		Record cateInfo = statListService.selectSttsCateInfo(statblId);
		model.addAttribute("treeCateId", cateInfo.getInt("topCateId"));
		model.addAttribute("statGb", "SUBJ");
				
		return "/soportal/stat/directStatSch";
	}
	
	/**
	 * 통계조회 시트 설정 정보 데이터를 가져온다.
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/directStatTblItm.do")
	public String directStatTblItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        directStatTblParam(params);
        
        Map<String, Object> result = statListService.statTblItm(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 통계조회 시트 데이터를 가져온다.
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/directStstPreviewList.do")
	@ResponseBody
	public IBSheetListVO<Record> directStstPreviewList(HttpServletRequest request, ModelMap model){
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        directStatTblParam(params);
        
        List<Record> list = statListService.ststPreviewList(params);
        
		return new IBSheetListVO<Record>(list, list == null?0:list.size());
	}
	
	/**
	 * 시트 조회시 기본보기 파라미터를 세팅한다.
	 * @param params
	 */
	private void directStatTblParam(Params params) {
		params.set("viewLocOpt", "B");
		params.set("wrttimeType", "L");
		//params.set("wrttimeOrder", "A");
		params.set("dtadvsVal", "OD");
		
		
		Params optParam = new Params();
		
		optParam.set("statblId", params.getString("statblId"));
		
		//최근시점 갯수
		optParam.set("optCd", "TN");
		List<Record> resultOptTN = (List<Record>) statPreviewService.statTblOptVal(optParam);
		params.set("wrttimeLastestVal", resultOptTN.get(0).getString("optVal"));	
		
		// 검색자료주기(오름/내림)
		optParam.set("optCd", "TO");
		List<Record> resultOptTO = (List<Record>) statPreviewService.statTblOptVal(optParam);
		params.set("wrttimeOrder", ( resultOptTO.size() > 0 ? resultOptTO.get(0).getString("optVal") : "A" ));				
		
		// 주기
		optParam.set("optCd", "DC");
		List<Record> resultOptDC = (List<Record>) statPreviewService.statTblOptVal(optParam);
		params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
		
		// 시점
		optParam.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
		List<Record> resultDta = (List<Record>) statListService.statWrtTimeOption(optParam);
		if ( resultDta.size() > 0 ) {
			params.set("wrttimeMinYear", resultDta.get(0).getString("code"));								//기간 년도 최소값
			params.set("wrttimeMaxYear", resultDta.get(resultDta.size() - 1).getString("code"));			//기간 년도 최대값
		}
		
		String dtacycleCd = resultOptDC.get(0).getString("optVal");
		if ( "YY".equals(dtacycleCd) ) {		//년
			params.set("wrttimeStartQt", "00");	//기간 시점 시작값
			params.set("wrttimeEndQt", "00");		//기간 시점 종료값
			params.set("wrttimeMinQt", "00");		//기간 시점 최소값
			params.set("wrttimeMaxQt", "00");		//기간 시점 최대값
		} else if ( "HY".equals(dtacycleCd) ) {	//반기
			params.set("wrttimeStartQt", "01");	//기간 시점 시작값
			params.set("wrttimeEndQt", "02");		//기간 시점 종료값
			params.set("wrttimeMinQt", "01");
			params.set("wrttimeMaxQt", "02");
		} else if ( "QY".equals(dtacycleCd) ) {	//분기
			params.set("wrttimeStartQt", "01");	//기간 시점 시작값
			params.set("wrttimeEndQt", "04");		//기간 시점 종료값
			params.set("wrttimeMinQt", "01");
			params.set("wrttimeMaxQt", "04");
		} else if ( "MM".equals(dtacycleCd) ) {	//월
			params.set("wrttimeStartQt", "01");	//기간 시점 시작값
			params.set("wrttimeEndQt", "12");		//기간 시점 종료값
			params.set("wrttimeMinQt", "01");
			params.set("wrttimeMaxQt", "12");
		}
	}
	
	/**
	 * 게시판 통계표 컨텐츠를 가져온다.
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/selectContBbsTbl.do")
	public String selectContBbsTbl(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = directStatListService.selectContBbsTbl(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}

	/**
	 * 게시판 통계표 컨텐츠 목록을 가져온다(용어설명)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/selectContBbsTblList.do")
	public String selectContBbsTblList(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = directStatListService.selectContBbsTblList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 게시판 통계표 컨텐츠 파일목록을 가져온다.
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/selectContBbsFileList.do")
	public String selectContBbsFileList(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = directStatListService.selectContBbsFileList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 게시판 통계표 컨텐츠 링크목록을 가져온다.
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/selectContBbsLinkList.do")
	public String selectContBbsLinkList(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = directStatListService.selectContBbsLinkList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 엑셀 파일을 다운로드 한다.
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value="/portal/stat/directDown2Excel.do")
	public void down2Excel(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			directStatTblParam(params);
			statPortalDownService.portalDown2Excel(request, response, params);
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
	 * CSV 파일을 다운로드 한다.
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value="/portal/stat/directDown2Csv.do")
	public void down2csv(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			directStatTblParam(params);
			statPortalDownService.portalDown2Csv(request, response, params);
		} catch (DataAccessException e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			writer.println("<script>alert('다운로드중 에러가 발생하였습니다.'); history.back();</script>");
			EgovWebUtil.exLogging(e);
		}  catch (Error e) {
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
	@RequestMapping(value="/portal/stat/directDown2Text.do")
	public void down2Text(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			directStatTblParam(params);
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
	@RequestMapping(value="/portal/stat/directDown2Xml.do")
	public void down2Xml(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			directStatTblParam(params);
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
	@RequestMapping(value="/portal/stat/directDown2Json.do")
	public void down2Json(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, false);
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			directStatTblParam(params);
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
	
}