package egovframework.admin.openinf.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.opendt.service.OpenCate;
import egovframework.admin.openinf.service.OpenInf;
import egovframework.admin.openinf.service.OpenInfService;
import egovframework.admin.openinf.service.OpenOrgUsrRel;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.WiseOpenConfig;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.exception.DBCustomException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.file.service.FileVo;
import egovframework.common.util.UtilString;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

@Service("OpenInfService")
public class OpenInfServiceImpl extends BaseService implements OpenInfService {

    @Resource(name = "OpenInfDAO")
    private OpenInfDAO openInfDAO;

    private static final Logger logger = Logger.getLogger(OpenInfServiceImpl.class.getClass());


    public Map<String, Object> selectOpenInfAllIbPaging(OpenInf openInf) {
        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            openInf.setAccCd(loginVO.getAccCd());                    //로그인 된 유저 권환 획득
            // 유저 입력 권한(부서별 or 개인별)
            openInf.setSysInpGbn(GlobalConstants.SYSTEM_INPUT_GBN);
            openInf.setInpOrgCd(loginVO.getOrgCd());    // 로그인 된 부서코드
            openInf.setInpUsrCd(loginVO.getUsrCd());    //로그인 된 유저 코드
        }
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfDAO.selectOpenInfListAll(openInf);
            int cnt = openInfDAO.selectOpenInfListAllCnt(openInf);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public List<OpenInf> selectOpenInf(OpenInf openInf) {
        List<OpenInf> result = new ArrayList<OpenInf>();
        try {
            result = openInfDAO.selectOpenInfList(openInf);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public int openInfRegCUD(ArrayList<OpenOrgUsrRel> list, OpenInf saveVO, String status) {
        int result = 0;
        int resultDup = 0;
        String infId = null;
        String[] array;
        OpenInf tagVO = null;

        try {
            if (WiseOpenConfig.STATUS_I.equals(status)) {
                int seq = openInfDAO.getSeq(saveVO);
                saveVO.setSeq(seq);
                
                // 2023-12. 테스트 위해 임시 설정 ::start
                // 아래 라인 주석이 원본 소스.. getInfId function 이 12c 에서 동작하지 않음.
                
                //infId = openInfDAO.getInfId(saveVO);
                infId = "OOWY4R001216HX1"+String.valueOf(seq);
                
                // 2023-12. 테스트 위해 임시 설정 ::end

                saveVO.setInfId(infId);
                result = openInfDAO.insert(saveVO);
            } else if ((WiseOpenConfig.STATUS_U.equals(status))) {
                infId = saveVO.getInfId();
                result = openInfDAO.update(saveVO);
            } else if ((WiseOpenConfig.STATUS_D.equals(status))) {
                infId = saveVO.getInfId();
                openInfDAO.deleteTag(infId);
                openInfDAO.delete(saveVO);
                result = 1;
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }

            OpenInf resultVO = new OpenInf();
            resultVO.setInfId(infId);

            if (WiseOpenConfig.STATUS_I.equals(status) || (WiseOpenConfig.STATUS_U.equals(status))) {
                for (OpenOrgUsrRel saveIbs : list) {
                    saveIbs.setInfId(infId);

                    if ("Y".equals(saveIbs.getRpstYn())) {    //대표여부가 Y 인경우
                        resultVO.setOrgCd(saveIbs.getOrgCd());    //tb_open_inf update 치기 위해 org와 usr 취득해둠
                        resultVO.setUsrCd(saveIbs.getUsrCd());
                    }

                    if (saveIbs.getStatus().equals("I")) {
                        result += openInfDAO.insertOrgUsrRel(saveIbs);
                    } else if (saveIbs.getStatus().equals("U")) {
                        result += openInfDAO.updateOrgUsrRel(saveIbs);
                    } else if (saveIbs.getStatus().equals("D")) {
                        result += openInfDAO.deleteOrgUsrRel(saveIbs);
                    } else {
                        result += 0;
                    }

                }
                openInfDAO.updateOpenOrgUsrCnt(resultVO);

                openInfDAO.deleteTag(infId);

                array = UtilString.getSplitArray(saveVO.getInfTag().trim(), ",");
                for (int i = 0; i < array.length; i++) {
                    tagVO = new OpenInf();

                    if (!UtilString.isBlank(array[i].trim())) {
                        tagVO.setInfId(infId);
                        tagVO.setInfTag(array[i].trim());

                        resultDup = openInfDAO.tagDup(tagVO);

                        if (resultDup == 0) {
                            openInfDAO.insertTag(tagVO);
                        }
                    }
                }
            }
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
            log.error("DataAccessException : ", dae);
            //procedure 리턴 메세지 표시.
            SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
            result = -1;
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            result = -2;
        }

        return result;
    }

    public Map<String, Object> selectOpenInfDsListIbPaging(OpenInf openInf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfDAO.selectOpenInfDsList(openInf);
            int cnt = openInfDAO.selectOpenInfDsListCnt(openInf);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectExistOpenInfPopIbPaging(OpenInf openInf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfDAO.selectExistOpenInf(openInf);
            int cnt = openInfDAO.selectExistOpenInfCnt(openInf);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    @Override
    public Map<String, Object> selectOpenInfViewPopUp(OpenInf openinf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfDAO.selectOpenInfViewPopUp(openinf);
            //서버 IP를 받아오기 위한 로직 - infUrl때문에 사용함
            //InetAddress ip = InetAddress.getLocalHost();
            //String hostIp = ip.getHostAddress();
            //result.get(0).setInfUrl(result.get(0).getInfUrl());


            map.put("result", result);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public int getPrssState(OpenInf saveVO) {
        int result = 0;
        try {
            result = openInfDAO.getPrssState(saveVO);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public int getSrvCd(OpenInf saveVO) {
        int result = 0;
        try {
            result = openInfDAO.getSrvCd(saveVO);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public OpenInf selectExistOpenInfDtl(OpenInf openInf) {
        OpenInf result = new OpenInf();
        try {
            result = openInfDAO.selectExistOpenInfDtl(openInf);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


    public int openInfModifyAllCUD(ArrayList<OpenInf> list, String status, OpenInf saveVO) {
        int result = 0;
        try {
            if ((WiseOpenConfig.STATUS_U.equals(status))) {
                for (OpenInf openInf : list) {
                    openInf.setOrgCdMod(saveVO.getOrgCdMod());
                    openInf.setUsrCdMod(saveVO.getUsrCdMod());
                    result = openInfDAO.openInfModifyAll(openInf);
                }
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public Map<String, Object> selectMetaDownIbPaging(OpenInf openInf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<LinkedHashMap<String, ?>> result = openInfDAO.selectMetaDownList(openInf);
            List<String> head = new ArrayList<String>();
            String[] strArray = {"서비스ID", "공공데이터명칭(국문)", "공공데이터명칭(영문)", "분류체계", "종분류체계", "소관부처", "보유근거", "위치(URL)정보", "키워드1", "키워드2", "키워드3", "공공데이터설명", "실무담당자ID", "제공 공공데이터명칭"
                    , "제공 공공데이터설명", "공표시점", "시작정보", "공표설명", "제3자권리포함유무", "이용허락 확보여부", "이용허락첨부파일명", "업데이트주기", "다음등록예정일", "비용부과유무", "금액", "비용부과단위", "비용부과첨부파일명"
                    , "공공데이터 제공형태", "파일첨부여부", "공공데이터 위치(URL)", "공공데이터 매체유형", "매체유형별 건수", "매체유형 확장자명", "언어입력코드", "기타 이용 유의사항"};
            for (int i = 0; i < strArray.length; i++) {
                head.add(strArray[i]);
            }
            map.put("resultList", result);
            map.put("head", head);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }


    public Map<String, Object> selectOpenHisInfAllIbPaging(OpenInf openInf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfDAO.selectOpenHisInfListAll(openInf);
            int cnt = openInfDAO.selectOpenHisInfListAllCnt(openInf);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }


    public List<OpenInf> selectOpenHisInfOne(OpenInf openInf) {
        List<OpenInf> result = new ArrayList<OpenInf>();
        try {
            result = openInfDAO.selectOpenHisInfOne(openInf);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;

    }


    public Map<String, Object> selectOpenHisInfOneList(OpenInf openInf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfDAO.selectOpenHisInfOneList(openInf);
            int cnt = openInfDAO.selectOpenHisInfOneListCnt(openInf);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }


    public Map<String, Object> openHisInfOneDetailPopUp(OpenInf openInf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            OpenInf result = openInfDAO.openHisInfOneDetailPopUp(openInf);
            map.put("result", result);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }


    public Map<String, Object> openLogInfOneList(OpenInf openInf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfDAO.openLogInfOneList(openInf);
            int cnt = openInfDAO.openLogInfOneListCnt(openInf);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    @Override
    public Map<String, Object> selectOpenInfOrgUsrListIbPaging(OpenOrgUsrRel openOrgUsrRel) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfDAO.selectOpenOrgUsrRelList(openOrgUsrRel);
            //int cnt = openInfDAO.selectOpenOrgUsrRelListCnt(openOrgUsrRel);
            map.put("resultList", result);
            //map.put("resultCnt", Integer.toString(cnt));
            map.put("resultCnt", result.size());

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    @Override
    public List<OpenInf> selectOpenOrgUsrCnt(OpenInf openInf) {

        return null;
    }

    ////////////////////////////////////// img 처리 serviceimpl //////////////////////////////////////////////
    //첨부파일 저장, 수정
    public int saveImgFileListCUD(OpenCate opencate, ArrayList<?> list, FileVo fileVo) {
        int result = 0;
        String fileName = "";
        String[] fileNames = fileVo.getSaveFileNm();
        for (String name : fileNames) {
            fileName = name;
        }

        try {
            for (int i = 0; i < list.size(); i++) {
                logger.debug("-----------------------------------------------------\n" + ((OpenCate) list.get(i)).getSaveFileNm());
                ((OpenCate) list.get(i)).setSaveFileNm(fileName);
                logger.debug("-----------------------------------------------------\n" + ((OpenCate) list.get(i)).getSaveFileNm());
                result += openInfDAO.updateImgFile((OpenCate) list.get(i));
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    @Override
    public Map<String, Object> cateImgDetailView(OpenCate opencate) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenCate> resultImg = openInfDAO.cateImgDetailView(opencate);
            //List<BbsList> resultTopYn = bbsListDAO.getTopImg(opencate);
            map.put("resultImg", resultImg);
            //map.put("resultTopYn", resultTopYn);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public int deleteImgDtlCUD(OpenCate opencate) {            // 수정 필요함..
        int result = 0;
        try {
            if (result > 1) {
                result = -1;
            } else {
                result = openInfDAO.deleteImg(opencate);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 통계표 공개상태를 공개/취소 한다.
     */
    @Override
    public Result updateInfState(Params params) {
        try {
            openInfDAO.updateInfState(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return success(getMessage("admin.message.000007"));
    }

    @Override
    public Paging selectSftOpenInfListPaging(Params params) {
        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            params.put("accCd", loginVO.getAccCd());    //로그인 된 유저 권환 획득
            // 유저 입력 권한(부서별 or 개인별)
            params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
            params.put("inpOrgCd", loginVO.getOrgCd());    // 로그인 된 부서코드
            params.put("inpUsrCd", loginVO.getUsrCd());    //로그인 된 유저 코드
        }

        Paging list = openInfDAO.selectSftOpenInfList(params, params.getPage(), params.getRows());

        return list;
    }

    @Override
    public Record stfopeninfDtl(Params params) {
        Record result = null;
        try {
            result = (Record) openInfDAO.selectSftOpenInfDtl(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    @Override
    public Object saveStfopeninf(HttpServletRequest request, Params params) {
        String[] array;
        OpenInf tagVO = null;
        int resultDup = 0;
        try {
            openInfDAO.saveStfopeninf(params);
            openInfDAO.deleteTag(params.getString("infId"));
            array = UtilString.getSplitArray(params.getString("infTag").trim(), ",");
            for (int i = 0; i < array.length; i++) {
                tagVO = new OpenInf();

                if (!UtilString.isBlank(array[i].trim())) {
                    tagVO.setInfId(params.getString("infId"));
                    tagVO.setInfTag(array[i].trim());

                    resultDup = openInfDAO.tagDup(tagVO);

                    if (resultDup == 0) {
                        openInfDAO.insertTag(tagVO);
                    }
                }
            }
            openInfDAO.execSpBcupOpenInf(params);
        } catch (DataAccessException dae) {
            error("DataAccessException : ", dae);
            //procedure 리턴 메세지 표시.
            SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
            throw new DBCustomException(getDbmsExceptionMsg(se));
        } catch (Exception e) {
            error("Exception : ", e);
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }
        return success(getMessage("admin.message.000006"));
    }
}