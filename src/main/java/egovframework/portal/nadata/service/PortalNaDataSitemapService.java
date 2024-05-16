package egovframework.portal.nadata.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalNaDataSitemapService {
	public List<Record> selectCommOrgList(Params params);
	
	public List<Record> selectSiteMapList(Params params);
	
	Record selectDataSiteMapThumbnail(Params params);  
	
	public List<Record> selectMenuList(Params params); 
	
	public List<Record> searchSiteMapList(Params params);
	
	public void insertLogMenu(Params params);
}
  