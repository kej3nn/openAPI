/*
 * @(#)OpenDttypeServiceImpl.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.admin.dtfile.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.dtfile.service.OpenDttypeService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 데이터 유형을 관리하는 서비스 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
@Service("openDttypeService")
public class OpenDttypeServiceImpl extends BaseService implements OpenDttypeService {
    /**
     * 데이터 유형을 관리하는 DAO
     */
    @Resource(name = "openDttypeDao")
    protected OpenDttypeDao openDttypeDao;

    /**
     * 데이터 유형을 검색한다.
     *
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDttype(Params params) {
        // 데이터 유형을 검색한다.
        return openDttypeDao.searchOpenDttype(params);
    }

    /**
     * 데이터 유형 옵션을 검색한다.
     *
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDttypeOpt(Params params) {
        // 데이터 컬럼 정의를 검색한다.
        return openDttypeDao.searchOpenDttypeOpt(params);
    }

    /**
     * 데이터 유형을 저장한다.
     *
     * @param params 파라메터
     * @return 저장결과
     */
    public Result saveOpenDttype(Params params) {
        CommUsr loginVO = null;

        //사용자 인증 및 사용자 권한정보 및 사용자코드 Set
        if (EgovUserDetailsHelper.isAuthenticated()) {
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
        }

        Params[] data = params.getJsonArray(Params.SHEET_DATA);

        String usrId = "";
        if (loginVO != null) usrId = StringUtils.defaultString(loginVO.getUsrId());

        for (int i = 0; i < data.length; i++) {
            data[i].put("regId", usrId);
            data[i].put("updId", usrId);

            if (Params.STATUS_INSERT.equals(data[i].getString("status"))) {
                // 데이터 유형을 등록한다.
                openDttypeDao.insertOpenDttype(data[i]);
                continue;
            }
            if (Params.STATUS_UPDATE.equals(data[i].getString("status"))) {
                // 데이터 유형을 수정한다.
                openDttypeDao.updateOpenDttype(data[i]);
                continue;
            }
            if (Params.STATUS_DELETE.equals(data[i].getString("status"))) {
                // 데이터 유형을 삭제한다.
                openDttypeDao.deleteOpenDttype(data[i]);
                continue;
            }
        }

        // 저장결과를 반환한다.
        return success(getMessage("저장이 완료되었습니다."));
    }
}