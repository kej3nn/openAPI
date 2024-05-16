package egovframework.admin.nadata.service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

/**
 * 관리자 - 국회의원 URL 관리 인터페이스
 *
 * @version 1.0
 * @author JHKIM
 * @since 2020/11/11
 */
public interface NaAssmMemberUrlService {

    Paging searchNaAssmMemberUrl(Params params);

    Result saveNaAssmMemberUrl(Params params);
}
