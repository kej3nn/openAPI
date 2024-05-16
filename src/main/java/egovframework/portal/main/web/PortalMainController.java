package egovframework.portal.main.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.ggportal.main.service.PortalHomeMngService;
import egovframework.portal.main.service.PortalMainService;

/**
 * 포털 메인화면 컨트롤러 클래스
 * 
 * @author JHKIM
 * @version 1.0 2019/10/14
 */
@Controller
public class PortalMainController extends BaseController {

	@Resource(name="portalMainService")
	private PortalMainService portalMainService;
	
	@Resource(name="gmportalHomeMngService")
	private PortalHomeMngService portalHomeMngService;
	
	@RequestMapping("/portal/mainNewPage.do")
    public String mainNewPage(HttpServletRequest request, Model model) {
		
		Params params = new Params();
		
		// 국회는 지금
		model.addAttribute("nowList", portalMainService.selectAssmNowList(params));
		
		// 입법예고
		model.addAttribute("ibbubList", portalMainService.selectPalInPrgrList(params));
		
		// 의안목록
		model.addAttribute("billList", portalMainService.selectBpmBillList(params));
		
		// 국회TV(편성표) 
	    model.addAttribute("brdPrmList", portalMainService.selectBrdPrmList(params)); 
	    
	    // 국회생중계
	    model.addAttribute("liveList", portalMainService.selectAssmLiveStat(params));
		
		// 공지사항
		params.put("bbsCd", "NOTICE");
		model.addAttribute("noticeList", portalMainService.searchBbsList(params));
		
		// 팝업확인
		params.put("homeTagCd", "PROMT");
		List<Record> popupList = (List<Record>) portalMainService.selectCommHomeList(params);
		if ( popupList.size() > 0 ) {
			model.addAttribute("homePopup", popupList.get(0));
		}
		
		// 텍스트 팝업(A타입)
		params.put("homeTagCd", "TEXTA");
		List<Record> textAPopup = (List<Record>) portalMainService.selectCommHomeList(params);
		model.addAttribute("textAPopup", textAPopup);
		
		// 텍스트 팝업(ㅠ타입)
		params.put("homeTagCd", "TEXTB");
		List<Record> textBPopup = (List<Record>) portalMainService.selectCommHomeList(params);
		model.addAttribute("textBPopup", textBPopup);
		
		// 소식지(신규추가)
		params.put("homeTagCd", "ADZONE");
		model.addAttribute("homeAdzone", (List<Record>) portalMainService.selectCommHomeList(params));
		
		// 화면 하단 공지사항 썸네일 이미지
		params.put("homeTagCd", "NOTICE");
		model.addAttribute("bottomNotice", (List<Record>) portalMainService.selectCommHomeList(params));
		
		// 인기공개정보(전체)
//		model.addAttribute("pplrList", portalMainService.selectPplrInfa(params));
		
		//params.clear();
		
        return "/portal/main";
    }
	
	/**
	 * 포털 메인 화면 임시 20/11/09
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/mainPage.do")
    public String mainPage(HttpServletRequest request, Model model) {
		
		Params params = new Params();
		
		// 국회는 지금
		model.addAttribute("nowList", portalMainService.selectAssmNowList(params));
		
		// 입법예고
		model.addAttribute("ibbubList", portalMainService.selectPalInPrgrList(params));
		
		// 의안목록
		model.addAttribute("billList", portalMainService.selectBpmBillList(params));
		
		// 국회TV(편성표) 
	    model.addAttribute("brdPrmList", portalMainService.selectBrdPrmList(params)); 
	    
	    // 국회생중계
	    model.addAttribute("liveList", portalMainService.selectAssmLiveStat(params));
		
		// 공지사항
		params.put("bbsCd", "NOTICE");
		model.addAttribute("noticeList", portalMainService.searchBbsList(params));
		
		// 팝업확인
		params.put("homeTagCd", "PROMT");
		List<Record> popupList = (List<Record>) portalMainService.selectCommHomeList(params);
		if ( popupList.size() > 0 ) {
			model.addAttribute("homePopup", popupList.get(0));
		}
		
		// 텍스트 팝업(A타입)
		params.put("homeTagCd", "TEXTA");
		List<Record> textAPopup = (List<Record>) portalMainService.selectCommHomeList(params);
		model.addAttribute("textAPopup", textAPopup);
		
		// 텍스트 팝업(B타입)
		params.put("homeTagCd", "TEXTB");
		List<Record> textBPopup = (List<Record>) portalMainService.selectCommHomeList(params);
		model.addAttribute("textBPopup", textBPopup);

		// 소식지(신규추가)
		params.put("homeTagCd", "ADZONE");
		model.addAttribute("homeAdzone", (List<Record>) portalMainService.selectCommHomeList(params));
		
		// 화면 상단 안내(공지사항)
		params.put("homeTagCd", "TLINKA");
		model.addAttribute("homeTopA", (List<Record>) portalMainService.selectCommHomeList(params));
		
		// 화면 상단 안내(소식지)
		params.put("homeTagCd", "TLINKB");
		model.addAttribute("homeTopB", (List<Record>) portalMainService.selectCommHomeList(params));
		
		// 화면 하단 공지사항 썸네일 이미지
		params.put("homeTagCd", "NOTICE");
		model.addAttribute("bottomNotice", (List<Record>) portalMainService.selectCommHomeList(params));
		
        return "/portal/mainNew";
    }
	
	/**
	 * 마인드맵 팝업
	 */
	@RequestMapping("/portal/mindmapPage.do")
    public String mindmapPage(HttpServletRequest request, Model model) {
		return "/portal/mindmap";
	}
	
