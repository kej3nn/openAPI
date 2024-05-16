/*
 * @(#)PortalBbsListController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.web;

import java.io.File;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.nhncorp.lucy.security.xss.XssPreventer;

import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.view.ImageView;
import egovframework.ggportal.bbs.service.PortalBbsAdminService;
import egovframework.ggportal.bbs.service.PortalBbsFileService;
import egovframework.ggportal.bbs.service.PortalBbsListApprService;
import egovframework.ggportal.bbs.service.PortalBbsListService;
import egovframework.portal.infs.service.PortalInfsListService;

/**
 * 게시판 내용을 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalBbsListController")
public class PortalBbsListController extends BaseController {
    /**
     * 검색 뷰이름
     */
	public static final Map<String, String> searchViewNames = new HashMap<String, String>();
    
    /**
     * 조회 뷰이름
     */
    public static final Map<String, String> selectViewNames = new HashMap<String, String>();
    
    /**
     * 등록 뷰이름
     */
    public static final Map<String, String> insertViewNames = new HashMap<String, String>();
    
    /**
     * 수정 뷰이름
     */
    public static final Map<String, String> updateViewNames = new HashMap<String, String>();
    
    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 검색 뷰이름
        searchViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_BOARD,   "ggportal/bbs/board/searchBoard");
        searchViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_NOTICE,  "ggportal/bbs/notice/searchNotice");
        searchViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_QNA,     "ggportal/bbs/qna/searchQna");
        searchViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_FAQ,     "ggportal/bbs/faq/searchFaq");
        searchViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_GALLERY, "ggportal/bbs/gallery/searchGallery");
        searchViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_BLOG,    "ggportal/bbs/blog/searchBlog");
        
        // 조회 뷰이름
        selectViewNames.put(PortalBbsAdminService.BBS_CODE_EVENT,        "ggportal/bbs/event/selectEvent");
        selectViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_BOARD,   "ggportal/bbs/board/selectBoard");
        selectViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_NOTICE,  "ggportal/bbs/notice/selectNotice");
        selectViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_QNA,     "ggportal/bbs/qna/selectQna");
        selectViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_GALLERY, "ggportal/bbs/gallery/selectGallery");
        
        // 등록 뷰이름
        insertViewNames.put(PortalBbsAdminService.BBS_CODE_IDEA,         "ggportal/bbs/idea/insertIdea");
        insertViewNames.put(PortalBbsAdminService.BBS_CODE_EVENT,        "ggportal/bbs/event/insertEvent");
        insertViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_BOARD,   "ggportal/bbs/board/insertBoard");
        insertViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_QNA,     "ggportal/bbs/qna/insertQna");
        insertViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_GALLERY, "ggportal/bbs/gallery/insertGallery");
        
        // 수정 뷰이름
        updateViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_BOARD,   "ggportal/bbs/board/updateBoard");
        updateViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_QNA,     "ggportal/bbs/qna/updateQna");
        updateViewNames.put(PortalBbsAdminService.BBS_TYPE_CODE_GALLERY, "ggportal/bbs/gallery/updateGallery");
    }
    
    /**
     * 게시판 설정을 관리하는 서비스
     */
    @Resource(name="ggportalBbsAdminService")
    private PortalBbsAdminService portalBbsAdminService;
    
    /**
     * 게시판 내용을 관리하는 서비스
     */
    @Resource(name="ggportalBbsListService")
    private PortalBbsListService portalBbsListService;
    
    /**
     * 게시판 첨부파일을 관리하는 서비스
     */
    @Resource(name="ggportalBbsFileService")
    private PortalBbsFileService portalBbsFileService;
    
    /**
     * 게시판 활용사례 평가점수를 관리하는 서비스
     */
    @Resource(name="ggportalBbsListApprService")
    private PortalBbsListApprService portalBbsListApprService;
    
    
    
    @Resource(name="statsMgmtService")
	private StatsMgmtService statsMgmtService;
    
    @Resource(name="portalInfsListService")
	protected PortalInfsListService portalInfsListService;
    /* 
     * (non-Javadoc)
     * @see egovframework.common.base.controller.BaseController#addPathParameter(egovframework.common.base.model.Params, javax.servlet.http.HttpServletRequest)
     */
    protected void addPathParameter(Params params, HttpServletRequest request) {
        String context = request.getContextPath();
        String uri     = request.getRequestURI();
        
        // 컨텍스트 경로가 루트가 아닌 경우
        if (!"".equals(context)) {
            uri = uri.substring(context.length());
        }
        
        String[] path = uri.split("/");
        
        params.put("bbsCd", path[3].toUpperCase());
    }
    
    /**
     * 게시판 내용을 검색하는 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/searchBulletinPage.do")
    public String searchBulletinPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        params.set("grpCd", "B1001");
		model.addAttribute("faqGubun", statsMgmtService.selectOption(params));	//통계 구분코드
		
        // 게시판 설정을 조회한다.
        Record result = portalBbsAdminService.selectBbsAdmin(params);
        
        debug("Processing results: " + result);
        
        portalInfsListService.keepSearchParam(params, model);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return searchViewNames.get(result.getString("bbsTypeCd"));
    }
    
    /**
     * 게시판 내용을 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/searchBulletin.do")
    public String searchBulletin(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 게시판 내용을 검색한다.
        Object result = portalBbsListService.searchBbsList(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 게시판 내용 비밀번호를 확인한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/verifyPassword.do")
    public String verifyPassword(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 사용자 비밀번호를 확인한다.
        Object result = portalBbsListService.checkUserPw(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 게시판 내용을 조회하는 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/selectBulletinPage.do")
    public String selectBulletinPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        debug("Request parameters: " + params);
        
        
        // 조회 파라미터 유지(활용갤러리)
        portalInfsListService.keepSearchParam(params, model);
        
        /*
        // 이벤트 게시판이 아닌 경우
        if (!PortalBbsAdminService.BBS_CODE_EVENT.equals(params.getString("bbsCd").toUpperCase())) {
            // 비밀글 여부를 확인한다.
            portalBbsListService.checkSecretYn(params);
        }
        */
        // 게시판 설정을 조회한다.
        Record result = portalBbsAdminService.selectBbsAdmin(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        
        // 이벤트 게시판인 경우
        if (PortalBbsAdminService.BBS_CODE_EVENT.equals(params.getString("bbsCd").toUpperCase())) {
            // 뷰이름을 반환한다.
            return selectViewNames.get(result.getString("bbsCd"));
        } else {
            // 뷰이름을 반환한다.
            return selectViewNames.get(result.getString("bbsTypeCd"));
        }
    }
    
    /**
     * 게시판 내용을 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/selectBulletin.do")
    public String selectBulletin(HttpServletRequest request, Model model, @PathVariable("bbsType") String bbsType) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        params.put("isMyPage", StringUtils.equals(bbsType, "myPage") ? "Y" : "N");	// 마이페이지 여부
        params.put("myUserCd", params.getInt("regId"));
        
        try {
        	// 반환 URL
        	String refererUri = new URI(request.getHeader("referer")).getPath();
        	if ( refererUri != null && refererUri.lastIndexOf("updateBulletinPage") > 0 ) {
        		// update 수정인 경우 게시물을 조회하는데 조회수 증가하지 않기위해 상태값 추가
        		params.set("updYN", "Y");
        	}
        	
        } catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
        
        
        // 게시판 내용을 조회한다.
        Object result = portalBbsListService.selectBbsListCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 게시판 댓글을 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/searchComment.do")
    public String searchComment(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 게시판 댓글을 검색한다.
        Object result = portalBbsListService.searchBbsListByPSeq(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 게시판 첨부파일을 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/selectAttachFile.do")
    public String selectAttachFile(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 게시판 첨부파일을 조회한다.
        Object result = portalBbsFileService.selectBbsFile(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
    
    /**
     * 게시판 첨부파일을 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/downloadAttachFile.do")
    public String downloadAttachFile(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 게시판 첨부파일을 다운로드한다.
        Object result = portalBbsFileService.downloadBbsFileCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "fileDownloadView";
    }
    
    /**
     * 게시판 내용을 등록하는 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/insertBulletinPage.do")
    public String insertBulletinPage(@PathVariable("bbsCode") String bbsCd, HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, "Y".equals(portalBbsAdminService.selectLoginWtYn(bbsCd)));
        
        debug("Request parameters: " + params);
        
        // 게시판 설정을 조회한다.
        Record result = portalBbsAdminService.selectBbsAdmin(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 이벤트 게시판인 경우
        if (PortalBbsAdminService.BBS_CODE_EVENT.equals(params.getString("bbsCd").toUpperCase())) {
            // 뷰이름을 반환한다.
            return insertViewNames.get(result.getString("bbsCd"));
        }  else if (PortalBbsAdminService.BBS_CODE_IDEA.equals(params.getString("bbsCd").toUpperCase())) {
        	// 뷰이름을 반환한다.
            return insertViewNames.get(result.getString("bbsCd"));
		}  else {
            // 뷰이름을 반환한다.
            return insertViewNames.get(result.getString("bbsTypeCd"));
        }
    }
    
    /**
     * 게시판 내용을 등록한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/insertBulletin.do")
    public String insertBulletin(@PathVariable("bbsCode") String bbsCd, HttpServletRequest request, Model model) {
    	
    	try {
    		// 파라메터를 가져온다.
    		Params params = getParams(request, "Y".equals(portalBbsAdminService.selectLoginWtYn(bbsCd)));
    		
    		debug("Request parameters: " + params);
    		
    		if ( !StringUtils.equals(bbsCd, "qna01") && !StringUtils.equals(bbsCd, "event") && !StringUtils.equals(bbsCd, "qnaapi") && !StringUtils.equals(bbsCd, "idea")&& !StringUtils.equals(bbsCd, "develop")) {
    			throw new SystemException("등록 할 수 없는 게시판입니다.");
    		}

            // 웹 취약점 진단 대응 XSS 처리 추가
            // Edited by giinie on 2022-05-02
            params.put("bbsTit", XssPreventer.escape(params.getString("bbsTit", "")));
            params.put("bbsCont", XssPreventer.escape(params.getString("bbsCont", "")));

    		// 게시판 내용을 등록한다.
    		Object result = portalBbsListService.insertBbsListCUD(params);
    		
    		debug("Processing results: " + result);
    		
    		// 모델에 객체를 추가한다.
    		addObject(model, result);
        
        } catch(SystemException e) {
        	EgovWebUtil.exLogging(e);
	    } catch(Exception e) {
	    	EgovWebUtil.exLogging(e);
	    }
    	
    	// 뷰이름을 반환한다.
		return "jsonView";
    }
    
    /**
     * 게시판 내용을 수정하는 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/updateBulletinPage.do")
    public String updateBulletinPage(@PathVariable("bbsCode") String bbsCd, HttpServletRequest request, Model model) {
    	Record result = new Record();
    	
    	try {
	        // 파라메터를 가져온다.
	        Params params = getParams(request, "Y".equals(portalBbsAdminService.selectLoginWtYn(bbsCd)));
	        
	        debug("Request parameters: " + params);
	        
	        if ( !StringUtils.equals(bbsCd, "qna01") && !StringUtils.equals(bbsCd, "qnaapi")&& !StringUtils.equals(bbsCd, "develop")) {
				throw new SystemException("수정 할 수 없는 게시판입니다.");
			}
	        
	        // 사용자 코드를 확인한다.
	        portalBbsListService.checkUserCd(params);
	        
	        // 게시판 설정을 조회한다.
	        result = portalBbsAdminService.selectBbsAdmin(params);
	        
	        debug("Processing results: " + result);
	        
	        // 모델에 객체를 추가한다.
	        addObject(model, result);
        
    	} catch(SystemException e) {
        	EgovWebUtil.exLogging(e);
	    } catch(Exception e) {
	    	EgovWebUtil.exLogging(e);
	    }
        
        // 뷰이름을 반환한다.
        return updateViewNames.get(result.getString("bbsTypeCd"));
    }
    
    /**
     * 게시판 내용을 수정한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/updateBulletin.do")
    public String updateBulletin(@PathVariable("bbsCode") String bbsCd, HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, "Y".equals(portalBbsAdminService.selectLoginWtYn(bbsCd)));
        
        debug("Request parameters: " + params);

        // 웹 취약점 진단 대응 XSS 처리 추가
        // Edited by giinie on 2022-05-02
        params.put("bbsTit", XssPreventer.escape(params.getString("bbsTit", "")));
        params.put("bbsCont", XssPreventer.escape(params.getString("bbsCont", "")));

        // 게시판 내용을 수정한다.
        Object result = portalBbsListService.updateBbsListCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 게시판 내용을 삭제한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/deleteBulletin.do")
    public String deleteBulletin(@PathVariable("bbsCode") String bbsCd, HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, "Y".equals(portalBbsAdminService.selectLoginWtYn(bbsCd)));
        
        debug("Request parameters: " + params);
        
        // 게시판 내용을 삭제한다.
        Object result = portalBbsListService.deleteBbsListCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 게시판 활용사례 평가점수를 등록한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/insertAppraisal.do")
    public String insertAppraisal(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 게시판 활용사례 평가점수를 등록한다.
        Object result = portalBbsListApprService.insertBbsListApprCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 게시판 등록시 패스워드 암호화를 위한 키 조회 (무의미하지만 해달라니까..)
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/getBulletIdInfo.do")
    public String buuletIdInfo(HttpServletRequest request, Model model) {
    	Record record = new Record();
    	record.put("value", EgovProperties.getProperty("Globals.encryptionkey"));
    	addObject(model, record);
    	return "jsonView";
    }
    
    @RequestMapping("/portal/bbs/selectBbsThumbnail.do")
    public String selectBbsThumbnail(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
		
		StringBuffer buffer = new StringBuffer();
		
		String todayDir = params.getString("todayDir");
		String fileNm = params.getString("fileNm");
		String fileExt = params.getString("fileExt");
        
        buffer.append(EgovWebUtil.folderPathReplaceAll(EgovProperties.getProperty("Globals.BodyAttImgPath")));
        buffer.append(File.separator);
        buffer.append(todayDir);
        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(fileNm));
        buffer.append("." + fileExt);
        
		Record thumbnail = new Record();
		
		thumbnail.put(ImageView.FILE_PATH, buffer.toString());
       	thumbnail.put(ImageView.FILE_NAME, fileNm + "." + fileExt);
        
        model.addAttribute("data", thumbnail);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
    
    @RequestMapping("/portal/bbs/livere/searchLiveRe.do")
    public String searchLiveRePage(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        // 뷰이름을 반환한다.
        return "ggportal/bbs/livere/searchLiveRe";
    }
    
   /**
    * 참여형 플랫폼 > 활용가이드 엑셀다운로드
    * @param request
    * @param model
    * @return
    */
    @RequestMapping("/portal/{bbsType}/{bbsCode}/excelBulletin.do")
    public ModelAndView excelBulletin(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        ModelAndView modelAndView = new ModelAndView();
        // 게시판 내용을 검색한다.
        Object result = portalBbsListService.excelBbsList(params);
        
        modelAndView.addObject("result",result);
		modelAndView.addObject("pageType", "GD");
		modelAndView.setViewName("/portal/openapi/excelOpenApi");
        
        // 뷰이름을 반환한다.
        return modelAndView;
    }
    
}