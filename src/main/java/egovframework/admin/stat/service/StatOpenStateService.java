package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatOpenStateService {
	
	public List<Record> statTblStateList(Params params);
	
	public List<Record> statOpenStateList(Params params);
}
