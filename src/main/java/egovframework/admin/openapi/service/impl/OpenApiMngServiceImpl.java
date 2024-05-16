package egovframework.admin.openapi.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.openapi.service.OpenApiMngService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

@Service(value = "openApiMngService")
public class OpenApiMngServiceImpl extends BaseService implements OpenApiMngService {

    @Resource(name = "openApiMngDao")
    protected OpenApiMngDao openApiMngDao;

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectOpenApiMngListPaging(Params params) {

        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            HttpSession session = getSession();

            params.put("accCd", loginVO.getAccCd());    //로그인 된 유저 권환 획득
            // 유저 입력 권한(부서별 or 개인별)
            params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
            //params.put("inpOrgCd", loginVO.getOrgCd());	// 로그인 된 부서코드
            params.put("inpOrgCd", session.getAttribute(SessionAttribute.ORG_CODE));
            params.put("inpUsrCd", loginVO.getUsrCd());    //로그인 된 유저 코드
        }


        Paging list = openApiMngDao.selectOpenApiMngList(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 기관정보 리스트 조회
     */
    @Override
    public List<Record> selectOrgList(Params params) {
        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            HttpSession session = getSession();

            params.put("accCd", loginVO.getAccCd());    //로그인 된 유저 권환 획득
            // 유저 입력 권한(부서별 or 개인별)
            params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
            //params.put("inpOrgCd", loginVO.getOrgCd());	// 로그인 된 부서코드
            params.put("inpOrgCd", session.getAttribute(SessionAttribute.ORG_CODE));
            params.put("inpUsrCd", loginVO.getUsrCd());    //로그인 된 유저 코드
        }
        List<Record> result = new ArrayList<Record>();

        try {
            result = openApiMngDao.selectOrgList(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    @Override
    public Object saveOpenApiMng(HttpServletRequest request, Params params) {
        /* 데이터 저장 */
        try {
            openApiMngDao.saveOpenApiMng(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return success(getMessage("admin.message.000006"));
    }

    @Override
    public Record openApiMngDtl(Params params) {
        Record result = null;
        try {
            result = (Record) openApiMngDao.selectOpenApiMngDtl(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    @Override
    public Object deleteOpenApiMng(Params params) {
        try {
            openApiMngDao.deleteOpenApiMng(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return success(getMessage("admin.message.000005"));
    }
}
