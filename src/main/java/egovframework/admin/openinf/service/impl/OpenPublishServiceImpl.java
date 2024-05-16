package egovframework.admin.openinf.service.impl;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.openinf.service.OpenInf;
import egovframework.admin.openinf.service.OpenPublish;
import egovframework.admin.openinf.service.OpenPublishService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 분류정보 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

@Service("OpenPublishService")
public class OpenPublishServiceImpl extends AbstractServiceImpl implements
        OpenPublishService {

    @Resource(name = "OpenPublishDAO")
    protected OpenPublishDAO openPublishDAO;

    @Resource(name = "OpenInfDAO")
    private OpenInfDAO openInfDAO;

    private static final Logger logger = Logger
            .getLogger(OpenPublishServiceImpl.class);

    public Map<String, Object> openPublishListAllIbPaging(
            OpenPublish openPublish) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenPublish> result = openPublishDAO.selectOpenPublishListAll(openPublish);
            int cnt = openPublishDAO.selectOpenPublishListAllCnt(openPublish);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 공표자료를 단건 조회한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public OpenPublish selectOpenPublishOne(OpenPublish openPublish) {
        OpenPublish result = new OpenPublish();
        try {
            result = openPublishDAO.selectOpenPublishOne(openPublish);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 공표자료를 변경한다.
     *
     * @param OpenPublish
     * @return
     * @throws Exception
     */
    public int saveOpenPublishCUD(OpenPublish openPublish, String status) {
        int result = 0;
        try {
            if (WiseOpenConfig.STATUS_U2.equals(status)) {
                result = openPublishDAO.openPublishPubOk(openPublish);
            }
            if (WiseOpenConfig.STATUS_U.equals(status)) {
                result = openPublishDAO.updateOpenPublish(openPublish);
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public Map<String, Object> openPublishFileList(OpenPublish openPublish) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenPublish> result = openPublishDAO.openPublishFileList(openPublish);
            int cnt = openPublishDAO.openPublishFileListCnt(openPublish);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /* */

    /**
     * 이전 파일 첨부
     */
    /*
     * @Override public int saveOpenPublishFileCUD(OpenPublish openPublish,
     * ArrayList<?> list) { int result = 0;
     *
     * for(int i=0; i < list.size() ; i++){ result =
     * openPublishDAO.saveOpenPublishFileCUD((OpenPublish)list.get(i)); } return
     * result; }
     */

    // 첨부파일 저장, 수정
    @Override
    public int saveOpenPublishFileCUD(OpenPublish openPublish, ArrayList<?> list) {
        int result = 0;
        try {
            for (int i = 0; i < list.size(); i++) {
                if (((OpenPublish) list.get(i)).getStatus().equals("I")) {
                    int fileSeq = openPublishDAO.getPublishFileSeq((OpenPublish) list.get(i));
                    ((OpenPublish) list.get(i)).setFileSeq(fileSeq);
                    result += openPublishDAO.insertPublishFile((OpenPublish) list.get(i));
                } else if (((OpenPublish) list.get(i)).getStatus().equals("U")) {
                    result += openPublishDAO.updatePublishFile((OpenPublish) list.get(i));
                } else if (((OpenPublish) list.get(i)).getStatus().equals("D")) {
                    result += openPublishDAO.deletePublishFile((OpenPublish) list.get(i));
                } else {
                    result = WiseOpenConfig.STATUS_ERR;
                }
                // FILE_CNT 저장
                if (result > 0) {
                    int fileCnt = openPublishDAO
                            .getPublishFileCnt((OpenPublish) list.get(i));
                    ((OpenPublish) list.get(i)).setFileCnt(fileCnt);
                    result = openPublishDAO.updatePublishFileCnt((OpenPublish) list
                            .get(i));
                }
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 공표자료 목록을 전체 조회한다.(포털에서 사용)
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @Override
    public Map<String, Object> selectOpenPublishList(OpenPublish openPublish) {
        Map<String, Object> map = new HashMap<String, Object>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String today;
        Date now = new Date();
        today = sdf.format(now);
        try {
            if (openPublish.getSerVal() != null) {
                String serVal = URLDecoder.decode(openPublish.getSerVal(), "UTF-8")
                        .replaceAll("\\|", "%20").replaceAll("\\+", "%20");
                openPublish.setSerVal(serVal);
            }
            List<OpenPublish> result = openPublishDAO
                    .selectOpenPublishList(openPublish);
            List<String> years = openPublishDAO
                    .selectOpenPublishYearsList(openPublish);
            int resultCnt = result.size();

            if (resultCnt > 0) {
                map.put("pubYy", result.get(0).getPubYy());
            } else {
                map.put("pubYy", years.get(0));
            }
            map.put("today", today);
            map.put("years", years);
            map.put("result", result);
            map.put("resultCnt", resultCnt);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 공표자료를 상세 조회한다.(포털에서 사용)
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @Override
    public Map<String, Object> selectOpenPublishDetail(OpenPublish openPublish) {
        Map<String, Object> map = new HashMap<String, Object>();
        OpenPublish prePub = new OpenPublish();
        OpenPublish aftPub = new OpenPublish();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String today;
        Date now = new Date();
        today = sdf.format(now);
        openPublish.setPubDttm(today);
        try {
            openPublishDAO.updateViewCnt(openPublish); // 조회수 증가
            List<OpenPublish> list = openPublishDAO.selectOpenPublishList(openPublish);
            for (int i = 0; i < list.size(); i++) {
                if (list.get(i).getSeq().equals(openPublish.getSeq())) {
                    if (i != 0) {
                        aftPub = list.get(i - 1);
                    } else {
                        aftPub = null;
                    }
                    if (i + 1 != list.size()) {
                        prePub = list.get(i + 1);
                    } else {
                        prePub = null;
                    }
                }
            }
            OpenPublish result = openPublishDAO.selectOpenPublishDetail(openPublish);
            List<OpenPublish> refDsList = openPublishDAO.selectRefDsList(result);
            List<String> fileList = openPublishDAO
                    .selectOpenPublishFileList(openPublish);
            map.put("result", result);
            map.put("refDsList", refDsList);
            map.put("refDsListCnt", refDsList.size());
            map.put("prePub", prePub);
            map.put("aftPub", aftPub);
            if (fileList.size() > 0)
                map.put("fileList", fileList);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    // 첨부파일 저장, 수정
    @Override
    public int saveOpenPublishFileListCUD(OpenPublish openPublish, ArrayList<?> list) {
        int result = 0;

        try {
            for (int i = 0; i < list.size(); i++) {
                if (((OpenPublish) list.get(i)).getStatus().equals("I")) {
                    int fileSeq = openPublishDAO.getFileSeq((OpenPublish) list.get(i));
                    ((OpenPublish) list.get(i)).setFileSeq(fileSeq);
                    result += openPublishDAO
                            .insertOpenpublishFile((OpenPublish) list.get(i));
                } else if (((OpenPublish) list.get(i)).getStatus().equals("U")) {
                    result += openPublishDAO
                            .updateOpenpublishFile((OpenPublish) list.get(i));
                } else if (((OpenPublish) list.get(i)).getStatus().equals("D")) {
                    result = openPublishDAO
                            .deleteUpdateOpenPublishFile((OpenPublish) list.get(i));
                } else {
                    result = WiseOpenConfig.STATUS_ERR;
                }
                // FILE_CNT 저장
                if (result > 0) {
                    int fileCnt = openPublishDAO.getFileCnt((OpenPublish) list.get(i));
                    ((OpenPublish) list.get(i)).setFileCnt(fileCnt);
                    result = openPublishDAO.updateFileCnt((OpenPublish) list.get(i));
                }
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

}