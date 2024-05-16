package egovframework.admin.service.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface OpenInfFileService {
    Paging selectOpenInfSrvList(Params params);

    Record selectOpenInfSrvDtl(Params params);

    List<Record> selectOpenInfFileList(Params params);

    Result insertOpeninfFile(HttpServletRequest request, Params params);

    Result updateOpeninfFile(Params params);

    Result deleteOpeninfFile(Params params);

    Record downloadOpeninfFile(Params params);

    Result saveOpenInfFileOrder(Params params);
}
