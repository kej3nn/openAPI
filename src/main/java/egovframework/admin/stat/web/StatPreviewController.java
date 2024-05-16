package egovframework.admin.stat.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.stat.service.StatPreviewService;
import egovframework.admin.stat.service.StatSttsStatService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSheetListVO;

/**
 * 관리자 표준단위 정보 클래스
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/06/28
 */

@Controller
public class StatPreviewController extends BaseController {

	@Resource(name="statPreviewService")
	protected StatPreviewService statPreviewService;
	
	@Resource(name="statSttsStatService")
	protected StatSttsStatService statSttsStatService;
	
	/**
	 * 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statPreviewPage.do")
	public String statStddUiPage(ModelMap model) {
		return "/admin/stat/statPreview";
	}
	
	@RequestMapping(value="/admin/stat/statPreviewPage/{statblId}.do")
	public String statStddUiPage(@PathVariable("statblId") String statblId, ModelMap model) {
		model.addAttribute("statblId", statblId);
		StringBuffer sb = new StringBuffer();
		sb.append("statblId=" + statblId);
		sb.append("&viewLocOpt=B");		//기본보기
		sb.append("&wrttimeType=L");	//최근시점 검색
		sb.append("&wrttimeOrder=A");	//정렬방식(오름차순)
		//sb.append("&dtadvsVal=OD");		//통계자료유형(원자료 default)
		
		Params params = new Params();
		params.set("statblId", statblId);
		
		// 증감분석 기본보기 값
		params.set("optCd", "DP");
		List<Record> resultOptDP = (List<Record>) statPreviewService.statTblOptVal(params);
		if ( resultOptDP.size() > 0 ) {
			for ( int i=0; i < resultOptDP.size(); i++) {// Record optDP : resultOptDP ) {
				sb.append("&dtadvsVal[" + i + "]=" + resultOptDP.get(i).getString("optVal") );
			}
		}
		
		params.set("optCd", "TN");
		List<Record> resultOptTN = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&wrttimeLastestVal=" + resultOptTN.get(0).getString("optVal"));			//최근시점 갯수
		
		params.set("optCd", "DC");
		List<Record> resultOptDC = (List<Record>) statPreviewService.statTblOptVal(params);
		sb.append("&dtacycleCd=" + resultOptDC.get(0).getString("optVal"));				//검색자료주기
		
		//params.set("dtacycleCd", "YY");
		params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
		List<Record> resultDta = (List<Record>) statPreviewService.statWrtTimeOption(params);
		if ( resultDta.size() > 0 ) {
			sb.append("&wrttimeMinYear=" + resultDta.get(0).getString("code"));								//기간 년도 최소값
			sb.append("&wrttimeMaxYear=" + resultDta.get(resultDta.size() - 1).getString("code"));			//기간 년도 최대값
		}
		
		getWrttimeQt(sb, resultOptDC.get(0).getString("optVal"));	//주기에 따른 시점 세팅
		
		//미리보기 조회 파라미터(처음에만 화면 로드시에만 사용)
		model.addAttribute("firParam", sb.toString());
		
		//통계표 정보 조회
		Map<String, Object> statTblDtl = statPreviewService.statTblDtl(params);
		model.addAttribute("statblNm", String.valueOf(statTblDtl.get("statblNm")));	//통계표 명
		
		//주석리스트 조회
		model.addAttribute("cmmtList", statPreviewService.statCmmtList(params));
		return "/admin/stat/stat/statPreview";
	}

	/**
	 * 자료시점 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/statWrtTimeOption.do")
    public String statWrtTimeOption(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Object result = statPreviewService.statWrtTimeOption(params);
        
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
	@RequestMapping("/admin/stat/statTblUi.do")
    public String statTblUi(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Object result = statPreviewService.statTblUi(params);
        
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
	@RequestMapping("/admin/stat/statTblDtadvs.do")
    public String statTblDataType(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Object result = statPreviewService.statTblDtadvs(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 통계표 옵션 값 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/statTblOptVal.do")
    public String statTblOptVal(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Object result = statPreviewService.statTblOptVal(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }

	/**
	 * 시트 헤더 설정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/statTblItm.do")
	public String statTblItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Map<String, Object> result = statPreviewService.statTblItm(params);
        
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
	@RequestMapping("/admin/stat/ststPreviewList.do")
	@ResponseBody
	public IBSheetListVO<Record> ststPreviewList(HttpServletRequest request, ModelMap model){
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        List<Record> list = statPreviewService.ststPreviewList(params);
        
		return new IBSheetListVO<Record>(list, list == null?0:list.size());
	}
	
	/**
	 * 통계표 항목분류 리스트 조회
	 */
	@RequestMapping("/admin/stat/statTblItmJson.do")
	public String statTblItmJson(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = statPreviewService.statTblItmJson(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
        
	}
	
	/**
	 * 통계 설명 팝업
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/popup/statMetaExpPopup.do")
	public String statMetaExpPopup(HttpServletRequest request, Model model) {
		return "/admin/stat/stat/popup/statMetaExpPopup";
	}
	
	@RequestMapping("/admin/stat/statMetaExpPopupData.do")
	public String statMetaExpPopupData(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Record statDtl = null;
        //통계표 정보 조회하여 통계설명 ID 취득
        if ( StringUtils.isEmpty(params.getString("statId")) ) {	//통계표 관리에서 통계표 ID만 넘어온 경우
        	statDtl = statPreviewService.statSttsTblDtl(params);
        	params.set("statId", statDtl.getString("statId"));
        }
		
		Object refStatList = statPreviewService.statSttsTblReferenceStatId(params);
		Object metaList = statPreviewService.statSttsStatMetaList(params);
        
		Record r = new Record();
		if ( statDtl != null ) {
			r.put("statblNm", statDtl.getString("statblNm"));	//통계표명
		} else {
			r.put("statblNm", "");
		}
		r.put("refStatList", refStatList);					//연관된 통계표 리스트
		r.put("metaList", metaList);						//메타 리스트
		
        debug("Processing results: " + r);
        
        addObject(model, r);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	@RequestMapping("/admin/stat/downloadStatMetaFile.do")
    public String downloadStatMetaFile(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 통계설명(파일형식)을 다운로드한다.
        Object result = statPreviewService.downloadStatMetaFile(params);
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "fileDownloadView";
    }
	
	/**
	 * 통계표 관리에 선택된 작성주기만 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/statCheckedDtacycleList.do")
	public String statCheckedDtacycleList(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = statPreviewService.statCheckedDtacycleList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
        
	}

	/**
	 * 주기에 따른 시점 append
	 * @param sb
	 * @param dtacycleCd
	 */
	private void getWrttimeQt(StringBuffer sb, String dtacycleCd) {
		if ( "YY".equals(dtacycleCd) ) {		//년
			sb.append("&wrttimeMinQt=00");		//기간 시점 최소값
			sb.append("&wrttimeMaxQt=00");		//기간 시점 최대값
		} else if ( "HY".equals(dtacycleCd) ) {	//반기
			sb.append("&wrttimeMinQt=01");
			sb.append("&wrttimeMaxQt=02");
		} else if ( "QY".equals(dtacycleCd) ) {	//분기
			sb.append("&wrttimeMinQt=01");
			sb.append("&wrttimeMaxQt=04");
		} else if ( "MM".equals(dtacycleCd) ) {	//월
			sb.append("&wrttimeMinQt=01");
			sb.append("&wrttimeMaxQt=12");
		}
	}
	
}
