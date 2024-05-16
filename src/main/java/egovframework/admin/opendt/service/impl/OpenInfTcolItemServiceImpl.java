package egovframework.admin.opendt.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.opendt.service.OpenInfTcolItem;
import egovframework.admin.opendt.service.OpenInfTcolItemService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.util.UtilString;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 통계항목 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

@Service("OpenInfTcolItemService")
public class OpenInfTcolItemServiceImpl extends AbstractServiceImpl implements OpenInfTcolItemService {

    @Resource(name = "OpenInfTcolItemDAO")
    protected OpenInfTcolItemDAO openInfTcolItemDAO;

    private static final Logger logger = Logger.getLogger(OpenInfTcolItemServiceImpl.class);

    public Map<String, Object> selectInfTcolItemParAllIbPaging(OpenInfTcolItem openInfTcolItem) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfTcolItem> result = openInfTcolItemDAO.selectTcolItemParListAll(openInfTcolItem);
            int cnt = openInfTcolItemDAO.selectTcolItemParListAllCnt(openInfTcolItem);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public int infTcolItemParSaveCUD(ArrayList<OpenInfTcolItem> list) {
        int result = 0;
        try {
            for (OpenInfTcolItem openInfTcolItem : list) {
                if (openInfTcolItem.getStatus().equals("I")) {
                    if (openInfTcolItemDAO.selectCheckDup(openInfTcolItem) > 0) {
                        return -1;
                    }
                    //신규면 ORDER MAX구하기
                    openInfTcolItem.setvOrder(openInfTcolItemDAO.selectOpenInfTcolParOrderBy(openInfTcolItem) + "");
                }
                openInfTcolItem.setItemLvl("1");
                result = openInfTcolItemDAO.mergeInto(openInfTcolItem);
                //이름 업데이트
                if (!openInfTcolItem.getStatus().equals("D")) {
                    openInfTcolItemDAO.updateParItemNm(openInfTcolItem);
                }
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public int infTcolItemParDeleteCUD(OpenInfTcolItem openInfTcolItem) {
        int result = 0;
        try {
            result = openInfTcolItemDAO.delete(openInfTcolItem);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public Map<String, Object> openInfTcolItemListTree(OpenInfTcolItem openInfTcolItem) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfTcolItem> result = openInfTcolItemDAO.selectTcolItemListTree(openInfTcolItem);
            map.put("resultList", result);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public int infTcolItemOrderBySaveCUD(ArrayList<OpenInfTcolItem> list) {
        int result = 0;
        try {
            for (OpenInfTcolItem openInfTcolItem : list) {
                if (!openInfTcolItem.getItemLevel().equals("0")) { //0레벨은 순서를 바꾸지 않는다.
                    result = openInfTcolItemDAO.updateOrderby(openInfTcolItem);
                }
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public int saveOpenInfTcolItemCUD(OpenInfTcolItem openInfTcolItem, String status) {
        int result = 0;
        String space = "    ";
        try {
            if ((WiseOpenConfig.STATUS_D.equals(status))) {
                result = openInfTcolItemDAO.delete(openInfTcolItem);
            } else {//update, insert
                if (WiseOpenConfig.STATUS_I.equals(status)) {
                    if (openInfTcolItemDAO.selectCheckDup(openInfTcolItem) > 0) { //중복체크
                        return -1;
                    }
                }
                if (WiseOpenConfig.STATUS_I.equals(status)) { //순서를 가져온다.
                    logger.debug("aaa:  " + openInfTcolItemDAO.selectOpenInfTcolOrderBy(openInfTcolItem) + "");
                    openInfTcolItem.setvOrder(openInfTcolItemDAO.selectOpenInfTcolOrderBy(openInfTcolItem) + "");
                }
                OpenInfTcolItem prnItemNm = openInfTcolItemDAO.selectOpenInfTcolItemPrnItemNm(openInfTcolItem);
                openInfTcolItem.setItemLvl(prnItemNm.getItemLvl());
                result = openInfTcolItemDAO.mergeInto(openInfTcolItem);
                if (WiseOpenConfig.STATUS_U.equals(status)) { //변경시 하위 까지 사용, 미사용처리
                    openInfTcolItemDAO.updateUseYn(openInfTcolItem);

                }
                String itemNm = "";
                String itemNmEng = "";
                for (int i = 1; i < Integer.parseInt(openInfTcolItem.getItemLvl()); i++) {//공백만들기
                    itemNm += space;
                    itemNmEng += space;
                }
                openInfTcolItem.setPrnItemNm(itemNm + openInfTcolItem.getItemNm());
                openInfTcolItem.setPrnItemNmEng(itemNmEng + openInfTcolItem.getItemNmEng());
                openInfTcolItemDAO.updateParItemNm(openInfTcolItem);
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public OpenInfTcolItem selectOpenInfTcolItem(OpenInfTcolItem openInfTcolItem) {
        OpenInfTcolItem result = new OpenInfTcolItem();

        try {
            result = openInfTcolItemDAO.selectOpenInfTcolItemList(openInfTcolItem);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public int openInfTcolItemDup(OpenInfTcolItem openInfTcolItem) {
        int result = 0;
        try {
            if (openInfTcolItemDAO.selectCheckDup(openInfTcolItem) > 0) {
                return -1;
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }
}