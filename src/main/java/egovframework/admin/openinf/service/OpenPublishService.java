package egovframework.admin.openinf.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.admin.bbs.service.BbsList;
import egovframework.admin.service.service.OpenInfSrv;

/**
 * 분류정보관리 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

public interface OpenPublishService {


    /**
     * 공표자료 목록을 전체 조회한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> openPublishListAllIbPaging(OpenPublish openPublish);


    /**
     * 공표자료 단건 조회한다.
     *
     * @param openPublish
     * @param model
     * @return
     * @throws Exception
     */
    public OpenPublish selectOpenPublishOne(OpenPublish openPublish);


    /**
     * 공표자료를 변경한다.
     *
     * @param OpenPublish
     * @return
     * @throws Exception
     */
    public int saveOpenPublishCUD(OpenPublish openPublish, String status);

    /**
     * 공표자료의 파일리스트를 출력한다.
     *
     * @param openPublish
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> openPublishFileList(OpenPublish openPublish);


    public int saveOpenPublishFileCUD(OpenPublish openPublish, ArrayList<?> list);


    /**
     * 공표자료 목록을 전체 조회한다.(포털에서 사용)
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenPublishList(OpenPublish openPublish);

    /**
     * 공표자료를 상세 조회한다.(포털에서 사용)
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenPublishDetail(OpenPublish openPublish);


    public int saveOpenPublishFileListCUD(OpenPublish openPublish, ArrayList<?> list);

}
