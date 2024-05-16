package egovframework.admin.infset.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface DocInfCateService {
	
	List<Record> docInfCateList(Params params);
	
	List<Record> docInfCatePopList(Params params);
	
	Record docInfCateDtl(Params params);
	
	Record docInfCateDupChk(Params params);
	
	Object saveDocInfCate(HttpServletRequest request, Params params);
	
	Record selectDocInfCateThumbnail(Params params);
	
	Object deleteDocInfCate(Params params);
	
	Result saveDocInfCateOrder(Params params);
}
