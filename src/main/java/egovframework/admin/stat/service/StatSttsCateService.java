package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatSttsCateService {
	
	List<Record> statSttsCateList(Params params);
	
	List<Record> statSttsCatePopList(Params params);
	
	Record statSttsCateDtl(Params params);
	
	Record statSttsCateDupChk(Params params);
	
	Object saveStatSttsCate(HttpServletRequest request, Params params);
	
	Record selectStatCateThumbnail(Params params);
	
	Object deleteStatSttsCate(Params params);
	
	Result saveStatSttsCateOrder(Params params);
}
