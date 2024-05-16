package egovframework.portal.nadata.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalNaDataCatalogService {
	
	List<Record> selectNaTopCateList(Params params);
	
	Record selectNaSetCateThumbnail(Params params); 
	
	public List<Map<String, Object>> selectNaDataCateTree(Params params);
	
	Record selectInfoDtl(Params params);
	
	Paging selectNaSetDirPaging(Params params);
	
	String selectNaSetTopCateId(String infoId);
	
	public List<Record> selectNaDataCatalogExcel(Params params);
	
	Paging selectNaSetListPaging(Params params);
	
	public List<Record> selectNaDataCatalogListExcel(Params params);
	 
}
