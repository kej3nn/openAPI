package egovframework.admin.basicinf.service;

import java.util.Map;

/**
 * 담당자관리 Service
 *
 * @author KJH
 * @since 2014.07.23
 */

public interface CommUsrAdminService {

    /**
     * 사용자 정보를 체크한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public CommUsrAdmin selectCommUsrAdminCheck(CommUsrAdmin commUsrAdmin);

    /**
     * 사용자 정보를 전체 조회한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommUsrAdminAllIbPaging(CommUsrAdmin commUsrAdmin);


    /**
     * 직원팝업 검색
     *
     * @param commUsrAdmin
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommUsrAdminPopIbPaging(CommUsrAdmin commUsrAdmin);

    /**
     * 직원팝업 검색(직책추가버전)
     *
     * @param commUsrAdmin
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommUsrAdminPosPopIbPaging(CommUsrAdmin commUsrAdmin);

    /**
     * 직원 단건조회
     *
     * @param commUsrAdmin
     * @return
     * @throws Exception
     */
    public CommUsrAdmin selectCommUsrAdminDtlInfo(CommUsrAdmin commUsrAdmin);

    /**
     * 담당자 정보 CUD
     *
     * @param commUsrAdmin
     * @param status
     * @return
     * @throws Exception
     */
    public int saveCommUsrAdminCUD(CommUsrAdmin commUsrAdmin, String status);

    /**
     * 담당자 승인 및 승인취소
     *
     * @param commUsrAdmin
     * @param status
     * @return
     * @throws Exception
     */
    public int commUsrAdminAppr(CommUsrAdmin commUsrAdmin, String status);

    /**
     * 담당자ID 중복체크
     *
     * @param commUsrAdmin
     * @param status
     * @return
     * @throws Exception
     */
    public int commUsrAdminUsrIdDup(CommUsrAdmin commUsrAdmin);

    /**
     * 비밀번호 초기화
     *
     * @param commUsrAdmin
     * @return
     * @throws Exception
     */
    public CommUsrAdmin commUsrAdminInitialPw(CommUsrAdmin commUsrAdmin);

}
