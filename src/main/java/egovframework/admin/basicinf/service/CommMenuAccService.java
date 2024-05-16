package egovframework.admin.basicinf.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.admin.openinf.service.OpenDs;
import egovframework.admin.openinf.service.OpenDscol;


/**
 * 메뉴에 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public interface CommMenuAccService {


    /**
     * 전체 리스트 조회
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectMenuListIbPaging(CommMenuAcc commMenuAcc);

    /**
     * 메뉴 권한을 저장한다
     *
     * @param list
     * @return
     * @throws Exception
     */
    public int updateCommMenuAccCUD(ArrayList<CommMenuAcc> list);


}
