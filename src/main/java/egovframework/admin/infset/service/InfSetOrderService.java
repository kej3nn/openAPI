package egovframework.admin.infset.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface InfSetOrderService {
	
	public List<Record> selectInfSetOrderList(Params params);
	
	public Result saveInfSetOrder(Params params);

}
