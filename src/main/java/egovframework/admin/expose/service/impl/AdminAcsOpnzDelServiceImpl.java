package egovframework.admin.expose.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.expose.service.AdminAcsOpnzDelService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

@Service(value = "adminAcsOpnzDelService")
public class AdminAcsOpnzDelServiceImpl extends BaseService implements AdminAcsOpnzDelService {
    @Resource(name = "adminAcsOpnzDelDao")
    protected AdminAcsOpnzDelDao adminAcsOpnzDelDao;

    /**
     * 청구인정보 기록삭제 리스트 조회
     */
    @Override
    public Paging acsOpnzDelListPaging(Params params) {
        Paging list = new Paging();
        try {
            list = adminAcsOpnzDelDao.selectAcsOpnzDelList(params, params.getPage(), params.getRows());
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return list;
    }

    /**
     * 청구인정보 기록삭제 데이터 수정
     */
    @Override
    public Result saveAcsOpnzDel(Params params) {
        List<Record> delList = new ArrayList<Record>();
        Record r = null;
        Params[] data = params.getJsonArray(Params.SHEET_DATA);

        try {

            if (data.length > 0) {
                for (int i = 0; i < data.length; i++) {
                    Params obj = data[i];
                    r = new Record();
                    String rowStatus = obj.getString(ModelAttribute.ACTION_STATUS);        //시트 상태
                    r.put("regId", params.getString("regId"));
                    r.put("updId", params.getString("updId"));
                    r.put("userIp", params.getString("userIp"));

                    if (rowStatus.equals(ModelAttribute.ACTION_DEL)) {
                        for (Object key : obj.keySet()) {
                            r.put(key, obj.get(String.valueOf(key)));
                        }

                        delList.add(r);
                    }
                }
            }

            if (!delList.isEmpty()) {
                //삭제 처리
                adminAcsOpnzDelDao.deleteAcsOpnzAplDel(delList);

                adminAcsOpnzDelDao.deleteAcsOpnzRcpDel(delList);
            }

        } catch (ServiceException sve) {
            error("Exception : ", sve);
            EgovWebUtil.exLogging(sve);
            throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        return success(getMessage("admin.message.000006"));    //저장이 완료되었습니다.
    }

}
