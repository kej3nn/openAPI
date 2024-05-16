package egovframework.admin.openinf.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.admin.opendt.service.OpenCate;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.file.service.FileVo;

/**
 * 사용자정보 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public interface OpenInfService {

    /**
     * 사용자 정보를 전체 조회한다.
     *
     * @param OpenInf
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenInfAllIbPaging(OpenInf OpenInf);

    /**
     * 사용자 정보를 전체 조회한다.
     *
     * @param OpenInf
     * @return
     * @throws Exception
     */
//	public OpenInf selectOpenInf(OpenInf OpenInf);
    public List<OpenInf> selectOpenInf(OpenInf OpenInf);

    public int openInfRegCUD(ArrayList<OpenOrgUsrRel> list, OpenInf saveVO, String status);

    public Map<String, Object> selectOpenInfDsListIbPaging(OpenInf openInf);

    public Map<String, Object> selectOpenInfViewPopUp(OpenInf openInf);

    public int getPrssState(OpenInf saveVO);

    public int getSrvCd(OpenInf saveVO);

    public Map<String, Object> selectExistOpenInfPopIbPaging(OpenInf openInf);

    public OpenInf selectExistOpenInfDtl(OpenInf OpenInf);

    public int openInfModifyAllCUD(ArrayList<OpenInf> list, String status, OpenInf openInf);

    public Map<String, Object> selectMetaDownIbPaging(OpenInf openInf);


    /**
     * 사용자 정보를 전체 조회한다.
     *
     * @param OpenInf
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenHisInfAllIbPaging(OpenInf openInf);

    /**
     * 메타정보를 조회한다.
     *
     * @param openHisInf
     * @param model
     * @return
     * @throws Exception
     */
    public List<OpenInf> selectOpenHisInfOne(OpenInf openInf);

    /**
     * 메타정보를 조회한다.
     *
     * @param openHisInf
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenHisInfOneList(OpenInf openInf);

    /**
     * 메타정보 변경이력의 상세팝업 화면으로 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> openHisInfOneDetailPopUp(OpenInf openInf);

    /**
     * 메타정보의 개방이력을 조회한다.
     *
     * @param openInf
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> openLogInfOneList(OpenInf openInf);

    /**
     * 메타정보의 메타조직직원관계를 조회한다.
     *
     * @param openOrgUsrRel
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOpenInfOrgUsrListIbPaging(OpenOrgUsrRel openOrgUsrRel);

    /**
     * 메타정보의 메타조직과 직원수를 추가한다
     *
     * @param openInf
     * @return
     * @throws Exception
     */
    public List<OpenInf> selectOpenOrgUsrCnt(OpenInf openInf);


    public int saveImgFileListCUD(OpenCate opencate, ArrayList<?> list, FileVo fileVo);

    public Map<String, Object> cateImgDetailView(OpenCate opencate);

    public int deleteImgDtlCUD(OpenCate saveVO);

    Result updateInfState(Params params);

    public Paging selectSftOpenInfListPaging(Params params);

    public Record stfopeninfDtl(Params params);

    public Object saveStfopeninf(HttpServletRequest request, Params params);

}
