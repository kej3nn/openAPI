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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.soportal.stat.service.MultiStatListService;
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
public class MultiStatListController extends BaseController {

	protected static final Log logger = LogFactory.getLog(MultiStatListController.class);
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource(name="multiStatListService")
	protected MultiStatListService multiStatListService;
	
	@Resource(name="statPortalDownService")
	protected StatPortalDownService statPortalDownService;

	@Resource(name="statListService")
	protected StatListService statListService;
	
	/**
	 * 복수통계 화면 유형 구분키
	 */
	public static final String MULTI_STAT_TYPE = "multiStatType";
	
	/**
	 * 복수통계 화면 유형 - 기준시점대비
	 */
	public static final String MULTI_STAT_TYPE_BP = "BP";
	
	/**
	 * 복수통계 화면 유형 - 사칙연산
	 */
	public static final String MULTI_STAT_TYPE_FC = "FC";
	
	/**
	 * 복수통계 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/multiStatPage.do")
	public String multiStatPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		if ( StringUtils.isNotEmpty(usrTblSeq) ) {
			usrTblSeq = usrTblSeq.replaceAll(",", "");
			//통계스크랩 파라미터가 넘어온 경우
			Params params = new Params();
			params.set("seqceNo", Integer.parseInt(usrTblSeq));
			/* 통계스크랩 마스터 정보 조회 */
			Record usrTbl = multiStatListService.statMultiUserTbl(params);
			if ( usrTbl != null ) {
				model.addAttribute("searchType", "U");
				model.addAttribute("firParam", usrTbl.getString("firParam"));
				model.addAttribute("statblId", usrTbl.getString("statblId"));
			}
			else {
				model.addAttribute("searchType", "");
			}
		}
		
		// 모바일 통계주제 세팅(selectbox)
		Params cateParam = new Params();
		cateParam.put("statGb", "SUBJ");
		model.addAttribute("cateTopList", statListService.statCateTopList(cateParam));
		return "/soportal/stat/multiStatSch";
	}	

	/**
	 * 통계표 목록 상세조회 [복수통계]
	 * @return 
	 */
	
	@RequestMapping("/portal/stat/selectMultiStatDtl.do")
	public String selectMultiStatDtl(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Map<String, Object> map = multiStatListService.selectMultiStatDtl(params);

        // 모델에 객체를 추가한다.
        addObject(model, map);
        
		return "jsonView";
	}

	/**
	 * 통계표 시트 헤더 설정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/multiTblItm.do")
	public String multiTblItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Map<String, Object> result = multiStatListService.multiTblItm(params);
        
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
	@RequestMapping("/portal/stat/statMultiDtacycleList.do")
    public String statMultiDtacycleList(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = multiStatListService.statMultiDtacycleList(params);
        
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
	@RequestMapping("/portal/stat/statMultiTblUi.do")
    public String statMultiTblUi(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = multiStatListService.statMultiTblUi(params);
        
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
	@RequestMapping("/portal/stat/statMultiTblDtadvs.do")
    public String statMultiTblDtadvs(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = multiStatListService.statMultiTblDtadvs(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 시트 미리보기 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/statMultiPreviewList.do")
	@ResponseBody
	public IBSheetListVO<Record> statMultiPreviewList(HttpServletRequest request, ModelMap model){
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        List<Record> list = multiStatListService.statMultiPreviewList(params);
        
		return new IBSheetListVO<Record>(list, list == null?0:list.size());
	}
	
	/**
	 * 자료시점 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/statMultiWrtTimeOption.do")
    public String statMultiWrtTimeOption(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = multiStatListService.statMultiWrtTimeOption(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 통계스크랩 등록
	 */
	@RequestMapping("/portal/stat/insertStatMultiUserTbl.do")
    public String insertStatMultiUserTbl(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        Object result = multiStatListService.saveStatMultiUserTbl(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
    }
	
	/**
	 * 통계스크랩 수정
	 */
	@RequestMapping("/portal/stat/updateStatMultiUserTbl.do")
    public String updateStatMultiUserTbl(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        Object result = multiStatListService.saveStatMultiUserTbl(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
    }
	
	/**
	 * 통계스크랩 [복수통계] 시계열 정보 호출
	 * @return 
	 */
	
	@RequestMapping("/portal/stat/selectMultiName.do")
	public String selectMultiName(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = multiStatListService.selectMultiName(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);
        
		return "jsonView";
	}
	
	/**
	 * 복수통계 페이지 이동(영문)
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/multiStatEngPage.do")
	public String multiStatEngPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		if ( StringUtils.isNotEmpty(usrTblSeq) ) {
			//통계스크랩 파라미터가 넘어온 경우
			Params params = new Params();
			params.set("seqceNo", Integer.parseInt(usrTblSeq));
			/* 통계스크랩 마스터 정보 조회 */
			Record usrTbl = multiStatListService.statMultiUserTbl(params);
			if ( usrTbl != null ) {
				model.addAttribute("searchType", "U");
				model.addAttribute("firParam", usrTbl.getString("firParam"));
				model.addAttribute("statblId", usrTbl.getString("statblId"));
			}
			else {
				model.addAttribute("searchType", "");
			}
		}
		
		// 모바일 통계주제 세팅(selectbox)
		Params cateParam = new Params();
		cateParam.put("statGb", "SUBJ");
		model.addAttribute("cateTopList", statListService.statCateTopList(cateParam));
		return "/soportal/stat/multiStatEngSch";
	}
	
	/**
	 * 복수통계 시트 셀 제한시 다운로드(대용량)
	 */
	@RequestMapping("/portal/stat/downloadMultiStatSheetData.do")
	public void downloadMultiStatSheetData(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        multiStatListService.downloadStatSheetDataCUD(request, response, params);
	}
}