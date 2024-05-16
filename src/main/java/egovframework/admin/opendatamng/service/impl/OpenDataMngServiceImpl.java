package egovframework.admin.opendatamng.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.opendatamng.service.OpenDataMngService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 관리자 공공데이터관리  클래스
 *
 * @version 1.0
 * @since 2019/04/23
 */
@Service(value = "openDataMngService")
public class OpenDataMngServiceImpl extends BaseService implements OpenDataMngService {
    @Resource(name = "openDataMngDao")
    protected OpenDataMngDao openDataMngDao;

    /**
     * API 연계설정 리스트 조회
     */
    @Override
    public List<Map<String, Object>> openApiLinkageMngListPaging(Params params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        try {
            result = openDataMngDao.openApiLinkageMngList(params);
        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * API 연계설정 상세 조회
     */
    @Override
    public Map<String, Object> openApiLinkageMngDtl(Map<String, String> paramMap) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            result = openDataMngDao.selectOpenApiLinkageMngDtl(paramMap);

        } catch (DataAccessException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * API 연계설정  저장 데이터셋 데이터 리스트 조회
     */
    @Override
    public List<Map<String, Object>> selectOpenApiLinkDsPopup(Params params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        try {
            result = openDataMngDao.selectOpenApiLinkDsPopList(params);
        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;

    }

    /**
     * API 연계설정  대상객체(통계데이터) 데이터 리스트 조회
     */
    @Override
    public List<Map<String, Object>> selectOpenApiLinkObjSPopup(Params params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        try {
            result = openDataMngDao.selectOpenApiLinkObjSPopList(params);
        } catch (DataAccessException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * API 연계설정 CUD 처리
     */
    @Override
    public Result saveOpenApiLinkageMng(Params params) {
        boolean result = false;
        Map<String, String> paramMap = new HashMap<String, String>();
        Map<String, Object> dtlMap = new HashMap<String, Object>();

        try {
            if (ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS))) {
                openDataMngDao.insertOpenApiLinkageMng(params);
                result = true;
            } else if (ModelAttribute.ACTION_UPD.equals(params.getString(ModelAttribute.ACTION_STATUS))) {
                int cnt = (Integer) openDataMngDao.updateOpenApiLinkageMng(params);
                if (cnt > 0) {
                    result = true;
                }
            } else if (ModelAttribute.ACTION_DEL.equals(params.getString(ModelAttribute.ACTION_STATUS))) {
                openDataMngDao.deleteOpenApiLinkageMng(params);
                result = true;
            }
        } catch (DataAccessException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            return failure("시스템 오류가 발생하였습니다.");
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            return failure("시스템 오류가 발생하였습니다.");
        }

        if (result) {
            return success(getMessage("admin.message.000007"));    //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003"));    //저장에 실패하였습니다.
        }
    }

    //공통코드 값을 조회한다.
    @Override
    public List<Record> selectOption(Params params) {
        List<Record> result = new ArrayList<Record>();

        try {
            result = (List<Record>) openDataMngDao.selectOption(params);
        } catch (DataAccessException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * API 연계설정 리스트 조회
     */
    @Override
    public List<Map<String, Object>> openApiLinkageMonListPaging(Params params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        try {
            result = openDataMngDao.openApiLinkageMonList(params);
        } catch (DataAccessException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }
}
