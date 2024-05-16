package egovframework.admin.infset.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.admin.infset.service.InfSetOrderService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * 정보셋 순서를 관리하는 컨트롤러 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/18
 */

@Controller
public class InfSetOrderController extends BaseController { 
	
	protected static final Log logger = LogFactory.getLog(InfSetOrderController.class);
	
	@Resource(name="infSetOrderService")
	protected InfSetOrderService infSetOrderService;
	
	@Resource(name="statsMgmtService")
	protected StatsMgmtService statsMgmtService;
	
	/**
	 * 정보셋 순서 관리 화면으로 이동한다.
	 */
	@RequestMapping(value="/admin/infs/order/infsetOrderPage.do")
	public String infsetOrderPage(ModelMap model) {
		Params params = new Params();
		params.set("grpCd", "S1009");
		model.addAttribute("openStateList", statsMgmtService.selectOption(params));	// 공개상태
		
		return "/admin/infset/order/infSetOrder";
	}
	
	/**
	 * 정보셋 순서 목록 조회
	 */
	@RequestMapping(value="/admin/infs/order/selectInfSetOrderList.do")
	public String selectInfSetOrderList(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
		
		Object result = infSetOrderService.selectInfSetOrderList(params);
		
		addObject(model, result);
		
		return "jsonView";
	}
	
	/**
	 * 정보셋 순서 저장
	 */
	@RequestMapping(value="/admin/infs/order/saveInfSetOrder.do")
	public String updateInfSetOrder(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
		
		Object result = infSetOrderService.saveInfSetOrder(params);
		
		addObject(model, result);
		
		return "jsonView";
	}
	
}
