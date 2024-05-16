/*
 * @(#)PortalSiteMenuServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.menu.service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.ggportal.menu.service.PortalSiteMenuService;

/**
 * 사이트 메뉴를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalSiteMenuService")
public class PortalSiteMenuServiceImpl extends BaseService implements PortalSiteMenuService {
    /**
     * 사이트 메뉴를 관리하는 DAO
     */
    @Resource(name="ggportalSiteMenuDao")
    private PortalSiteMenuDao portalSiteMenuDao;
    
    /**
     * 메뉴 액세스 이력을 관리하는 DAO
     */
    @Resource(name="ggportalLogMenuDao")
    private PortalLogMenuDao portalLogMenuDao;
    
    /**
     * 사이트 메뉴를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectSiteMenuCUD(Params params) {
        // 사이트 메뉴를 조회한다.
        Record menu = portalSiteMenuDao.selectSiteMenu(params);
        
        // 메뉴가 존재하는 경우
        if (menu != null) {
        	
        	if ( EgovUserDetailsHelper.isAuthenticatedPortal() ) {
        		// 로그인 되어있을경우
        		HttpSession session = getSession();
        		params.put(SessionAttribute.USER_CD, session.getAttribute(SessionAttribute.USER_CD));
        	}
        	
            // 메뉴 액세스 이력을 등록한다.
            portalLogMenuDao.insertLogMenu(params);
        }
        
        return menu;
    }
    
    /**
     * 사이트 메뉴를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchSiteMenu(Params params) {
        // 사이트 메뉴를 검색한다.
        return portalSiteMenuDao.searchSiteMenu(params);
    }

    /**
     * XML로 정의된 메뉴를 파싱한다.
     */
	@SuppressWarnings("unchecked")
	@Override
	public List<?> parseSiteMenu(Params params) {
		
		List<Record> menuList = new ArrayList<Record>();
		Record row = null;
		
		ClassLoader classLoader = getClass().getClassLoader();
		
        try {
        	
        	InputStream inputStream = classLoader.getResourceAsStream("egovframework/menu.xml");
        	
        	SAXReader sax = new SAXReader();
        	
        	Document dom = sax.read(inputStream);
        	
            Element root = dom.getRootElement();
            
            // XML에 MENU로 되어있는 엘리먼트들 모두 읽어온다.
            List<Element> list = root.elements("menu");
            
            for ( Element el : list ) {
            	row = new Record();
            	row.put("id", el.attributeValue("id"));
            	row.put("parId", el.attributeValue("parId"));
            	row.put("topId", el.attributeValue("topId"));
            	row.put("viewYn", el.attributeValue("viewYn"));
            	row.put("viewId", el.attributeValue("viewId"));
            	row.put("title", el.element("title").getText());
            	row.put("url", el.element("url").getTextTrim());
            	menuList.add(row);
            }	

        } catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
        
        return menuList;
	}
}