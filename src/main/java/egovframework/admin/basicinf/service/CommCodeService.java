package egovframework.admin.basicinf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.admin.opendt.service.OpenCate;
import egovframework.common.grid.ComboIBSVo;


/**
 * 코드에 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public interface CommCodeService {

    /**
     * 조건에 맞는 공통코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return Map<String, Object>
     * @throws Exception
     */
    public Map<String, Object> commCodeListAllIbPaging(CommCode commCode);


    /**
     * 공통코드를 단건 조회한다.
     *
     * @param CommCode
     * @return CommCode
     * @throws Exception
     */
    public CommCode selectCommCodeOne(CommCode commCode);


    /**
     * 공통코드항목을 등록,삭제,변경한다.
     *
     * @param commCode
     * @return
     * @throws Exception
     */
    public int saveCommCodeCUD(CommCode commCode, String status);

    /**
     * 공통코드 중복을 체크한다.
     *
     * @param CommCode
     * @return Integer
     * @throws Exception
     */
    public int commCodeCheckDup(CommCode commCode);

    /**
     * 공통코드 순서를 변경 한다.
     *
     * @param ArrayList<CommCode>
     * @return Integer
     * @throws Exception
     */
    public int commCodeOrderBySave(ArrayList<CommCode> list);


    /**
     * 그룹 코드 목록을 조회 한다.(팝업)
     *
     * @param CommCode
     * @return Map<CommCode>
     * @throws Exception
     */
    public Map<String, Object> commCodeGrpCdListIbPaging(CommCode commCode);


    /**
     * 조건에 맞는 코드 목록을 조회 한다.(분류관리 등록시 표준맵핑 선택에 사용)
     *
     * @param CommCode
     * @return Map<String, Object>
     * @throws Exception
     */
    public Map<String, Object> selectOpenCateDitcList(CommCode commCode);


}