	/**
	 * 국회는 지금 리스트 조회
	 */
	@RequestMapping("/portal/main/selectAssmNowList.do")
    public String selectAssmNowList(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectAssmNowList(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 입법예고 리스트 조회
	 */
	@RequestMapping("/portal/main/selectPalInPrgrList.do")
    public String selectPalInPrgrList(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectPalInPrgrList(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 의안 목록 조회 
	 */
	@RequestMapping("/portal/main/selectBpmBillList.do")
    public String selectBpmBillList(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectBpmBillList(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 표결현황 목록 조회 
	 */
	@RequestMapping("/portal/main/selectBpmVoteResultList.do")
    public String selectBpmVoteResultList(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectBpmVoteResultList(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 표결현황수 조회
	 */
	@RequestMapping("/portal/main/selectBpmVoteResultCnt.do")
    public String selectBpmVoteResultCnt(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectBpmVoteResultCnt(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 국회일정 조회
	 */
	@RequestMapping("/portal/main/selectBultSchdList.do")
    public String selectBultSchdList(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectBultSchdList(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 국회일정 캘린더 조회
	 */
	@RequestMapping("/portal/main/selectBultSchdCalendarList.do")
    public String selectBultSchdCalendarList(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectBultSchdCalendarList(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 인기공개정보 조회
	 */
	@RequestMapping("/portal/main/selectPplrInfa.do")
    public String selectPplrInfa(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectPplrInfa(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 국회생중계 데이터 조회
	 */
	@RequestMapping("/portal/main/selectAssmLiveStat.do")
    public String selectAssmLiveStat(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectAssmLiveStat(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 의안처리현황 조회
	 */
	@RequestMapping("/portal/main/selectBillRecpFnshCnt.do")
    public String selectBillRecpFnshCnt(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalMainService.selectBillRecpFnshCnt(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 메인화면 관리 이미지를 조회한다.
	 */
	@RequestMapping("/portal/main/commHomeImg.do")
    public String banner(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalHomeMngService.selectHomeImgFile(params);
        
        addObject(model, result);
        
        return "imageView";
    }

	/**
	 * 메인 텍스트 팝업 열기
	 */
	@RequestMapping("/portal/main/mainTextPopup.do")
    public String mainTextPopup(@RequestParam(defaultValue="", required=true) String homeTagCd, @RequestParam(defaultValue="", required=true) String homeSeq, 
    		HttpServletRequest request, Model model) {
        
		Params params = new Params();
        params.put("homeTagCd", homeTagCd);
        params.put("homeSeq", homeSeq);
        
        List<Record> result = (List<Record>) portalMainService.selectCommHomeList(params);
        if ( result != null && result.size() > 0 ) {
        	model.addAttribute("mainTextPopup", result.get(0));
        }
        
        return "/portal/mainTextPop";
    }
	
	/**
	 * 2021년 국회의장 신년사 팝업
	 */
	@RequestMapping("/portal/main/mainNewYearsMessage.do")
    public String mainNewYearsMessage(HttpServletRequest request, Model model) {
        return "/portal/mainNewYearsMessage";
    }	
}
