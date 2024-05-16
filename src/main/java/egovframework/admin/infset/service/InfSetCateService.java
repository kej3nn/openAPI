package egovframework.admin.infset.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface InfSetCateService {
	
	List<Record> infSetCateList(Params params);
	
	List<Record> infSetCatePopList(Params params);
	
	Record infSetCateDtl(Params params);
	
	Record infSetCateDupChk(Params params);
	
	Object saveInfSetCate(HttpServletRequest request, Params params);
	
	Record selectInfSetCateThumbnail(Params params);
	
	Object deleteInfSetCate(Params params);
	
	Result saveInfSetCateOrder(Params params);
}
