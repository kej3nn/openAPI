package egovframework.admin.service.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public interface OpenInfSrvService {

    /**
     * 공공데이터 목록을 조회한다..
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenInfAllIbPaging(OpenInfSrv OpenInfSrv);

    /**
     * 서비스 정보를 조회한다.
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public List<OpenInfSrv> selectOpenInfSrvInfo(OpenInfSrv OpenInfSrv);

    /**
     * 서비스를 신규 , 변경 한다.
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public int openInfSrvCUD(OpenInfSrv OpenInfSrv);

    /**
     * 컬럼리스트를 신규,변경한다.
     *
     * @param openInfSrv
     * @param list
     * @return
     * @throws Exception
     */
    public int openInfColCUD(OpenInfSrv openInfSrv, ArrayList<?> list);

    /**
     * 컬럼리스트를 조회한다.
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenInfColList(OpenInfSrv OpenInfSrv);

    /**
     * 옵션항목을 조회한다.
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenInfColPopInfo(OpenInfSrv OpenInfSrv);

    /**
     * 옵션항목을 저장한다.
     *
     * @param object
     * @return
     * @throws Exception
     */
    public int openInColOptPopupCUD(Object object);

    /**
     * 미리보기 정보를 조회한다.
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenInfColViewPopInfo(OpenInfSrv OpenInfSrv);

    /**
     * 공공데이터 주석을 조회한다.
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public String selectOpenInfDsExp(OpenInfSrv OpenInfSrv);

    /**
     * 데이터를 조회한다.
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectMetaAllIbPaging(OpenInfSrv OpenInfSrv);

    /**
     * 챠트관련 메소드
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public String selectInitX(OpenInfSrv OpenInfSrv);

    /**
     * 공통 팝업 코드를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectTvPopupCode(OpenInfSrv openInfSrv);

    /**
     * Open API 리스스 중복체크
     *
     * @param OpenInfSrv
     * @return
     * @throws Exception
     */
    public int openInfAcolApiDup(OpenInfSrv OpenInfSrv);

    /**
     * Open API URI 리스트 출력
     *
     * @param openInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenInfAcolUriList(OpenInfSrv openInfSrv);

    /**
     * OPEN API CUD
     *
     * @param openInfSrv
     * @param list
     * @return
     * @throws Exception
     */
    public int openInfApiSaveCUD(OpenInfSrv openInfSrv, ArrayList<?> list);

    /**
     * Open API 미리보기 URL 테스트시 컬럼 조건이 기준정보에 있으면 selectBox 설정
     *
     * @param openInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectPreviewApiTestSelectVal(OpenInfSrv openInfSrv);

    /**
     * 신규등록시 INF의 Seq를 가져온다.
     *
     * @param openInfSrv
     * @return
     * @throws Exception
     */
    public int selectGetMstSeq(OpenInfSrv openInfSrv);

    /**
     * 신규등록시 서비스의 seq를 가져온다.
     *
     * @param openInfSrv
     * @return
     * @throws Exception
     */
    int selectGetInfSeq(OpenInfSrv openInfSrv);

    /**
     * 썸네일 이미지 정보를 수정합니다.
     *
     * @param list
     * @return
     */
    public int updateTmnlImgFile(ArrayList<?> list);

    /**
     * 썸네일 파일명을 조히한다.
     *
     * @param openInfSrv
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenInfColInfo(OpenInfSrv openInfSrv, int linkSeq);

    /**
     * 리스트 출력
     */
    public Map<String, Object> selectOpenInfColDtlList(OpenInfVcol openInfVcol);

    /**
     * 멀티미디어 세부 서비스 저장
     *
     * @param openInfSrv
     * @param list
     * @return
     * @throws Exception
     */
    int openInfVcolDetailSaveCUD(OpenInfSrv openInfSrv, ArrayList<?> list);
}
