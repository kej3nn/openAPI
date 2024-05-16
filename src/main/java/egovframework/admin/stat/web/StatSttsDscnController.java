package egovframework.admin.stat.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.stat.service.StatSttsDscnService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 관리자 연계정보설정 컨트롤러
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/09/07
 */

@Controller
public class StatSttsDscnController extends BaseController {

	@Resource(name="statSttsDscnService")
	protected StatSttsDscnService statSttsDscnService;
	
	/**
	 * 연계설정정보 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statSttsDscnPage.do")
	public String statSttsDscnPage(ModelMap model) {
		return "/admin/stat/stat/statSttsDscn";
	}
	
	/**
	 * 연계설정정보 메인 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsDscnList.do")
	public String statSttsDscnList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = statSttsDscnService.statSttsDscnList(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	
	/**
	 * 연계설정정보 데이터 저장(CUD)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/saveSttsDscn.do")
    public String saveSttsDscn(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsDscnService.saveSttsDscn(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
}
