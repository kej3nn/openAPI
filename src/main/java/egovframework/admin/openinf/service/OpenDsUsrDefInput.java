package egovframework.admin.openinf.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface OpenDsUsrDefInput {

    int selectOpenDsUsrDefExist(String dsId);

    List<Record> selectOpenDsUsrDefColList(Params params);

    List<Record> selectOpenDsUsrDefHeaderData(Params params);

    Paging selectOpenDsUsrDefData(Params params);

    Result insertOpenDsUsrDef(Params params);

    Result updateOpenDsUsrDef(Params params);

    public Object insertOpenUsrDefFile(HttpServletRequest request, Params params);

    List<Record> selectOpenUsrDefFile(Params params);

    Result deleteOpenDsUsrDef(Params params);

    Record downloadOpenUsrDefFile(Params params);

    Result saveOpenUsrDefFileOrder(Params params);

    Result deleteOpenUsrDefFile(Params params);
}
