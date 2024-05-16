package egovframework.admin.basicinf.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.admin.opendt.service.OpenInfTcolItem;

/**
 * 조직정보 관리를 위한 Service 클래스
 *
 * @author KJH
 * @since 2014.07.17
 */

public interface CommOrgService {


    /**
     * 사용자 정보를 전체 조회한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public List<CommOrg> selectCommOrgAll(CommOrg commOrg);

    /**
     * 조직정보 전체 조회
     *
     * @param commOrg
     * @return
     * @throws Exception
     */
    public Map<String, Object> commOrgListTree(CommOrg commOrg);

    /**
     * 조직코드 중복체크
     *
     * @param commOrg
     * @return
     * @throws Exception
     */
    public int commOrgCdDup(CommOrg commOrg);

    /**
     * 조직정보 CUD
     *
     * @param commOrg
     * @param status
     * @return
     * @throws Exception
     */
    public int saveCommOrgCUD(CommOrg commOrg, String status);

    /**
     * 조직정보 단건조회
     *
     * @param commOrg
     * @return
     * @throws Exception
     */
    //public CommOrg commOrgRetr(CommOrg commOrg);
    public List<CommOrg> commOrgRetr(CommOrg commOrg);

    /**
     * 조직정보 메뉴순서 수정
     *
     * @param list
     * @return
     * @throws Exception
     */
    public int commOrgListUpdateTreeOrderCUD(ArrayList<CommOrg> list);

}
