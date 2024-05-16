package egovframework.admin.openinf.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.openinf.service.OpenDsInputService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.exception.DBCustomException;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.util.UtilExcelDtChck;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

@Service(value = "openDsInputService")
public class OpenDsInputServiceImpl extends BaseService implements OpenDsInputService {

    //배치 카운트
    private static final int BATCH_COUNT = 500;

    //최대 파일 크기
    private static final long MAX_FILE_SIZE = 1024 * 1024 * 20;

    //입력상태 변경시 검증 오류 체크해야하는 코드들(승인, 승인취소) 
    public static final String[] VERIFY_CHK_LDSTATE_CD = new String[]{"AW", "AC"};

    @Resource(name = "openDsInputDao")
    protected OpenDsInputDao openDsInputDao;

    public List<Record> selectOption(Params params) {
        return (List<Record>) openDsInputDao.selectOption(params);
    }

    /**
     * 공공데이터 메인 입력 스케쥴 리스트 조회
     */
    @Override
    public List<Record> openDsInputList(Params params) {
        if (params.getStringArray("loadCd") != null) {    //입력주기
            params.set("loadCdArr", new ArrayList<String>(Arrays.asList(params.getStringArray("loadCd"))));
        }
        if (params.getStringArray("ldstateCd") != null) {    //입력상태
            params.set("ldstateCdArr", new ArrayList<String>(Arrays.asList(params.getStringArray("ldstateCd"))));
        }

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

        return (List<Record>) openDsInputDao.selectOpenDsInputList(params);
    }

    /**
     * 공공데이터 입력 상세 조회
     */
    @Override
    public Record openDsInputDtl(Params params) {
        Record record = new Record();
        //상세 데이터
        record.put("DATA", openDsInputDao.selectOpenDsInputDtl(params));

        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();

            // 유저 입력 권한(부서별 or 개인별)
            params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
            params.put("inpOrgCd", loginVO.getOrgCd());    // 로그인 된 부서코드
            params.put("inpUsrCd", loginVO.getUsrCd());    //로그인 된 유저 코드

            //관련 통계표 유저정보 가져온다.(권한정보 획득)
            record.put("DATA2", openDsInputDao.selectOpenDsUsrList(params));
        }

