package egovframework.admin.nadata.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface NaSetCateService {

    List<Record> naSetCateList(Params params);

    List<Record> naSetCatePopList(Params params);

    Record naSetCateDtl(Params params);

    Record naSetCateDupChk(Params params);

    Object saveNaSetCate(HttpServletRequest request, Params params);

    Record selectNaSetCateThumbnail(Params params);

    Object deleteNaSetCate(Params params);

    Result saveNaSetCateOrder(Params params);
}
