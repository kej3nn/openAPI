package egovframework.portal.search.web;

import java.util.ArrayList;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.main.service.PortalMainService;
import egovframework.portal.search.service.CollectionVO;
import egovframework.portal.search.service.SearchResultVO;
import egovframework.portal.search.service.SearchService;
import egovframework.portal.search.service.SearchVO;

@Controller
public class PortalSearchController extends BaseController {
	
	@Resource(name="searchSerivce")
	private  SearchService searchSerivce;
	
	@Resource(name="portalMainService")
	private  PortalMainService portalMainService;
	
	@RequestMapping("/portal/search/searchPage.do")
    public String search(HttpServletRequest request, Model model, SearchVO srchVo) {
		
		
		String searchIp =  EgovProperties.getProperty("sf1.searchIp");
		int searchPort = Integer.parseInt( EgovProperties.getProperty("sf1.searchPort"));
		int searchTimeOut = Integer.parseInt(EgovProperties.getProperty("sf1.searchTimeout"));
		 Params params = getParams(request, false);
		srchVo.setSearchIp(searchIp);
		srchVo.setSearchPort(searchPort);
		srchVo.setSearchTimeOut(searchTimeOut);
		
		SearchResultVO  colResult = new SearchResultVO();
		colResult = searchSerivce.getSearch(srchVo);
		
		ArrayList<CollectionVO> colList = colResult.getCollectionList();
		
		CollectionVO iopen= new CollectionVO();
		CollectionVO iopen_name= new CollectionVO();
		CollectionVO iopen_chairman= new CollectionVO();
		CollectionVO iopen_compass= new CollectionVO();
		CollectionVO iopen_menu= new CollectionVO();
		CollectionVO iopen_notice= new CollectionVO();
		CollectionVO iopen_file= new CollectionVO();
		
		CollectionVO record1= new CollectionVO();
		CollectionVO record2= new CollectionVO();
		CollectionVO record3= new CollectionVO();
		CollectionVO record4= new CollectionVO();
		CollectionVO record5= new CollectionVO();
		CollectionVO record6= new CollectionVO();
		
		
		
		CollectionVO home_data = new CollectionVO();
		CollectionVO home_file = new CollectionVO();
		CollectionVO home_magazine = new CollectionVO();
		/*
		 * 홈페이지 리뉴얼
		 * CollectionVO notice = new CollectionVO();
		CollectionVO cmmnt = new CollectionVO();
		CollectionVO chairman = new CollectionVO();
		CollectionVO chairman_intro = new CollectionVO();
		CollectionVO assem_act = new CollectionVO();
		CollectionVO homehelp = new CollectionVO();
		CollectionVO home_menu = new CollectionVO();*/
		
		CollectionVO bill = new CollectionVO();
		CollectionVO bill_simsa = new CollectionVO();
		CollectionVO bill_review = new CollectionVO();
		
		CollectionVO nalaw = new CollectionVO();
		CollectionVO audit = new CollectionVO();
		
		
		CollectionVO committee = new CollectionVO();
		CollectionVO committee_file = new CollectionVO();
		CollectionVO nas = new CollectionVO();
		CollectionVO nas_file = new CollectionVO();
		CollectionVO nas_ebook = new CollectionVO();
		
		CollectionVO petit = new CollectionVO();
		
		if(colList != null){
			for(int i=0; i< colList.size(); i ++){
				CollectionVO colVo = colList.get(i);
				String colIndex = colVo.getColIndexName();
				
				if("iopen".equals(colIndex)){
					iopen = colVo;
				}else if("iopen_chairman".equals(colIndex)){
					iopen_chairman = colVo;
				}else if("iopen_compass".equals(colIndex)){
					iopen_compass = colVo;
				}else if("iopen_menu".equals(colIndex)){
					iopen_menu = colVo;
				}else if("iopen_notice".equals(colIndex)){
					iopen_notice = colVo;
				}else if("iopen_name".equals(colIndex)){
					iopen_name = colVo;
				}else if("iopen_file".equals(colIndex)){
					iopen_file = colVo;
				}
				
				
				else if("record1".equals(colIndex)){
					record1 = colVo;
				}else if("record2".equals(colIndex)){
					record2 = colVo;
				}else if("record3".equals(colIndex)){
					record3 = colVo;
				}else if("record4".equals(colIndex)){
					record4 = colVo;
				}else if("record5".equals(colIndex)){
					record5 = colVo;
				}else if("record6".equals(colIndex)){
					record6 = colVo;
				}
				
				
				else if("home_data".equals(colIndex)){
					home_data = colVo;
				}else if("home_file".equals(colIndex)){
					home_file = colVo;
				}else if("home_magazine".equals(colIndex)){
					home_magazine = colVo;
				}
				
				/*else if("notice".equals(colIndex)){
					notice = colVo;
				}else if("cmmnt".equals(colIndex)){
					cmmnt = colVo;
				}else if("chairman".equals(colIndex)){
					chairman = colVo;
				}else if("chairman_intro".equals(colIndex)){
					chairman_intro = colVo;
				}else if("assem_act".equals(colIndex)){
					assem_act = colVo;
				}else if("homehelp".equals(colIndex)){
					homehelp = colVo;
				}else if("home_menu".equals(colIndex)){
					home_menu = colVo;
				}*/
				
				
				else if("bill".equals(colIndex)){
					bill = colVo;
				}else if("bill_simsa".equals(colIndex)){
					bill_simsa = colVo;
				}else if("bill_review".equals(colIndex)){
					bill_review = colVo;
				}
				
				else if("nalaw".equals(colIndex)){
					nalaw = colVo;
				}
				else if("audit".equals(colIndex)){
					audit = colVo;
				}
				
				else if("committee".equals(colIndex)){
					committee = colVo;
				}
				else if("committee_file".equals(colIndex)){
					committee_file = colVo;
				}
				
				else if("nas".equals(colIndex)){
					nas = colVo;
				}else if("nas_ebook".equals(colIndex)){
					nas_ebook = colVo;
				}else if("nas_file".equals(colIndex)){
					nas_file = colVo;
				}
				
				else if("petit".equals(colIndex)){
					petit = colVo;
				}else{
					log.debug("no match collection");
				}
				
			}
		}
		
		
		model.addAttribute("vo" , srchVo);
		model.addAttribute("iopen" ,  iopen);
		model.addAttribute("iopen_name" ,  iopen_name);
		model.addAttribute("iopen_chairman" ,  iopen_chairman);
		model.addAttribute("iopen_compass" ,  iopen_compass);
		model.addAttribute("iopen_menu" ,  iopen_menu);
		model.addAttribute("iopen_notice" ,  iopen_notice);
		model.addAttribute("iopen_file" ,  iopen_file);

		model.addAttribute("record1" ,  record1);
		model.addAttribute("record2" ,  record2);
		model.addAttribute("record3" ,  record3);
		model.addAttribute("record4" ,  record4);
		model.addAttribute("record5" ,  record5);
		model.addAttribute("record6" ,  record6);
		
		model.addAttribute("home_data" ,  home_data);
		model.addAttribute("home_file" ,  home_file);
		model.addAttribute("home_magazine" ,  home_magazine);
		/*model.addAttribute("notice" ,  notice);
		model.addAttribute("cmmnt" ,  cmmnt);
		model.addAttribute("chairman" ,  chairman);
		model.addAttribute("chairman_intro" ,  chairman_intro);
		model.addAttribute("assem_act" ,  assem_act);
		model.addAttribute("homehelp" ,  homehelp);
		model.addAttribute("home_menu" ,  home_menu);*/
		
		model.addAttribute("nalaw" ,  nalaw);
		
		model.addAttribute("bill" ,  bill);
		model.addAttribute("bill_simsa" ,  bill_simsa);
		model.addAttribute("bill_review" ,  bill_review);
		
		
		model.addAttribute("audit" ,  audit);
		
		model.addAttribute("nas" ,  nas);
		model.addAttribute("nas_file" ,  nas_file);
		model.addAttribute("nas_ebook" ,  nas_ebook);
		
		model.addAttribute("committee" ,  committee);
		model.addAttribute("committee_file" ,  committee_file);
		
		model.addAttribute("petit" ,  petit);
		
		
		model.addAttribute("colResult", colResult);
		
		if(params.get("query")!=null && !"".equals(params.get("query"))){
			if(colResult !=null){
				if(colResult.getAllCount() >0 ){
					portalMainService.insertTbLogSearch(params);
				}
			}
		}
		
		return "/portal/search/search";
	}
	
	
	/**
	 * 
	 */
	
	@RequestMapping("/portal/search/getGroup.do")
	@ResponseBody
    public HashMap<String, Object> getGourp(HttpServletRequest request, SearchVO srchVo) {
        Params params = getParams(request, false);
        
     //   Object result = searchSerivce.getGourp(srchVo);
        HashMap<String, Object>  result = new HashMap<String, Object>();
        result = searchSerivce.getGroup(srchVo);
        //addObject(model, result);
        
        return result;
    }
	
	/**
	 * 
	 */
	@RequestMapping("/portal/search/getArk.do")
	@ResponseBody
    public String getArk(HttpServletRequest request, SearchVO srchVo) {
        Params params = getParams(request, false);
        
        String result = searchSerivce.getArk(params);
        
        //addObject(model, result);
        
        return result;
    }
	
	/**
	 * 
	 */
	@RequestMapping("/portal/search/getPopword.do")
	@ResponseBody
    public String getPopword(HttpServletRequest request, SearchVO srchVo) {
        Params params = getParams(request, false);
        
        String result = searchSerivce.getPopword(params);
        
        return result;
    }
}
