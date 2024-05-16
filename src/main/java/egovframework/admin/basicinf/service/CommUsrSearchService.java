package egovframework.admin.basicinf.service;

import java.util.Map;

/**
 * 직원정보 조회 Service
 *
 * @author KJH
 * @since 2014.07.23
 */

public interface CommUsrSearchService {

    /**
     * 조직 조회
     *
     * @param commUsrSearch
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommOrgSearchAllIbPaging(CommUsrSearch commUsrSearch);

    /**
     * 직원 조회
     *
     * @param commUsrSearch
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommUsrSearchAllIbPaging(CommUsrSearch commUsrSearch);


}
