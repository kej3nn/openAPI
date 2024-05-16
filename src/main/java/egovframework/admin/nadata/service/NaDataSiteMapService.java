package egovframework.admin.nadata.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

/**
 * 국회 정보 사이트맵을 관리하는 인터페이스
 *
 * @version 1.0
 * @author 김재한
 * @since 2019/09/09
 */
public interface NaDataSiteMapService {

    Paging selectSiteMapMainListPaging(Params params);

    List<Record> selectOrgList(Params params);

    Record naDataSiteMapDupChk(Params params);

    Object saveNaDataSiteMap(HttpServletRequest request, Params params);

    Record naDataSiteMapDtl(Params params);

    Record selectDataSiteMapThumbnail(Params params);

    Object deleteNaDataSiteMap(Params params);

    Result saveNaDataSiteMapOrder(Params params);


}
