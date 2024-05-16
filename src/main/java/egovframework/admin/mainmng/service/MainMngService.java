package egovframework.admin.mainmng.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;

import egovframework.admin.openinf.service.OpenMetaOrder;
import egovframework.common.base.model.Params;
import egovframework.common.file.service.FileVo;

public interface MainMngService {

	public List<Map<String, Object>> selectListCate();
	
	public int updateCateSeqCUD(ArrayList<OpenMetaOrder> list);
	
	public List<Map<String, Object>> selectListMainMng(Params params);
	
	public int saveMainMngData(HttpServletRequest request, String usrId, FileVo fileVo);
	
	public int updateMainMngCUD(ArrayList<MainMngOrder> list);
	
	public void deleteMainMng(String seqceNo);
	
	/**
	 * 메타순서를 전체 조회한다.
	 * 
	 * @param OpenMetaOrder
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectOpenMetaOrderPageListAllMainTreeIbPaging(OpenMetaOrder openMetaOrder);

	
	/**
	 * 메타순서를 변경한다.
	 * 
	 * @param OpenMetaOrder
	 * @return
	 * @throws Exception
	 */
	public int openMetaOrderBySave(ArrayList<OpenMetaOrder> list);
}
