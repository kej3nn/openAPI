package egovframework.soportal.stat.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jasypt.commons.CommonUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.soportal.stat.service.ChartListService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.helper.Messagehelper;

/**
 * 사용자 표준단위 정보 클래스
 * 
 * @author 	소프트온
 * @version	1.0
 * @since	2017/09/11
 */

@Controller
public class ChartListController extends BaseController {

	protected static final Log logger = LogFactory.getLog(ChartListController.class);
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource(name="chartListService")
	protected ChartListService chartListService;

	/**
	 * 2018.07.14 로직 변경
	 * 통계표 챠트 > 조건에 따른 항목정보 및 데이터를 조회한다.
	 */
	@RequestMapping("/portal/stat/statChartItm.do")
	public String statChartItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters chart : " + params);
        
        if(CommonUtils.isNotEmpty((String) params.get("statMulti"))){
        	debug("Processing results : Multi");
            Object result = chartListService.multiChartJson(params);
            debug("Processing results : " + result);
            addObject(model, result);	// 모델에 객체를 추가한다.
        }else{
        	debug("Processing results : Single");
            Object result = chartListService.easyChartJson(params);
            debug("Processing results : " + result);
            addObject(model, result);	// 모델에 객체를 추가한다.
        }
        
        return "jsonView";
        
	}	
	
	/**
	 * 통계표 지도를 위한 데이터 조회
	 */
	@RequestMapping("/portal/stat/statMapDataJson.do")
	public String statMapDataJson(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        if(CommonUtils.isNotEmpty((String) params.get("statMulti"))){
            Object result = chartListService.multiChartJson(params);
            debug("Processing results: " + result);
            addObject(model, result);	// 모델에 객체를 추가한다.
        }else{
            Object result = chartListService.statMapDataJson(params);
            debug("Processing results: " + result);
            addObject(model, result);	// 모델에 객체를 추가한다.
        }
        
        return "jsonView";
        
	}
	
	/**
	 * 통계표 지도를 위한 데이터 조회[상세]
	 */
	@RequestMapping("/portal/stat/statMapJsonDetail.do")
	public String statMapJsonDetail(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);
        
        Object result = chartListService.statMapJsonDetail(params);
        debug("Processing results: " + result);
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
        
	}
}