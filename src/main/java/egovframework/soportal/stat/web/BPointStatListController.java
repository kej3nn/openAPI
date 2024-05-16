package egovframework.soportal.stat.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.soportal.stat.service.MultiStatListService;
import egovframework.soportal.stat.service.StatListService;

/**
 * 사용자 표준단위 정보 클래스
 * 
 * @author 	소프트온
 * @version	1.0
 * @since	2019/05/01
 */

@Controller
public class BPointStatListController extends BaseController {

	protected static final Log logger = LogFactory.getLog(BPointStatListController.class);
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource(name="statListService")
	protected StatListService statListService;
	
	@Resource(name="multiStatListService")
	protected MultiStatListService multiStatListService;

	/**
	 * 기준시점대비 변동분석 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/stat/bPointStatPage.do")
	public String bPointStatPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
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
		return "/soportal/stat/bPointStatSch";
	}
	
	/**
	 * 통계표 항목 설정 및 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/stat/bPointTblItm.do")
	public String bPointTblItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        params.set(MultiStatListController.MULTI_STAT_TYPE, MultiStatListController.MULTI_STAT_TYPE_BP);	// 기준시점대비 구분값 추가
        
        Map<String, Object> result = multiStatListService.multiTblItm(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 기준시점대비 변동분석 데이터 조회 
	 */
	@RequestMapping("/portal/stat/statBPointPreviewList.do")
	@ResponseBody
	public IBSheetListVO<Record> statBPointPreviewList(HttpServletRequest request, ModelMap model){
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        params.set(MultiStatListController.MULTI_STAT_TYPE, MultiStatListController.MULTI_STAT_TYPE_BP);	// 기준시점대비 구분값 추가
        List<Record> list = multiStatListService.statMultiPreviewList(params);
        
		return new IBSheetListVO<Record>(list, list == null?0:list.size());
	}
	
}