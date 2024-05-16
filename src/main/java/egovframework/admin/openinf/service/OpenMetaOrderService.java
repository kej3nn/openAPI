package egovframework.admin.openinf.service;

import java.util.ArrayList;
import java.util.Map;

/**
 * 메타순서관리 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

public interface OpenMetaOrderService {

    /**
     * 메타순서를 전체 조회한다.
     *
     * @param OpenMetaOrder
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenMetaOrderPageListAllMainTreeIbPaging(OpenMetaOrder openMetaOrder);


    /**
     * 메타순서를 변경한다.
     *
     * @param OpenMetaOrder
     * @return
     * @throws Exception
     */
    public int openMetaOrderBySave(ArrayList<OpenMetaOrder> list);


}
