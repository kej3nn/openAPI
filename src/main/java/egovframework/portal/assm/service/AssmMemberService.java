package egovframework.portal.assm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface AssmMemberService {

	public List<Record> searchAssmCommCd(Params params);
	
	public void loadAssmMemberCode(Model model, Params params);
	
	Record selectAssmMemberDtl(Params params);
	
	List<Record> selectAssmMemberInfo(Params params);
	
	public void downloadExcel(HttpServletRequest request, HttpServletResponse response, Params params);
	
	public void downExcelMembInfo(HttpServletRequest request, HttpServletResponse response, Params params);
	
	List<Record> selectAssmHistUnitCodeList(Params params);
	
	public void setModelInCurrentAssmMemberUnit(Model model);
	
//	public void selectAssmMaxUnit(Model model, String empNo);
	
//	public void putModelInAssmMemberDtl(Model model, String empNo, String unitCd);
	
	public void procDownloadExcel(HttpServletRequest request, HttpServletResponse response, Params params, Map<String, Object> svcMap);
	
	List<Record> selectElectedInfo(Params params);
	
	Record selectAssemSns(Params params);
	
	String selectAssmMemberUrlByMonaCd(Params params);
	
	String selectAssmMemberUrlByMonaCdChkEngnm(Params params);
	
	public void makeAssmPicture();
	
	public void insertLogMenu(Params params);
}
