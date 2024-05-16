package egovframework.admin.menu.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface SiteMenuService {
	
	List<Record> siteMenuList(Params params);
	
	List<Record> siteMenuPopList(Params params);
	
	Record siteMenuDtl(Params params);
	
	Record siteMenuDupChk(Params params);
	
	Object saveSiteMenu(HttpServletRequest request, Params params);
	
	Record selectSiteMenuThumbnail(Params params);
	
	Object deleteSiteMenu(Params params);
	
	Result saveSiteMenuOrder(Params params);
}
