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
public interface NaDataCommitteeThmlService {

    Paging selectCommitteeThmlMainListPaging(Params params);

    List<Record> selectOrgList(Params params);

    Record naDataCommitteeThmlDupChk(Params params);

    Object saveNaDataCommitteeThml(HttpServletRequest request, Params params);

    Record naDataCommitteeThmlDtl(Params params);

    Record selectDataCommitteeThmlThumbnail(Params params);

    Object deleteNaDataCommitteeThml(Params params);

    Result saveNaDataCommitteeThmlOrder(Params params);


}
