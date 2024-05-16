package egovframework.admin.expose.service;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 기관관리를 위한 Service 클래스
 *
 * @author JIS
 * @since 2019.08.27
 */

public interface AdminInstMgmtService {

    /**
     * 기관정보 전체 조회
     *
     * @param params
     * @return
     * @throws Exception
     */
    public Object instMgmtListTree(Params params);

    /**
     * 기관관리 CUD
     *
     * @param instMgmt
     * @param status
     * @return
     * @throws Exception
     */
    public Object saveInstMgmt(HttpServletRequest request, Params params);

    /**
     * 기관관리 단건조회
     *
     * @param params
     * @return
     */
    public Record instMgmtRetr(Params params);

    /**
     * 정보 썸네일 불러오기
     *
     * @param request
     * @param model
     * @return
     */
    public Record selectInstMgmtThumbnail(Params params);

}
