package egovframework.admin.opendt.service;

import java.util.ArrayList;
import java.util.Map;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.service.service.OpenInfSrv;


/**
 * 통계항목관리 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public interface OpenInfTcolItemService {

    /**
     * 통계항목 상위를 전체 조회한다.
     *
     * @param openInfTcolItemr
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectInfTcolItemParAllIbPaging(OpenInfTcolItem openInfTcolItem);

    /**
     * 통계항목 상위를 저장한다.
     *
     * @param list
     * @return
     * @throws Exception
     */
    public int infTcolItemParSaveCUD(ArrayList<OpenInfTcolItem> list);

    /**
     * 통계항목 상위를 삭제한다.
     *
     * @param openInfTcolItemr
     * @return
     * @throws Exception
     */
    public int infTcolItemParDeleteCUD(OpenInfTcolItem openInfTcolItem);

    /**
     * 통계항목 트리를 조회한다.
     *
     * @param openInfTcolItemr
     * @return
     * @throws Exception
     */
    public Map<String, Object> openInfTcolItemListTree(OpenInfTcolItem openInfTcolItem);

    /**
     * 통계항목 순서를 변경한다.
     *
     * @param openInfTcolItemr
     * @return
     * @throws Exception
     */
    public int infTcolItemOrderBySaveCUD(ArrayList<OpenInfTcolItem> list);

    /**
     * 통계항목 트리를 저장,삭제,변경한다.
     *
     * @param openInfTcolItemr
     * @return
     * @throws Exception
     */
    public int saveOpenInfTcolItemCUD(OpenInfTcolItem openInfTcolItem, String status);

    /**
     * 통계항목 정보를 단건 조회한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws Exception
     */
    public OpenInfTcolItem selectOpenInfTcolItem(OpenInfTcolItem openInfTcolItem);

    /**
     * 통계항목 코드항목 중복을 체크한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws Exception
     */
    public int openInfTcolItemDup(OpenInfTcolItem openInfTcolItem);


}
