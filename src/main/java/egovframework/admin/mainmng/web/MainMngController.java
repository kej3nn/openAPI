package egovframework.admin.mainmng.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.mainmng.service.MainMngOrder;
import egovframework.admin.mainmng.service.MainMngService;
import egovframework.admin.openinf.service.OpenMetaOrder;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.file.service.FileVo;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;

@Controller
public class MainMngController  extends BaseController {

	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource(name = "mainMngService")
	private MainMngService mainMngService;
	
	static class openMetaOrder extends HashMap<String, ArrayList<OpenMetaOrder>> { }
	static class mainMngOrder extends HashMap<String, ArrayList<MainMngOrder>> { }
	
	@RequestMapping("/admin/mainmng/mainMngPage.do")
	public String selectMainMngPage(Model model) {
		return "admin/mainmng/mainmng";
	}
	
	/**
	 * 메인화면 관리 목록
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/mainmng/selectListMainMng.do")
	@ResponseBody
	public IBSheetListVO<Map<String, Object>> selectListMainMng(HttpServletRequest request,Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
		List<Map<String, Object>> mngList = mainMngService.selectListMainMng(params);
		return new IBSheetListVO<Map<String,Object>>(mngList, mngList == null?0:mngList.size());
	}
	
	/**
	 * 메인화면관리 저장&수정
	 * @param fileVo
	 * @param request
	 * @param session
	 * @param model
	 */
	@RequestMapping("/admin/mainmng/saveMainMng.do")
	@ResponseBody
	public IBSResultVO saveMainMng(FileVo fileVo, HttpServletRequest request, HttpSession session, Model model) {
		CommUsr loginVo = (CommUsr)session.getAttribute("loginVO");
        mainMngService.saveMainMngData(request, loginVo.getUsrId(), fileVo);
        return new IBSResultVO(1, messagehelper.getSavaMessage(1));
	}
	
	/**
	 * 메인화면관리 삭제
	 * @param data
	 * @param locale
	 * @return
	 */
	@RequestMapping("/admin/mainmng/saveMainMngOrder.do")
	@ResponseBody
	public IBSResultVO<MainMngOrder> saveMainMngOrder(@RequestBody mainMngOrder data, Locale locale) {
		ArrayList<MainMngOrder> list = data.get("data");
		int result = mainMngService.updateMainMngCUD(list);
		return new IBSResultVO<MainMngOrder>(result, messagehelper.getSavaMessage(result));
	}
	
	@RequestMapping("/admin/mainmng/deleteMainMng.do")
	@ResponseBody
	public void deleteMainMng(HttpServletRequest request, Model model) {
		mainMngService.deleteMainMng(request.getParameter("seqceNo"));
	}
	
	
	/**
	 * 분류관리 목록
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/mainmng/selectListCate.do")
	@ResponseBody
	public IBSheetListVO<Map<String, Object>> selectListCate(Model model) {
		List<Map<String, Object>> cateList = mainMngService.selectListCate();
		return new IBSheetListVO<Map<String, Object>>(cateList, cateList == null?0:cateList.size());
	}
	
	/**
	 * 분류관리 수정
	 * @param data
	 * @param locale
	 * @return
	 */
	@RequestMapping("/admin/mainmng/saveCateOrder.do")
	@ResponseBody
	public IBSResultVO<OpenMetaOrder> saveCateOrder(@RequestBody openMetaOrder data, Locale locale) {
		ArrayList<OpenMetaOrder> list = data.get("data");
		int result = mainMngService.updateCateSeqCUD(list);
		
		return new IBSResultVO<OpenMetaOrder>(result, messagehelper.getSavaMessage(result));
	}
	
	
	/**
	 * 메타순서를 전체 조회한다.
	 * @param OpenMetaOrder
	 * @param model
	 * @return IBSheetListVO<OpenMetaOrder>
	 * @throws Exception
	 */
	@RequestMapping("/admin/mainmng/openMetaOrderPageListAllMainTree.do")
	@ResponseBody
	public IBSheetListVO<OpenMetaOrder> openMetaOrderPageListAllMainTreeIbPaging(OpenMetaOrder openMetaOrder, ModelMap model){
		//페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
		Map<String, Object> map = mainMngService.selectOpenMetaOrderPageListAllMainTreeIbPaging(openMetaOrder);
		@SuppressWarnings("unchecked")         
		List<OpenMetaOrder> result = (List<OpenMetaOrder>) map.get("resultList");
		int cnt = Integer.parseInt((String)map.get("resultCnt"));
		return new IBSheetListVO<OpenMetaOrder>(result, cnt);
	}
	
	/**
	 * 메타순서 변경을 저장한다.
	 * @param OpenMetaOrder
	 * @param locale
	 * @return IBSResultVO<OpenMetaOrder>
	 * @throws Exception
	 */
	@RequestMapping("/admin/mainmng/openMetaOrderBySave.do")
	@ResponseBody
	public IBSResultVO<OpenMetaOrder> openMetaOrderBySave(@RequestBody openMetaOrder data, Locale locale) {
		ArrayList<OpenMetaOrder> list = data.get("data");
		int result = mainMngService.openMetaOrderBySave(list);  
		return new IBSResultVO<OpenMetaOrder>(result, messagehelper.getSavaMessage(result));
	}
}
