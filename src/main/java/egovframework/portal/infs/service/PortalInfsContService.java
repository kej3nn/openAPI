package egovframework.portal.infs.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalInfsContService {
	
	public List<Map<String, Object>> selectInfoCateTree(Params params);

	Record selectInfsDtl(Params params);
	
	public List<Record> selectInfsExp(Params params);
	
	public Map<String, List<Record>> selectInfsRel(Params params);
	
	public Paging selectInfsContPaging(Params params);
	
	public List<Record> searchInfsCont(Params params);
	
	public List<Record> selectInfoCateTreeExcel(Params params);
	
	public List<Record> selectInfoCateChild(Params params);
	
	public Record selectInfoCateFullPathCateId(Params params);
}
