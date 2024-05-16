package egovframework.admin.expose.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface AdminExposeInfoService {

    public List<Record> selectNaboOrg(Params params);

    public List<Record> selectComCode(Params params);

    public Paging opnApplyListPaging(Params params);

    public Result insertOpnApply(HttpServletRequest request, Params params);

    public Map<String, Object> selectOpnApplyDtl(Map<String, String> paramMap);

    public Result saveInfoRcp(HttpServletRequest request, Params params);

    public Result saveTrsfOpnApl(HttpServletRequest request, Params params);

    public Map<String, Object> opnApplyDtl(Map<String, String> paramMap);

    public Result updateInfoOpenApplyPrgStat(HttpServletRequest request, Params params);

    public Map<String, Object> getInfoOpnDcsSearch(Params params);

    public Record downloadOpnAplFile(Params params);

    public Result saveOpnDcsProd(HttpServletRequest request, Params params);

    public Result saveOpenEndCn(HttpServletRequest request, Params params);

    public Result infoOpenTrnWrite(HttpServletRequest request, Params params);

    public Result updateOpnApl(Params params);

    public Map<String, Object> getInfoOpnDcsDetail(Params params);

    public Map<String, Object> getInfoOpenApplyDetail(Params params);

    public Map<String, Object> getOpnObjtnInfoDetail(Params params);

    List<Record> infoOrgPopList(Params params);

    public Result updateOpnAplDept(Params params);

    public List<Record> selectOpnzDeptList(Params params);

    public void insertLogAcsOpnzApl(Params params);

    public List<Record> selectNotTrstNaboOrg(Params params);

    public Map<String, Object> getInfoOpnAplSearch(Params params);

    public Result updateAplConnCd(Params params);
}