        return record;
    }

    /**
     * 공공데이터 입력 데이터셋 컬럼 조회
     */
    @Override
    public List<Record> openDsInputCol(Params params) {
        return (List<Record>) openDsInputDao.selectOpenDsInputCol(params);
    }

    /**
     * 공공데이터 입력 시트 조회
     */
    @Override
    public List<Record> openDsInputData(Params params) {
        int listIdx = 0;
        List<Record> list = new LinkedList<Record>();
        Map<String, Record> map = new LinkedHashMap<String, Record>();

        Record record = null;

        //데이터 ROW_SEQCE_NO DISTINCT List
        List<Record> rowSeqList = (List<Record>) openDsInputDao.selectOpenDsInputDataRowSeq(params);

        //실제 데이터
        List<Record> dataList = (List<Record>) openDsInputDao.selectOpenDsInputData(params);

        if (rowSeqList.size() > 0) {    //rowSeqList가 있으면 실 데이터도 존재
            for (Record rowSeq : rowSeqList) {
                record = new Record();
                String rowSeqceNo = String.valueOf(rowSeq.getInt("disRowSeqceNo"));
                record.put("colSeq", rowSeqceNo);
                //rowSeqceNo를 map객체에 저장해 놓고
                map.put(rowSeqceNo, record);
            }

            for (Record data : dataList) {
                //실제 데이터를 loop 돌면서 이전에 map 객체에 생성해둔 rowSeqceNo에 col값과 데이터 입력
                String rowSeqceNo = String.valueOf(data.getInt("rowSeqceNo"));
                String colSeqceNo = String.valueOf(data.getInt("colSeqceNo"));
                map.get(rowSeqceNo).put("col_" + colSeqceNo, data.getString("dataVal"));
            }

            //ibSheet에서 조회하기 위해 map -> list로 변환
            Set<String> entrySet = map.keySet();
            Iterator<String> iter = entrySet.iterator();
            while (iter.hasNext()) {
                String key = iter.next();
                list.add(listIdx++, map.get(key));
            }
        }

        return list;
    }

    /**
     * 공공데이터 입력 양식 다운로드
     */
    @Override
    public LinkedList<LinkedList<String>> down2OpenDsInputForm(Params params) {
        //데이터셋 컬럼리스트
        List<Record> colList = (List<Record>) openDsInputDao.selectOpenDsInputCol(params);
        //Return List
        LinkedList<LinkedList<String>> list = new LinkedList<LinkedList<String>>();

        LinkedList<String> tmp = new LinkedList<String>();
        //tmp.add("colSeq");	//일련번호 삭제(사용안함)
        for (Record r : colList) {
            tmp.add("col_" + String.valueOf(r.getInt("colSeq")) + "_" + r.getString("needYn"));
        }
        list.add(tmp);    //첫번째 행으로 입력


        tmp = new LinkedList<String>();
        //tmp.add("일련번호");	//일련번호 삭제(사용안함)
        for (Record r : colList) {
            if ("Y".equals(r.getString("needYn"))) {
                tmp.add(r.getString("colNm") + " (*)");
            } else {
                tmp.add(r.getString("colNm"));
            }

        }
        list.add(tmp);    //두번째 행으로 입력

        return list;
    }

    /**
     * 시트 입력내용 저장
     */
    @Override
    public Result saveOpenInputData(Params params) {
        int iTotalBatchCnt = 0;
        try {

            params.put("ldstateCd", "PG");    //입력상태(저장)으로 저장

            //검증 리스트
            List<Record> verifyList = (List<Record>) openDsInputDao.selectOpenDsVerifyData(params);

            //입력 리스트 객체 생성
            LinkedList<Record> inputList = new LinkedList<Record>();
            Record record = null;

            JSONArray jArr = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");

            for (int i = 0; i < jArr.length(); i++) {
                //행 단위 loop
                JSONObject jObj = (JSONObject) jArr.get(i);
                Iterator<?> keys = jObj.keys();

                //행 seq 번호
                //int rowSeqceNo = Integer.parseInt(jObj.getString("colSeq"));	//일련번호 사용안함(삭제)
                while (keys.hasNext()) {
                    //컬럼 단위 loop
                    String key = (String) keys.next();
                    if (key.indexOf("col_") > -1) {    //엑셀 양식의 컬럼 이름이 col_1(col_컬럼번호)로 엑셀에 숨겨져 있음
                        int colSeqceNo = Integer.parseInt(key.replace("col_", ""));
                        String dataVal = jObj.getString(key);
                        record = new Record();
                        record.put("rowSeqceNo", i + 1);    //row번호 1부터 시작
                        record.put("colSeqceNo", colSeqceNo);
                        record.put("dataVal", dataVal);

                        if (verifyList.size() > 0) {
                            for (Record verify : verifyList) {
                                int colSeq = verify.getInt("colSeq");
                                if (colSeqceNo == colSeq) {
                                    record.put("verifyId", verify.getInt("verifyId"));
                                    if (dataVal.equals("")) {
                                        //패턴값 검증하는데 값이 없을경우는 검증결과 pass
                                        record.put("verifyYn", "Y");
                                    } else {
                                        String pattern = verify.getString("verifyPatn");
                                        boolean verifyRslt = Pattern.matches(pattern, dataVal);
                                        record.put("verifyYn", (verifyRslt ? "Y" : "N"));
                                    }
                                }
                            }
                        }

                        inputList.add(record);
                    }
                }
            }

            if (inputList.size() > 0) {
                //LDLIST_SEQ 기준으로 먼저 데이터 지우고
                openDsInputDao.deleteOpenDsInputData(params);

                /* 데이터 입력(배치처리) */
                openDsInputDao.startBatch();
                for (Record input : inputList) {
                    input.put("dsId", params.getString("dsId"));
                    input.put("colSeq", input.getInt("colSeqceNo"));
                    input.put("ldlistSeq", params.getInt("ldlistSeq"));
                    input.put("ldstateCd", params.getString("ldstateCd"));
                    input.put("verifyYn", StringUtils.isEmpty(input.getString("verifyYn")) ? "Y" : input.getString("verifyYn"));    //검증대상이 아니여서 값이 안넘어올 경우는 'Y' 입력
                    openDsInputDao.insertOpenDsInputData(input);
                    iTotalBatchCnt++;

                    if (iTotalBatchCnt > 0 && iTotalBatchCnt % BATCH_COUNT == 0) {
                        openDsInputDao.executeBatch();
                        openDsInputDao.startBatch();
                    }
                }
                openDsInputDao.executeBatch();

                /* 공공데이터 입력 처리상태 기록 */
                openDsInputDao.insertLogOpenLdlist(params);

                return success(getMessage("admin.message.000006"));
            } else {
                return success("저장 할 데이터가 없습니다");
            }

        } catch (ServiceException sve) {
            //params.put("procRslt", sve.getMessage());
            EgovWebUtil.exTransactionLogging(sve);
            return failure(getMessage("시스템 오류가 발생하였습니다"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            //return failure("시스템 오류가 발생하였습니다.");
            //throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
            throw new ServiceException(getMessage("시스템 오류가 발생하였습니다"));
            //return failure(getMessage("시스템 오류가 발생하였습니다"));
        }
    }

    /**
     * 공공데이터 엑셀 파일 저장
     */
    @Override
    public Result saveOpenInputExcelData(Params params) {
        int iTotalBatchCnt = 0;

        try {
            params.put("ldstateCd", "WW");    //엑셀저장은 입력상태(대기)으로 저장

            //검증 리스트

            List<Record> verifyList = (List<Record>) openDsInputDao.selectOpenDsVerifyData(params);
            /* 엑셀에서 입력 값 읽어 온다 */
            LinkedList<Record> inputList = readOpenInputFormData(params);

            if (inputList.size() > 0 && verifyList.size() > 0) {
                for (Record verify : verifyList) {
                    int colSeq = verify.getInt("colSeq");
                    for (Record input : inputList) {
                        if (colSeq == input.getInt("colSeqceNo")) {
                            String dataVal = input.getString("dataVal");
                            input.put("verifyId", verify.getInt("verifyId"));
                            if (dataVal.equals("")) {
                                //패턴값 검증하는데 값이 없을경우는 검증결과 pass
                                input.put("verifyYn", "Y");
                            } else {
                                String pattern = verify.getString("verifyPatn");
                                boolean verifyRslt = Pattern.matches(pattern, dataVal);
                                input.put("verifyYn", (verifyRslt ? "Y" : "N"));
                            }
                        }
                    }
                }
            }

            if (inputList.size() > 0) {
                //LDLIST_SEQ 기준으로 먼저 데이터 지우고
                openDsInputDao.deleteOpenDsInputData(params);

                /* 데이터 입력(배치처리) */
                openDsInputDao.startBatch();
                for (Record input : inputList) {
                    input.put("dsId", params.getString("dsId"));
                    input.put("colSeq", input.getInt("colSeqceNo"));
                    input.put("ldlistSeq", params.getInt("ldlistSeq"));
                    input.put("ldstateCd", params.getString("ldstateCd"));
                    //input.put("verifyYn",  StringUtils.isEmpty(input.getString("verifyYn")) ? "N" : "Y" );
                    input.put("verifyYn", StringUtils.isEmpty(input.getString("verifyYn")) ? "Y" : input.getString("verifyYn"));    //검증대상이 아니여서 값이 안넘어올 경우는 'Y' 입력
                    openDsInputDao.insertOpenDsInputData(input);
                    iTotalBatchCnt++;

                    if (iTotalBatchCnt > 0 && iTotalBatchCnt % BATCH_COUNT == 0) {
                        openDsInputDao.executeBatch();
                        openDsInputDao.startBatch();
                    }
                }
                openDsInputDao.executeBatch();

                /* 공공데이터 입력 처리상태 기록 */
                openDsInputDao.insertLogOpenLdlist(params);

                return success(getMessage("admin.message.000006"));
            } else {
                return success("저장 할 데이터가 없습니다");
            }

        } catch (ServiceException sve) {
            //params.put("procRslt", sve.getMessage());
            EgovWebUtil.exTransactionLogging(sve);
            return failure(getMessage("시스템 오류가 발생하였습니다"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            //params.put("procRslt", getMessage("시스템 오류가 발생하였습니다."));
            //return failure("시스템 오류가 발생하였습니다.");
            //throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
            throw new ServiceException(getMessage("시스템 오류가 발생하였습니다"));
        }
    }

    /**
     * 엑셀 입력양식 읽어온다
     *
     * @param params
     * @return
     * @throws Exception
     */
    private LinkedList<Record> readOpenInputFormData(Params params) {
        String dsId = params.getString("dsId");        //데이터셋 ID
        LinkedList<Record> inputList = new LinkedList<Record>();
        Record cell = null;

        try {
            // 워크북을 가져온다.
            Workbook workbook = getWorkbook(params);

            // 시트를 가져온다.
            Sheet sheet = getSheet(workbook);

            //양식 파일 체크
            if (!dsId.equals(sheet.getSheetName())) {
                throw new ServiceException("업로드 하는 입력양식이 다운받은 양식파일이 아닙니다.\n파일을 확인하세요.");
            }

            int startDataRow = 2;
            int currentDataRow = 0;
            int rowSeqceNo = 0;
            ArrayList<String> arrRowSeqNo = new ArrayList<String>();

            Row firRow = sheet.getRow(0);    //첫번째 row
            Row secRow = sheet.getRow(1);    //두번째 row
            short startCol = firRow.getFirstCellNum();
            short endCol = firRow.getLastCellNum();

            Iterator<Row> iterator = sheet.iterator();

            while (iterator.hasNext()) {    //Row iter
                currentDataRow++;
                Row currentRow = iterator.next();

                //2번째행(데이터행)부터 시작
                if (currentDataRow > startDataRow) {
                    rowSeqceNo++;    //row 일련번호 1씩 증가
                    //컬럼 for..loop
                    for (short i = startCol; i < endCol; i++) {
                        Cell currentCell = currentRow.getCell(i);
                        //첫번째 컬럼인경우(일련번호(기준정보)가 담겨있음)
		        		/* 엑셀에서 일련번호 사용 안하기로함
		        		if ( i == startCol ) {	
		        			if ( currentCell == null ) {
		        				throw new ServiceException("엑셀 파일의 일련번호는 필수 입력값 입니다");
		        			} else {
		        				//일련번호 값이 있는 경우 값이 숫자인지 체크
		        				String cellVal = OpenDtchckServiceImpl.getCellValue(currentCell);
			        			if ( !Pattern.matches("^[0-9]*$", cellVal) ) {
			        				throw new ServiceException("엑셀 파일의 일련번호가 숫자형식이 아닙니다");
			        			} else {
			        				//숫자일 경우
			        				rowSeqceNo = cellVal;
			        				//일련번호 중복체크(일련번호는 키 값이므로 중복체크 한다)
		        					if ( !arrRowSeqNo.contains(rowSeqceNo) ) {
		        						arrRowSeqNo.add(rowSeqceNo);
		        					} else {
		        						throw new ServiceException("엑셀 파일의 일련번호는 중복될 수 없습니다");
		        					}
			        			}
		        			}
		        		}
		        		*/
                        String firRowCd = UtilExcelDtChck.getCellValue(firRow.getCell(i));    //첫번째 row(컬럼_colSeqceNo_needYn) => col_1_Y
                        String[] arrFirRowCd = firRowCd.split("_");        //[0] = col, [1] = colSeqceNo값, [2] = needYn(컬럼 필수입력) 여부

                        //첫번째 컬럼이 아닌경우 null 값 체크
                        if (currentCell == null) {
                            if (firRowCd.indexOf("col_") > -1) {    //데이터 컬럼은 col_으로 시작
                                if (arrFirRowCd[2].equals("Y")) {    //필수입력 컬럼일경우 exception 처리
                                    String colDesc = UtilExcelDtChck.getCellValue(secRow.getCell(i)).replaceAll("\\(\\*\\)", "");
                                    throw new ServiceException(String.valueOf(currentDataRow - startDataRow) + "째 행에 " + colDesc + "값이 누락되었습니다");
                                } else {
                                    //값이 공백이지만 필수 입력이 아닌 경우 계속 for문 수행
                                    continue;
                                }
                            }
                        } else {
                            //null값이 아닌 경우
                            //if ( currentCell.getColumnIndex() > 0 && firRowCd.indexOf("col_") > -1 ) {
                            if (firRowCd.indexOf("col_") > -1) {
                                //데이터 컬럼행인 경우
                                String cellVal = UtilExcelDtChck.getCellValue(currentCell);
                                cell = new Record();
                                cell.put("rowSeqceNo", rowSeqceNo);
                                cell.put("colSeqceNo", Integer.parseInt(arrFirRowCd[1]));
                                cell.put("dataVal", cellVal);
                                inputList.add(cell);    //값을 list에 추가
                            }
                        }
                    }
                }
            }
            return inputList;

        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
            throw new ServiceException(getMessage("시스템 오류가 발생하였습니다"));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            //return failure("시스템 오류가 발생하였습니다.");
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }


    }

    /**
     * 공공데이터 입력 검증 실패 데이터 조회
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Record> openDsInputVerifyData(Params params) {
        return (List<Record>) openDsInputDao.selectOpenDsInputVerifyData(params);
    }

    /**
     * 데이터 입력 상태 변경
     */
    @Override
    public Result updateOpenLdlistCd(Params params) {
        try {
            int verifyCnt = 0;
            String ldstateCd = params.getString("ldstateCd");    //입력상태 코드
            String ldstateNm = params.getString("ldstateNm");    //입력상태 명

            //검증 리스트
            List<Record> verifyList = (List<Record>) openDsInputDao.selectOpenDsVerifyData(params);
            //실제 데이터
            List<Record> dataList = (List<Record>) openDsInputDao.selectOpenDsInputData(params);

            /* 데이터를 입력하고 데이터셋 검증 컬럼형식을 변경할 수 도 있으므로
             * 실 데이터를 가지고 한번 더 검증 체크
             *  */
            if (dataList.size() > 0 && verifyList.size() > 0) {
                for (Record verify : verifyList) {
                    int colSeq = verify.getInt("colSeq");
                    for (Record data : dataList) {
                        if (colSeq == data.getInt("colSeqceNo")) {
                            String dataVal = data.getString("dataVal");
                            data.put("verifyId", verify.getInt("verifyId"));
                            if (dataVal.equals("")) {
                                //패턴값 검증하는데 값이 없을경우는 검증결과 pass
                                data.put("verifyYn", "Y");
                            } else {
                                String pattern = verify.getString("verifyPatn");
                                boolean verifyRslt = Pattern.matches(pattern, dataVal);
                                data.put("verifyYn", (verifyRslt ? "Y" : "N"));
                            }

                            data.put("verifyYn", StringUtils.isEmpty(data.getString("verifyYn")) ? "Y" : data.getString("verifyYn"));    //검증대상이 아니여서 값이 안넘어올 경우는 'Y' 입력
                            //현재 검증상태 재 업데이트
                            openDsInputDao.updateOpenLddataVerify(data);
                            if ("N".equals(data.getString("verifyYn"))) {    //검증결과 fail이면
                                verifyCnt++;
                            }
                        }
                    }
                }
            }

            //검증 체크 할 필요 없는 항목은 pass
            boolean verifyChk = Arrays.asList(VERIFY_CHK_LDSTATE_CD).contains(ldstateCd);
            if (verifyCnt > 0 && verifyChk) {
                throw new ServiceException(String.valueOf(verifyCnt) + "건의 오류가 발견되었습니다.\n[" + ldstateNm + "]할 수 없습니다");
            }

            //승인요청(자동승인 AW)과 승인(AC) flag 상태에서만 호출함
            if (("AW".equals(ldstateCd) && "Y".equals(params.getString("autoAccYn")))
                    || ("AC".equals(ldstateCd))) {
                /* 승인전 테이블 생성 */
                openDsInputDao.execSpCreateOpenDs(params);
            }

            /* 공공데이터 입력 처리상태 기록 */
            openDsInputDao.insertLogOpenLdlist(params);

            //승인요청(자동승인 AW)과 승인(AC) flag 상태에서만 호출함
            if (("AW".equals(ldstateCd) && "Y".equals(params.getString("autoAccYn")))
                    || ("AC".equals(ldstateCd))) {
                /* 데이터입력 스케쥴 생성 */
                openDsInputDao.execSpCreateOpenLdlist(params);
            }

            return success(getMessage("정상적으로 " + ldstateNm + " 하였습니다."));

        } catch (ServiceException se) {
            EgovWebUtil.exTransactionLogging(se);
            return failure(se.getMessage());
        } catch (DataAccessException dae) {
            error("DataAccessException : ", dae);
            EgovWebUtil.exTransactionLogging(dae);
            SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
            throw new DBCustomException(getDbmsExceptionMsg(se));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            return failure("처리 도중 에러가 발생하였습니다.");
        }
    }

    /**
     * 엑셀 업로드 파일을 가져온다.
     */
    private Workbook getWorkbook(Params params) throws EgovBizException {

        FileInputStream fis = null;

        try {
            // 업로드 파일을 가져온다.
            MultipartFile file = params.getFile("uploadExcelFile");

            // 업로드 파일이 없는 경우
            if (file == null || file.isEmpty()) {
                throw new EgovBizException(getMessage("업로드 파일이 없습니다."));
            }

            if (file.getSize() > MAX_FILE_SIZE) {
                throw new EgovBizException(getMessage("업로드 파일의 크기는 " + MAX_FILE_SIZE + "바이트를 초과할 수 없습니다."));
            }

            String realFileNm = file.getOriginalFilename();
            params.set("srcFileNm", realFileNm);
//			int ext = realFileNm.lastIndexOf(".");
//			String fileExt = "";
//			if(ext > -1) {
//				fileExt = realFileNm.substring(ext);
//			}

            String directory = EgovWebUtil.folderPathReplaceAll(EgovProperties.getProperty("Globals.ExcelFileUploadTempPath"));
            File directoryPath = new File(directory);
            // 수정 : 권한 설정
            directoryPath.setExecutable(true, true);
            directoryPath.setReadable(true);
            directoryPath.setWritable(true, true);

            if (!directoryPath.exists()) {
                directoryPath.mkdirs();
            }

            long time = System.currentTimeMillis();
            String pattern = "yyyyMMddHHmmssSSS";
            SimpleDateFormat sf = new SimpleDateFormat(pattern);
            String saveFileNm = sf.format(new Date(time)) + "_" + realFileNm;
            params.set("saveFileNm", saveFileNm);

            String saveFilePath = directoryPath + File.separator + EgovWebUtil.filePathReplaceAll(saveFileNm);
            File savedFile = new File(saveFilePath);
            file.transferTo(savedFile);

            fis = new FileInputStream(savedFile);
            return WorkbookFactory.create(fis);
        } catch (IOException ioe) {
            throw new EgovBizException(getMessage("업로드 파일을 읽을 수 없습니다."));
        } catch (InvalidFormatException ife) {
            throw new EgovBizException(getMessage("엑셀 파일을 읽을 수 없습니다."));
        } catch (OutOfMemoryError oome) {
            throw new EgovBizException(getMessage("엑셀 파일을 로드할 수 없습니다."));
        } finally {
            try {
                if (fis != null) {
                    fis.close();
                }
            } catch (IOException ioe) {
                EgovWebUtil.exLogging(ioe);
            }
        }
    }

    /**
     * 엑셀 시트를 가져온다.
     */
    private Sheet getSheet(Workbook workbook) throws EgovBizException {
        // 시트를 가져온다.
        Sheet sheet = workbook.getSheetAt(0);

        // 시트가 없는 경우
        if (sheet == null) {
            throw new EgovBizException(getMessage("엑셀 파일에 시트가 없습니다."));
        }

        return sheet;
    }


}
