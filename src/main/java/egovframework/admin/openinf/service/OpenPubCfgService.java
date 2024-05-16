package egovframework.admin.openinf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.common.helper.TABListVo;

/**
 * 분류정보관리 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

public interface OpenPubCfgService {


    /**
     * 공표기준 목록을 전체 조회한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> openPubCfgListAllIbPaging(OpenPubCfg OpenPubCfg);


    /**
     * 관련데이터셋 코드항목 중복을 체크한다.
     *
     * @param OpenPubCfg
     * @return
     * @throws Exception
     */
    public int openPubCfgRefDsCheckDup(OpenPubCfg openPubCfg);


    /**
     * 공표기준을 단건 조회한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public OpenPubCfg selectOpenPubCfgOne(OpenPubCfg openPubCfg);

    /**
     * 공표기준을 저장,삭제,변경한다.
     *
     * @param OpenPubCfg
     * @return
     * @throws Exception
     */
    public OpenPubCfg saveOpenPubCfgCUD(OpenPubCfg openPubCfg, String status);

    /**
     * 공표기준 컬럼 list를 조회한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectRefColId(OpenPubCfg openPubCfg);


}
