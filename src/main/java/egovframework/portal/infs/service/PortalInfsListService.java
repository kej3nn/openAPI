package egovframework.portal.infs.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalInfsListService {

	public Paging selectInfsListPaging(Params params);
	
	public List<Record> selectCommOrgTop(Params params);
	
	public void keepSearchParam(Params params, Model model);
	
	public List<Record> selectInfsInfoRelList(Params params);
	
	public void download(HttpServletRequest request, HttpServletResponse response, Params params);
}
