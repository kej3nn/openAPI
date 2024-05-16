package egovframework.admin.stat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatSttsStatService {
	
	public List<Record> statSttsStatList(Params params);
	
	public Result insertStatSttsStat(Params params);
	
	public List<Record> statSttsStddMeta(Params params);
	
	public Record statSttsStatDtl(Params params);
	
	public Result saveStatSttsStatMeta(HttpServletRequest request, Params params);
	
	List<Record> statSttsStatUsrList(Params params);
	
	List<Record> statSttsStatExistMetaCd(Params params);
	
	public Result deleteStatSttsStat(Params params);
	
	Result saveSttsStatOrder(Params params);
	
	public Record statSttsOpenStateTblCnt(Params params);

}
