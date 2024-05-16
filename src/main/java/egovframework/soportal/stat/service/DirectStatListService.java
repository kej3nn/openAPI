package egovframework.soportal.stat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface DirectStatListService {

	public Record selectContBbsTbl(Params params);
	
	public List<Record> selectContBbsTblList(Params params);
	
	public List<Record> selectContBbsFileList(Params params);
	
	public List<Record> selectContBbsLinkList(Params params);
}
