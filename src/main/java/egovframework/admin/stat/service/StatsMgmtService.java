package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatsMgmtService {
	
	public List<Record> selectOption(Params params);
	
	public List<Record> selectSTTSOption(Params params);
	
	public List<Map<String, Object>> selectStatMetaPopup(Params params);
	
	public List<Map<String, Object>> selectStatCatePopup(Params params);
	
	public List<Record> statSttsTblCateList(Params params);
	
	public List<Record> statsMgmtListPaging(Params params);
	
	public Map<String, Object> selectStatsMgmtDtl(Map<String, String> paramMap);
	
	public Result saveStatsMgmt(Params params);
	
	public List<Record> statsUsrListPaging(Params params);
	
	public List<Map<String, Object>> selectStatStddItmPopup(Params params);
	
	public List<Map<String, Object>> selectStatsStddUiPopup(Params params);
	
	public Result saveStddTblItmCUD(List<StatsStddTblItm> list, Params params);
	
	public List<Map<String, Object>> statsTblItmListPaging(Params params);
	
	public Result saveStddTblItmOrder(List<StatsStddTblItm> list, Params params);
	
	Result saveStatsMgmtOrder(Params params);
	
	Result deleteStatsMgmt(Params params);
	
	Result updateOpenState(Params params);
	
	Result execSttsAnlsAll(Params params);
	
	Result execCopySttsTbl(Params params);
	
	public List<Record> selectSttsTblPopList(Params params);
	
	public List<Record> selectSttsTblList(Params params);

	List<Record> selectStatsCateInfoList(Params params);

	List<Record> selectStatCateInfoPop(Params params);

	public List<Record> selectSysOption(Params params);

	public Paging selectStfStatsMgmtListPaging(Params params);

	public Record stfStatsMgmtDtl(Params params);

	public Object saveStfStatsMgmt(HttpServletRequest request, Params params);


}
