package egovframework.admin.opendt.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.bbs.service.BbsList;
import egovframework.common.file.service.FileVo;

/**
 * 분류정보관리 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

public interface OpenCateService {

    /**
     * 분류항목을 전체 조회한다.
     *
     * @param OpenCate
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenCateListAllMainTreeIbPaging(OpenCate OpenCate);

    /**
     * 분류항목을 단건 조회한다.
     *
     * @param OpenCate
     * @param model
     * @return
     * @throws Exception
     */
    //public OpenCate selectOpenCateOne(OpenCate openCate);
    public List<OpenCate> selectOpenCateOne(OpenCate openCate);


    /**
     * 분류항목 순서를 변경한다.
     *
     * @param OpenCate
     * @return
     * @throws Exception
     */
    public int openCateOrderBySave(ArrayList<OpenCate> list);

    /**
     * 분류관리 코드항목 중복을 체크한다.
     *
     * @param OpenCate
     * @return
     * @throws Exception
     */
    public int openCateCheckDup(OpenCate openCate);

    /**
     * 분류관리항목을 저장,삭제,변경한다.
     *
     * @param OpenCate
     * @return
     * @throws Exception
     */
    public int saveOpenCateCUD(OpenCate openCate, String status);

    /**
     * 상위분류를 전체 조회한다.
     *
     * @param OpenCate
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenCateParListTreeIbPaging(OpenCate OpenCate);

    /**
     * 상세분류의 하위 트리를 전체 조회한다.
     *
     * @param OpenCate
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenCateListSubTreeIbPaging(OpenCate OpenCate);

    /**
     * 분류관리항목을 저장,삭제,변경한다.
     *
     * @param OpenCate
     * @return
     * @throws Exception
     */
    public int saveOpenCateLvlCUD(OpenCate openCate);


    public List<OpenCate> selectOpenCateTop();

    public int saveImgFileListCUD(OpenCate opencate, ArrayList<?> list, FileVo fileVo);

    public Map<String, Object> cateImgDetailView(OpenCate opencate);

    public int deleteImgDtlCUD(OpenCate saveVO);


}
