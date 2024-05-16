package egovframework.admin.openinf.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.openinf.service.OpenDs;
import egovframework.admin.openinf.service.OpenDsService;
import egovframework.admin.openinf.service.OpenDscol;
import egovframework.admin.openinf.service.OpenDtbl;
import egovframework.admin.openinf.web.OpenDsController;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.base.exception.DBCustomException;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.util.UtilString;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("OpenDsService")
public class OpenDsServiceImpl extends AbstractServiceImpl implements OpenDsService {

    @Resource(name = "OpenDsDAO")
    private OpenDsDAO openDsDAO;

    private static final Logger logger = Logger.getLogger(OpenInfServiceImpl.class.getClass());

    public Map<String, Object> selectOpenDsIbPaging(OpenDs opends) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDs> result = openDsDAO.selectOpenDsList(opends);
            int cnt = openDsDAO.selectOpenDsListCnt(opends);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectOpenDsColIbPaging(OpenDscol opendscol) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDscol> result = openDsDAO.selectOpenDsColList(opendscol);
            int cnt = openDsDAO.selectOpenDsColListCnt(opendscol);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectOpenDsSrcColIbPaging(OpenDscol opendscol) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDscol> result = openDsDAO.selectOpenDsSrcColList(opendscol);
            int cnt = openDsDAO.selectOpenDsSrcColListCnt(opendscol);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public Map<String, Object> selectOpenDsPopIbPaging(OpenDs opends) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDs> result = openDsDAO.selectOpenDsPopList(opends);
            int cnt = openDsDAO.selectOpenDsPopListCnt(opends);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectBackDsPopIbPaging(OpenDs opends) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDs> result = openDsDAO.selectBackDsPopList(opends);
            int cnt = openDsDAO.selectBackDsPopListCnt(opends);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> samplePopIbPaging(OpenDscol opendscol) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDscol> result = openDsDAO.selectSamplePopList(opendscol);
            int cnt = openDsDAO.selectOpenDsPopListCnt(opendscol);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    @Override
    public Map<String, Object> selectSamplePop(OpenDscol opendscol) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDscol> result = openDsDAO.selectSamplePop(opendscol);
            map.put("result", result);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public Map<String, Object> selectOpenDtPopIbPaging(OpenDs opends) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDs> result = openDsDAO.selectOpenDtPopList(opends);
            int cnt = openDsDAO.selectOpenDtPopListCnt(opends);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }
	
    /*public OpenDs selectOpenDsDtl(OpenDs opends) {
    	OpenDs opends1=openDsDAO.selectOpenDsDtl(opends);
		return  opends1;
    }*/

    public List<OpenDs> selectOpenDsDtl(OpenDs opends) {
        List<OpenDs> result = new ArrayList<OpenDs>();
        try {
            result = openDsDAO.selectOpenDsDtl(opends);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


    /**
     public int saveOpenDsCUD(OpenDs opends,String status) {
     int result = 0;
     if(WiseOpenConfig.STATUS_I.equals(status)){
     result = openDsDAO.insertDs(opends);
     }else if((WiseOpenConfig.STATUS_U.equals(status))){
     //        	result = openDsDAO.updateDs(opends);
     }else if((WiseOpenConfig.STATUS_D.equals(status))){
     //        	result = openDsDAO.deleteDs(opends);
     }else{
     result = WiseOpenConfig.STATUS_ERR;
     }
     return result;
     }
     */

    /**
     * 데이터셋 상세내용 및 컬럼 항목 저장
     */
    @Override
    public int saveOpenDsCUD(ArrayList<OpenDscol> list, OpenDscol saveVO) {
        int result = 0;
        //데이터셋 상세내용 저장
        result = saveOpenDsDtlCUD(saveVO, WiseOpenConfig.STATUS_I);

        if (result <= 0) {
            return result;
        }

        //데이터셋ID 추출
        String dsId = saveVO.getDsId();

        //데이터셋 컬럼 항목 저장
        for (OpenDscol openDscol : list) {
            openDscol.setDsId(dsId);    //상세내용 저장 후 나온 데이터셋ID 저장
            result += saveOpenDscolCUD(openDscol);
        }

        return result;

    }

    /**
     * 데이터셋 상세내용 저장
     *
     * @param saveVO
     * @param status
     * @return
     * @throws Exception
     */
    public int saveOpenDsDtlCUD(OpenDscol saveVO, String status) {
        int result = 0;
        try {
            if (WiseOpenConfig.STATUS_I.equals(status)) {
                result = openDsDAO.insertDs(saveVO);
            } else if ((WiseOpenConfig.STATUS_U.equals(status))) {
                result = openDsDAO.updateDs(saveVO);
            } else if ((WiseOpenConfig.STATUS_D.equals(status))) {
                result = openDsDAO.deleteDs(saveVO);
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }


    /**
     * 데이터셋 컬럼 항목 저장
     *
     * @param saveVO
     * @return
     * @throws Exception
     */
    public int saveOpenDscolCUD(OpenDscol saveVO) {
        int result = 0;
        try {
            if (saveVO.getStatus().equals("I")) {
                result += openDsDAO.insertDsCol(saveVO);
            } else if (saveVO.getStatus().equals("U")) {
                result += openDsDAO.updateDsCol(saveVO);
            } else if (saveVO.getStatus().equals("D")) {
                //saveVO.setDsCd( openDsDAO.selectDsCd(saveVO) ); //메타정보의 데이터를 삭제하기 위해 데이터구분 확인.
    			/*
			if( "RAW".equals(saveVO.getDsCd()) ){ //원시데이터
				result += openDsDAO.deleteInfScol(saveVO);
				result += openDsDAO.deleteInfCcol(saveVO);
				result += openDsDAO.deleteInfAcol(saveVO);
				result += openDsDAO.deleteInfMcol(saveVO);
			}else if( "TS".equals(saveVO.getDsCd()) ){ //통계데이터
				result += openDsDAO.deleteInfTcol(saveVO);
			}
    			 */
                result += openDsDAO.deleteInfScol(saveVO);
                result += openDsDAO.deleteInfCcol(saveVO);
                result += openDsDAO.deleteInfAcol(saveVO);
                result += openDsDAO.deleteInfMcol(saveVO);

                result += openDsDAO.deleteDsCol(saveVO);
            } else {
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }


    /**
     * 데이터셋 컬럼 항목 저장
     */
    @Override
    public int saveOpenDscolCUD(ArrayList<OpenDscol> list) {
        int result = 0;

        for (OpenDscol saveVO : list) { //col_seq가 중복되는것이 하나라도 있으면 실행불가.. 컬럼들 전부삭제후 해야함.
            if (saveVO.getStatus().equals("I")) { //추가는 Inesert
                result = selectOpenDscolDup(saveVO);
                if (result > 0) { //중복이되었다면 break
                    result = 100;
                    break;
                }
            }
        }


        if (result != 100) { //insert하다 중복이 안되었다면 실행.
            for (OpenDscol saveVO : list) {
                result += saveOpenDscolCUD(saveVO); // 임시로 주석처리 여기가 중요함
            }
        }

        return result;

    }

    /**
     * col_seq가 중복되는것이 하나라도 있으면 실행불가.. 컬럼들 전부삭제후 해야함.
     *
     * @param selectVO
     * @return
     * @throws Exception
     */
    private int selectOpenDscolDup(OpenDscol selectVO) {
        int result = 0;
        try {
            result = openDsDAO.selectOpenDscolDup(selectVO);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }

    /**
     * 데이터셋 테이블 항목 저장
     *
     * @param saveVO
     * @return
     * @throws Exception
     */
    public int saveOpenDsTableCUD(OpenDtbl saveVO) {
        int result = 0;
        String ownTabId[] = UtilString.getSplitArray(saveVO.getOwnTabId(), ".");
        saveVO.setOwnerCd(ownTabId[0]);
        saveVO.setTbId(ownTabId[1]);
        if (saveVO.getStatus().equals("I")) {
        } else if (saveVO.getStatus().equals("U")) {
        } else if (saveVO.getStatus().equals("D")) {
        } else {
        }

        return result;
    }

    /**
     * 데이터셋 테이블 항목 저장
     */
    @Override
    public int saveOpenDsTableListCUD(ArrayList<OpenDtbl> list) {
        int result = 0;
        for (OpenDtbl saveVO : list) {
            result += saveOpenDsTableCUD(saveVO);
        }
        return result;
    }


    //OpenInf에서 사용중인지 확인
    public int selectOpenCdCheck(OpenDscol saveVO) {
        int result = 0;
        try {
            result = openDsDAO.selectOpenCdCheck(saveVO);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    //dsId 중복 확인
    public int dupDsId(OpenDscol saveVO) {
        int result = 0;
        try {
            result = openDsDAO.dupDsId(saveVO);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


    /**
     * 관련 데이터셋 리스트 조회(공표기준등록 및 수정에서 사용)
     *
     * @param opends
     * @return
     * @throws Exception
     */
    public Map<String, Object> openPubCfgRefDsPopUpListIbPaging(OpenDs opends) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDs> result = openDsDAO.selectOpenPubCfgRefDsPopUpList(opends);
            int cnt = result.size();
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    // 재정용어 목록 조회
    public Map<String, Object> selectOpenDsTermPopListIbPaging(OpenDscol openDscol) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDs> result = openDsDAO.selectOpenDsTermPopList(openDscol);
            int cnt = openDsDAO.selectOpenDsTermPopListCnt(openDscol);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 2017/10/11 - 김정호
    // 	 * 데이터셋 관리 화면 변경(신규 추가된 항목들) [시작]
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////

    /**
     * 데이터셋 컬럼유형정보 조회
     *
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectOpenDscoltyCd() {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            result = openDsDAO.selectOpenDscoltyCd();
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 데이터셋 입력/수정/삭제
     * 3개 테이블 함께 처리(TB_OPEN_DSCOL, TB_OPEN_DSCOL, TB_OPEN_DS_USR)
     */
    @Override
    public Result saveOpenDsAll(Params params) {
        String status = params.getString(OpenDsController.ACTION_STATUS);

        try {
            Result result = new Result();

            if (OpenDsController.ACTION_INS.equals(status) || OpenDsController.ACTION_UPD.equals(status)) {
                /* 공공데이터셋 상세정보 CU */
                saveOpenDs(params);

                /* 공공데이터셋 컬럼정보 CUD */
                saveOpenDsCol(params);

                /* 공공데이터셋 유저정보 CUD */
                saveOpenDsUsr(params);

                /* 데이터셋 스케쥴 생성 */
                // 2023-12. 테스트 위해 임시 설정 ::start
                // 12c에서 아래 execSpCreateOpenLdlist 실행 안됨.
                
                //openDsDAO.execSpCreateOpenLdlist(params);
                
                // 2023-12. 테스트 위해 임시 설정 ::end

            } else if (OpenDsController.ACTION_DEL.equals(status)) {
                /* 데이터셋 삭제 프로시져 호출 */
                openDsDAO.execSpDelOpenDs(params);
            }

            result.put(Result.SUCCESS, true);
            result.put(Result.MESSAGES, "정상적으로 처리 되었습니다.");

            return result;
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
//			log.error("DataAccessException : " , dae);
            //procedure 리턴 메세지 표시.
            SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
            throw new DBCustomException(getDbmsExceptionMsg(se));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("처리 도중 에러가 발생하였습니다.");
        }
    }

    /**
     * 공공데이터셋 상세정보 입력/수정(단건 등록)
     *
     * @param params
     * @throws Exception
     */
    private void saveOpenDs(Params params) {

        String status = params.getString(OpenDsController.ACTION_STATUS);

        OpenDs openDs = new OpenDs();
        openDs.setDsId(params.getString("dsId"));
        openDs.setDsNm(params.getString("dsNm"));
        openDs.setOwnerCd(params.getString("ownerCd"));
        openDs.setDtId(params.getInt("dtId"));
        openDs.setDsExp(params.getString("dsExp"));
        openDs.setUseYn(params.getString("useYn"));
        openDs.setStddDsYn(params.getString("stddDsYn"));
        openDs.setKeyDbYn(params.getString("keyDbYn"));
        openDs.setBcpOwnerCd(params.getString("bcpOwnerCd"));
        openDs.setBcpDsId(params.getString("bcpDsId"));
        openDs.setSessionUsrId(params.getString("regId"));
        openDs.setConntyCd(params.getString("conntyCd"));
        openDs.setLoadCd(params.getString("loadCd"));
        openDs.setAutoAccYn(params.getString("autoAccYn"));
        openDs.setLddataCd(params.getString("lddataCd"));

        try {
            if (OpenDsController.ACTION_INS.equals(status)) {
                openDsDAO.insertDs(openDs);
            } else if (OpenDsController.ACTION_UPD.equals(status)) {
                openDsDAO.updateDs(openDs);
            } else if (OpenDsController.ACTION_DEL.equals(status)) {

            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
    }

    /**
     * 공공데이터셋 컬럼정보 입력/수정/삭제
     * - 컬럼정보 for loop으로 처리
     *
     * @param params
     * @throws Exception
     */
    private void saveOpenDsCol(Params params) throws JSONException {
        OpenDscol openDscol = null;
        String dsId = params.getString("dsId");

        //ibsheet에서 넘어온 컬럼 json data
        JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
        for (int i = 0; i < jsonArray.length(); i++) {
            openDscol = new OpenDscol();
            JSONObject jsonObj = (JSONObject) jsonArray.get(i);
            String status = jsonObj.getString("status");

            if (!status.equals("R")) {
                openDscol.setStatus(jsonObj.getString("status"));
                //openDscol.setDsId(jsonObj.getString("dsId"));
                openDscol.setDsId(dsId);
                openDscol.setColId(jsonObj.getString("colId"));
                openDscol.setColNm(jsonObj.getString("colNm"));
                openDscol.setUnitCd(jsonObj.getString("unitCd"));
                openDscol.setColExp(jsonObj.getString("colExp"));
                openDscol.setUseYn(jsonObj.getString("useYn"));
                openDscol.setAddrCd(jsonObj.getString("addrCd"));
                openDscol.setPkYn(jsonObj.getString("pkYn"));
                openDscol.setNeedYn(jsonObj.getString("needYn"));
                openDscol.setColRefCd(jsonObj.getString("colRefCd"));
                openDscol.setSessionUsrId(params.getString("regId"));
                //verifyId가 입력시는 공백값도 String으로 넘어오지만 입력되어 있는 값 수정 할 경우 number 값으로 넘어와서 type 체크.
                if (jsonObj.get("verifyId") instanceof Number) {
                    openDscol.setVerifyId(jsonObj.getInt("verifyId"));
                } else if (jsonObj.get("verifyId") instanceof String && !"".equals(jsonObj.getString("verifyId"))) {
                    openDscol.setVerifyId(Integer.parseInt(jsonObj.getString("verifyId")));
                }

                if (status.equals("I")) {
                    //최초 입력시에만 원본관련 컬럼에 데이터 입력
                    openDscol.setSrcColId(jsonObj.getString("colId"));
                    openDscol.setSrcColType(jsonObj.getString("srcColType"));
                    //openDscol.setSrcColSize(jsonObj.getInt("srcColSize"));
                    if (jsonObj.get("srcColSize") instanceof Number) {
                        openDscol.setSrcColSize(jsonObj.getInt("srcColSize"));
                    }
                    if (jsonObj.get("srcColScale") instanceof Number) {
                        openDscol.setSrcColScale(jsonObj.getInt("srcColScale"));
                    }
                    try {
                        openDsDAO.insertDsCol(openDscol);

                    } catch (Exception e) {
                        EgovWebUtil.exTransactionLogging(e);
                    }
                } else if (status.equals("U")) {
                    openDscol.setColSeq(jsonObj.getInt("colSeq"));    //colSeq는 수정/삭제 인경우에만 존재
                    openDscol.setvOrder(jsonObj.getInt("vOrder"));    //vOrder는 수정/삭제 인경우에만 존재

                    // 수정일때도 사이즈는 변경가능하도록 수정
                    if (jsonObj.get("srcColSize") instanceof Number) {
                        openDscol.setSrcColSize(jsonObj.getInt("srcColSize"));
                    }
                    if (jsonObj.get("srcColScale") instanceof Number) {
                        openDscol.setSrcColScale(jsonObj.getInt("srcColScale"));
                    }
                    try {
                        openDsDAO.updateDsCol(openDscol);

                    } catch (Exception e) {
                        EgovWebUtil.exTransactionLogging(e);
                    }
                } else if (status.equals("D")) {
                    openDscol.setColSeq(jsonObj.getInt("colSeq"));    //colSeq는 수정/삭제 인경우에만 존재
                    openDscol.setvOrder(jsonObj.getInt("vOrder"));    //vOrder는 수정/삭제 인경우에만 존재
                    try {
                        openDsDAO.deleteDsCol(openDscol);

                    } catch (Exception e) {
                        EgovWebUtil.exTransactionLogging(e);
                    }
                }
            }
        }
    }

    /**
     * 공공데이터셋 유저정보 입력/수정/삭제
     * - merge into 처리
     *
     * @param params
     */
    private void saveOpenDsUsr(Params params) throws JSONException {
        int updCnt = 0;
        int usrCnt = 0;

        String dsId = params.getString("dsId");
        String regId = params.getString("regId");
        String updId = params.getString("updId");

        Map<String, LinkedList<Record>> pMap = new HashMap<String, LinkedList<Record>>();
        LinkedList<Record> usrList = new LinkedList<Record>();
        Record usrRec = null;

        //ibsheet에서 넘어온 유저 json data
        JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson2")).getJSONArray("data");
        for (int i = 0; i < jsonArray.length(); i++) {
            usrRec = new Record();
            JSONObject jsonObj = (JSONObject) jsonArray.get(i);
            usrRec.put("dsId", dsId);
            usrRec.put("usrCd", StringUtils.isEmpty(jsonObj.getString("usrCd")) ? "0" : jsonObj.getString("usrCd"));
            usrRec.put("orgCd", jsonObj.getString("orgCd"));
            usrRec.put("prssAccCd", jsonObj.getString("prssAccCd"));
            usrRec.put("vOrder", i + 1);
            if (!StringUtils.isEmpty(jsonObj.getString("status")) && "D".equals(jsonObj.getString("status"))) {
                //상태가 삭제 인 경우
                usrRec.put("useYn", "N");
            } else {
                usrRec.put("useYn", jsonObj.getString("useYn"));
            }
            usrRec.put("regId", regId);
            usrRec.put("updId", updId);
            usrList.add(usrCnt++, usrRec);
        }

        pMap.put("pMap", usrList);

        try {
            //통계설명 관리담당자 수정
            openDsDAO.delOpenDsUsr(params);                        //데이터 일괄 삭제
            updCnt = (Integer) openDsDAO.mergeOpenDsUsr(pMap);    //merge into 처리

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        if (updCnt <= 0) {
            //throw new ServiceException("처리도중 에러가 발생하였습니다[3]");
        }
    }

    /**
     * 공공데이터 관리담당자 목록 조회
     */
    public List<Record> selectOpenDsUsrList(Params params) {
        List<Record> result = new ArrayList<Record>();
        try {
            result = (List<Record>) openDsDAO.selectOpenDsUsrList(params);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * DBMS Exception 메세지를 추출한다.
     *
     * @param obj DB에서 받아온 에러 메세지 전문
     * @return
     */
    private String getDbmsExceptionMsg(Object obj) {
        String str = "[ERROR] DATABASE 에러가 발생하였습니다.";
        if (obj instanceof java.lang.Exception) {
            String msg = ((Exception) obj).getMessage();
            String[] msgs = msg.split("\n");
            if (msg.contains("JDBC") || msg.contains("ORA-")) {
                str = msgs[0].substring(msgs[0].indexOf(":")).replaceAll(":", "").replaceAll("\"", "");
            } else {
                str = msgs[0];
            }

        }
        return str;
    }

    /**
     * 데이터셋 테이블이 실제 존재하는지 확인
     */
    @Override
    public Map<String, Integer> selectExistSrcDsId(Params params) {
        Map<String, Integer> map = new HashMap<String, Integer>();
        try {
            map.put("existCnt", (Integer) openDsDAO.selectExistSrcDsId(params));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

}