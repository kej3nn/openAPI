package egovframework.portal.nadata.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalNaDataCommService {
	
	public List<?> selectDataCommItm(Params params);
	
	public List<?> selectDataCommOrg(Params params);
	
	public List<?> selectDataCommCycle(Params params);
	
    public Paging searchNaDataComm(Params params);
    
    public Record selectNaDataCommThumbnail(Params params);
	 
}
