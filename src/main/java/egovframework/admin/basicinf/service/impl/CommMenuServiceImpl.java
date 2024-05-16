package egovframework.admin.basicinf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommMenu;
import egovframework.admin.basicinf.service.CommMenuService;
import egovframework.admin.basicinf.service.CommUsr;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @since 2014.04.17
 */
@Service("CommMenuService")
public class CommMenuServiceImpl extends AbstractServiceImpl implements CommMenuService {

    @Resource(name = "CommMenuDAO")
    private CommMenuDAO commMenuDAO;
    /*
    @Resource(name = "commMenuMapper")
    private CommMenuMapper commMenuDAO;*/
    /*
    @Resource(name = "commMenuMapperDAO")
    private CommMenuMapperDAO commMenuDAO;*/

    private static final Logger logger = Logger.getLogger(CommMenuServiceImpl.class);

    public List<CommMenu> selectCommMenuTop(CommUsr commUsr) {
        List<CommMenu> result = new ArrayList<CommMenu>();
        try {
            result = commMenuDAO.selectCommMenuList(commUsr);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 전체 리스트 조회
     */
    public Map<String, Object> selectMenuListIbPaging(CommMenu commMenu) {

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommMenu> result = commMenuDAO.selectMenuList(commMenu);
            //int cnt = commMenuDAO.selectMenuListCnt(commMenu);
            map.put("resultList", result);
            //map.put("resultCnt", Integer.toString(cnt));
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 전체 리스트 중 키워드 조회
     */
    public Map<String, Object> selectMenuListKeywdIbPaging(CommMenu commMenu) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommMenu> result = commMenuDAO.selectMenuListKeywd(commMenu);
            //int cnt = commMenuDAO.selectMenuListKeywdCnt(commMenu);
            map.put("resultList", result);
            //map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    /**
     * 단건 상세 조회
     */
    public CommMenu selectMenuListInfo(CommMenu commMenu) {
        CommMenu result = new CommMenu();
        try {
            result = commMenuDAO.selectMenuListInfo(commMenu);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 메뉴 데이터 저장/수정/삭제
     */
    public int saveCommMenuCUD(@NonNull CommMenu saveVO, String status) {
        int result = 0;

        if (WiseOpenConfig.STATUS_I.equals(status)) {
            try {
                int menuId = commMenuDAO.getMenuId(saveVO);
                saveVO.setMenuId(menuId);

                if ("".equals(StringUtils.defaultString(saveVO.getMenuIdPar()))) {
                    saveVO.setMenuIdTop(String.valueOf((saveVO.getMenuId())));
                }
                result = commMenuDAO.insertMenu(saveVO);
                commMenuDAO.updateMenuFullnm(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else if ((WiseOpenConfig.STATUS_U.equals(status))) {
            try {
                result = commMenuDAO.updateMenu(saveVO);
                commMenuDAO.updateMenuFullnm(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else if ((WiseOpenConfig.STATUS_D.equals(status))) {
            try {
                result = commMenuDAO.deleteMenu(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else {
            result = WiseOpenConfig.STATUS_ERR;
        }

        return result;
    }

    /**
     * 선택한 행의 하위메뉴 조회
     */
    public Map<String, Object> selectCommLowMenuList(CommMenu commMenu) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List result = commMenuDAO.selectCommLowMenuList(commMenu);
            int cnt = commMenuDAO.selectCommLowMenuListCnt(commMenu);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 메뉴정보 트리순서 수정
     */
    public int commMenuListUpdateTreeOrderCUD(ArrayList<CommMenu> list) {
        int result = 0;
        for (CommMenu commMenu : list) {
            try {
                result = commMenuDAO.commMenuListUpdateTreeOrder(commMenu);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }
        return result;
    }
}
