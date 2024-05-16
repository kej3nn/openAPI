package egovframework.admin.openinf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.openinf.service.OpenDt;
import egovframework.admin.openinf.service.OpenDtService;
import egovframework.admin.openinf.service.OpenDtbl;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("OpenDtService")
public class OpenDtServiceImpl extends AbstractServiceImpl implements OpenDtService {

    @Resource(name = "OpenDtDAO")
    private OpenDtDAO openDtDAO;

    private static final Logger logger = Logger.getLogger(OpenDtServiceImpl.class.getClass());

    public Map<String, Object> selectOpenDtIbPaging(OpenDt opendt) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDt> result = openDtDAO.selectOpenDtList(opendt);
            int cnt = openDtDAO.selectOpenDtListCnt(opendt);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public OpenDt selectOpenDtDtl(OpenDt opendt) {
        OpenDt result = new OpenDt();
        try {
            result = openDtDAO.selectOpenDtDtl(opendt);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public Map<String, Object> selectOpenDtblIbPaging(OpenDtbl opendtbl) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDtbl> result = openDtDAO.selectOpenDtblList(opendtbl);
            int cnt = openDtDAO.selectOpenDtblListCnt(opendtbl);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectopenDtSrcPopPopIbPaging(OpenDtbl opendtbl) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenDtbl> result = openDtDAO.selectOpenDtSrcPopList(opendtbl);
            int cnt = openDtDAO.selectOpenDtSrcPopListCnt(opendtbl);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    //보유데이터 전체 저장
    @Override
    public int saveOpenDtCUD(ArrayList<OpenDtbl> list, OpenDtbl saveVO) {
        int result = 0;

        //데이터셋 상세내용 저장
//    	result = saveOpenDtDtlCUD(saveVO, WiseOpenConfig.STATUS_I);


        /**
         * 로직이 변경..보유데이터 저장시 데이터셋내용만 저장하고 테이블내용은 수정하기를 통해 등록한다.
         * 아래 주석처리함.. 파라미터도 수정.
         */
    	/*
    	if(result <= 0){
    		return result;
    	}
    	
    	//보유데이터ID 추출
    	int dtId = saveVO.getDtId();
    	//보유데이터 테이블 항목 저장
    	for(OpenDtbl openDtbl : list){
    		openDtbl.setDtId(dtId);	//상세내용 저장 후 나온 데이터셋ID 저장
    		result += saveOpenDtblCUD(openDtbl);
    	}
    	*/
        return result;

    }

    // 보유데이터 상세내용 단건 저장
    public int saveOpenDtDtlCUD(ArrayList<OpenDtbl> list) {
        int result = 0;
        try {
            for (OpenDtbl data : list) {
                if ("I".equals(data.getStatus())) {
                    int dtId = openDtDAO.getDtId(data);
                    data.setDtId(dtId);
                    result += openDtDAO.insertDt(data);
                } else if ("U".equals(data.getStatus())) {
                    result += openDtDAO.updateDt(data);
                } else if ("D".equals(data.getStatus())) {
                    if (openDtDAO.selectReg(data) > 0) { //데이터셋, 메타정보가 등록되어 있어 삭제불가능
                        result = -1111;
                    } else {
                        result = openDtDAO.deleteDt(data);
                    }
                } else {
                    result = WiseOpenConfig.STATUS_ERR;
                }
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }


        return result;
    }

    // 보유데이터 테이블 항목 저장
    public int saveOpenDtblCUD(OpenDtbl saveVO) {
        int result = 0;
        try {
            if (saveVO.getStatus().equals("I")) {
                result += openDtDAO.insertDtbl(saveVO);
            } else if (saveVO.getStatus().equals("U")) {
                result += openDtDAO.updateDtbl(saveVO);
            } else if (saveVO.getStatus().equals("D")) {
//			result += openDtDAO.deleteDtbl(saveVO);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    //  보유데이터 테이블 항목 수정
    @Override
    public int updateOpenDtblCUD(ArrayList<OpenDtbl> list) {
        int result = 0;

        for (OpenDtbl saveVO : list) {
            result += saveOpenDtblCUD(saveVO);
        }
        return result;

    }

    //OpenInf에서 사용중인지 확인
    public int getUseDtInf(OpenDtbl saveVO) {
        int result = 0;
        try {
            result = openDtDAO.getUseDtInf(saveVO);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    // 보유데이터 삭제
    public int deleteOpenDtblCUD(ArrayList<OpenDtbl> list) {
        int result = 0;
        try {
            for (OpenDtbl saveVO : list) {
                result += openDtDAO.deleteDtbl(saveVO);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }


}
