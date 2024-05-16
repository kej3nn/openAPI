package egovframework.admin.bbs.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.bbs.service.BbsAdmin;
import egovframework.admin.bbs.service.BbsList;
import egovframework.admin.bbs.service.BbsListService;
import egovframework.admin.openinf.service.impl.OpenDtServiceImpl;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.view.FileDownloadView;
import egovframework.common.file.service.FileVo;
import egovframework.ggportal.bbs.service.impl.PortalBbsFileServiceImpl;
import egovframework.ggportal.bbs.service.impl.PortalBbsInfDao;
import egovframework.ggportal.bbs.service.impl.PortalBbsLinkDao;
import egovframework.ggportal.bbs.service.impl.PortalBbsListDao;

@Service("BbsListService")
public class BbsListServiceImpl extends PortalBbsFileServiceImpl implements BbsListService {

    @Resource(name = "BbsListDAO")
    private BbsListDAO bbsListDAO;

    /**
     * 게시판 내용을 관리하는 DAO
     */
    @Resource(name = "ggportalBbsListDao")
    private PortalBbsListDao portalBbsListDao;

    /**
     * 게시판 링크를 관리하는 DAO
     */
    @Resource(name = "ggportalBbsLinkDao")
    private PortalBbsLinkDao portalBbsLinkDao;

    /**
     * 게시판 공공데이터를 관리하는 DAO
     */
    @Resource(name = "ggportalBbsInfDao")
    private PortalBbsInfDao portalBbsInfDao;

    private static final Logger logger = Logger.getLogger(OpenDtServiceImpl.class.getClass());

    public Map<String, Object> selectBbsListIbPaging(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<BbsList> result = bbsListDAO.selectBbsList(bbsList);
            int cnt = bbsListDAO.selectBbsListCnt(bbsList);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    @Override
    public Map<String, Object> selectBbsAdminInfo(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<BbsList> result = bbsListDAO.selectBbsAdminInfo(bbsList);
            map.put("result", result);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public String selectBbsTypeCd(BbsList bbsList) {
        String result = "";
        try {
            result = bbsListDAO.selectBbsTypeCd(bbsList);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public BbsAdmin selectBbsDitcCd(BbsList bbsList) {
        BbsAdmin result = new BbsAdmin();
        try {
            result = bbsListDAO.selectBbsDitcCd(bbsList);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;

    }

    public String selectDelYn(BbsList bbsList) {
        String result = "";

        try {
            result = bbsListDAO.selectDelYn(bbsList);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public BbsList selectBbsDtlList(BbsList bbsList) {
        BbsList result = new BbsList();
        try {
            result = bbsListDAO.selectBbsDtlList(bbsList);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public Map<String, Object> selectBbsLinkListIbPaging(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<BbsList> result = bbsListDAO.selectBbsLinkList(bbsList);
            int cnt = bbsListDAO.selectBbsLinkListCnt(bbsList);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectBbsInfListIbPaging(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            List<BbsList> result = bbsListDAO.selectBbsInfList(bbsList);
            int cnt = bbsListDAO.selectBbsInfListCnt(bbsList);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectBbsFileListIbPaging(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            List<BbsList> result = bbsListDAO.selectBbsFileList(bbsList);
            int cnt = bbsListDAO.selectBbsFileListCnt(bbsList);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectBbsinfPopIbPaging(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<BbsList> result = bbsListDAO.selectBbsInfPopList(bbsList);
            int cnt = bbsListDAO.selectBbsInfPopListCnt(bbsList);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    @Override
    public Map<String, Object> bbsImgDetailView(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<BbsList> resultImg = bbsListDAO.bbsImgDetailView(bbsList);
            List<BbsList> resultTopYn = bbsListDAO.getTopImg(bbsList);
            map.put("resultImg", resultImg);
            map.put("resultTopYn", resultTopYn);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    // 단건저장, 수정, 삭제
    public int saveBbsDtlListCUD(BbsList saveVO, String status) {
        int result = 0;


        if (WiseOpenConfig.STATUS_I.equals(status)) {
            try {
                int seq = bbsListDAO.getSeq(saveVO);
                saveVO.setSeq(seq);
                saveVO.setpSeq(0);
//			saveVO.setBbsTit(saveVO.getBbsTit().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
                result = bbsListDAO.insertBbsList(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else if ((WiseOpenConfig.STATUS_U.equals(status))) {
//			saveVO.setBbsTit(saveVO.getBbsTit().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
            try {
                result = bbsListDAO.updateBbsList(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else if ((WiseOpenConfig.STATUS_D.equals(status))) {
            try {
                result += bbsListDAO.deleteBbsList(saveVO);
                if (result > 0) {
                    result += bbsListDAO.deleteCPBbsLink(saveVO);
                }
                if (result > 0) {
                    result += bbsListDAO.deleteCPBbsInf(saveVO);
                }
                if (result > 0) {
                    result += bbsListDAO.deleteCPBbsFile(saveVO);
                }
                if (result <= 0) {
                    return result;
                }
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else {
            result = WiseOpenConfig.STATUS_ERR;
        }
        return result;
    }

    //대표이미지 저장
    public int updateTopYn(BbsList saveVO, String status) {
        int result = 0;
        int topResult = 0;
        if (WiseOpenConfig.STATUS_I.equals(status)) {
            try {
                result = bbsListDAO.updateTopYn(saveVO);
                topResult = bbsListDAO.getTopYnCnt(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
            if (topResult > 0) {
                try {
                    result = bbsListDAO.updateTopYn2(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            }
        }
        return result;
    }

    public int deleteImg(BbsList saveVO, String status) {
        int result = 0;
        if (WiseOpenConfig.STATUS_D.equals(status)) {
            try {
                result = bbsListDAO.deleteImg(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }

            //FILE_CNT 저장
            if (result > 0) {
                try {
                    int infCnt = bbsListDAO.getFileCnt(saveVO);
                    saveVO.setFileCnt(infCnt);
                    result = bbsListDAO.updateFileCnt(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            }
        }
        return result;
    }

    public int updateAnsStateCUD(BbsList saveVO) {
        int result = 0;
        try {
            result = bbsListDAO.updateAnsState(saveVO);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    //URL 연결 저장, 수정
    public int saveBbsLinkListCUD(ArrayList<BbsList> list) {
        int result = 0;
        for (BbsList saveVO : list) {
            if (saveVO.getStatus().equals("I")) {
                try {
                    int linkSeq = bbsListDAO.getLinkSeq(saveVO);
                    saveVO.setLinkSeq(linkSeq);
                    result += bbsListDAO.insertBbsLink(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else if (saveVO.getStatus().equals("U")) {
                try {
                    result += bbsListDAO.updateBbsLink(saveVO);

                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else if (saveVO.getStatus().equals("D")) {
                try {
                    result += bbsListDAO.deleteUpdateBbsLink(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }
            //LINK_CNT 저장
            if (result > 0) {
                try {
                    int linkCnt = bbsListDAO.getLinkCnt(saveVO);
                    saveVO.setLinkCnt(linkCnt);
                    result = bbsListDAO.updateLinkCnt(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            }

        }

        return result;
    }

    // URL 연결 완전 삭제
    public int deleteBbsLinkListCUD(ArrayList<BbsList> list) {
        int result = 0;
        for (BbsList saveVO : list) {
            if (saveVO.getStatus().equals("D")) {
                try {
                    result += bbsListDAO.deleteBbsLink(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }
            //LINK_CNT 저장
            if (result > 0) {
                try {
                    int linkCnt = bbsListDAO.getLinkCnt(saveVO);
                    saveVO.setLinkCnt(linkCnt);
                    result = bbsListDAO.updateLinkCnt(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            }
        }

        return result;
    }

    // 공공데이터 연결 저장, 수정
    public int saveBbsInfListCUD(ArrayList<BbsList> list) {
        int result = 0;

        for (BbsList saveVO : list) {
            if (saveVO.getStatus().equals("I")) {
                try {
                    result += bbsListDAO.insertBbsInf(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else if (saveVO.getStatus().equals("U")) {
                try {
                    result += bbsListDAO.updateBbsInf(saveVO);

                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else if (saveVO.getStatus().equals("D")) {
                try {
                    result += bbsListDAO.updateDeleteBbsInf(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }
            //INF_CNT 저장
            if (result > 0) {
                try {
                    int infCnt = bbsListDAO.getInfCnt(saveVO);
                    saveVO.setInfCnt(infCnt);
                    result = bbsListDAO.updateInfCnt(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            }
        }
        return result;
    }

    //공공데이터 연결 완전 삭제
    public int deleteBbsInfListCUD(ArrayList<BbsList> list) {
        int result = 0;
        for (BbsList saveVO : list) {
            if (saveVO.getStatus().equals("D")) {
                try {
                    result += bbsListDAO.deleteBbsInf(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }
            //INF_CNT 저장
            if (result > 0) {
                try {
                    int infCnt = bbsListDAO.getInfCnt(saveVO);
                    saveVO.setInfCnt(infCnt);
                    result = bbsListDAO.updateInfCnt(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            }
        }

        return result;
    }


    //첨부파일 저장, 수정
    @Override
    public int saveBbsFileListCUD(BbsList bbsList, ArrayList<?> list, FileVo fileVo) {

        int idxFileVo = 0;
        int result = 0;
        try {
            for (int i = 0; i < list.size(); i++) {
                if (((BbsList) list.get(i)).getStatus().equals("I")) {
                    int fileSeq = bbsListDAO.getFileSeq((BbsList) list.get(i));
                    ((BbsList) list.get(i)).setFileSeq(fileSeq);
                    ((BbsList) list.get(i)).setSaveFileNm(fileVo.getSaveFileNm()[idxFileVo++]);    // saveFileNm이 srcFileNm와 똑같이 들어가서 수정..
                    ((BbsList) list.get(i)).setFileCont(bbsList.getFileCont());
                    result += bbsListDAO.insertBbsFile((BbsList) list.get(i));
                } else if (((BbsList) list.get(i)).getStatus().equals("U")) {
                    // 수정일 경우 첨부파일 내용과 삭제여부, 파일명을 수정한다.(단건처리로 됨...)
                    ((BbsList) list.get(i)).setViewFileNm(bbsList.getViewFileNm());
                    ((BbsList) list.get(i)).setDelYn(bbsList.getDelYn());
                    ((BbsList) list.get(i)).setFileCont(bbsList.getFileCont());
                    result += bbsListDAO.updateBbsFile((BbsList) list.get(i));
                } else if (((BbsList) list.get(i)).getStatus().equals("D")) {
                    result = bbsListDAO.deleteUpdateBbsFile((BbsList) list.get(i));
                } else {
                    result = WiseOpenConfig.STATUS_ERR;
                }
                //FILE_CNT 저장
                if (result > 0) {
                    int fileCnt = bbsListDAO.getFileCnt((BbsList) list.get(i));
                    ((BbsList) list.get(i)).setFileCnt(fileCnt);
                    result = bbsListDAO.updateFileCnt((BbsList) list.get(i));
                }
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    // 첨부파일 완전 삭제
    public int deleteBbsFileListCUD(ArrayList<BbsList> list) {

        int result = 0;
        for (BbsList saveVO : list) {
            if (saveVO.getStatus().equals("D")) {
                try {
                    result += bbsListDAO.deleteBbsFile(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }
            //FILE_CNT 저장
            if (result > 0) {
                try {
                    int infCnt = bbsListDAO.getFileCnt(saveVO);
                    saveVO.setFileCnt(infCnt);
                    result = bbsListDAO.updateFileCnt(saveVO);
                } catch (Exception e) {
                    EgovWebUtil.exTransactionLogging(e);
                }
            }
        }

        return result;
    }

    public int updateDeleteImgCUD(BbsList saveVO) {
        int result = 0;
        int topResult = 0;

        try {
            result = bbsListDAO.updateTopYn(saveVO);
            topResult = bbsListDAO.getTopYnCnt(saveVO);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        if (topResult > 0) {
            try {
                result = bbsListDAO.updateTopYn2(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }

        if (saveVO.getDelYn0() != 0 && saveVO.getDelYn0() != null) {
            saveVO.setFileSeq(saveVO.getDelYn0());
            try {
                result += bbsListDAO.updateDeleteImg(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }
        if (saveVO.getDelYn1() != 0 && saveVO.getDelYn1() != null) {
            saveVO.setFileSeq(saveVO.getDelYn1());
            try {
                result += bbsListDAO.updateDeleteImg(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }
        if (saveVO.getDelYn2() != 0 && saveVO.getDelYn2() != null) {
            saveVO.setFileSeq(saveVO.getDelYn2());
            try {
                result += bbsListDAO.updateDeleteImg(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }
        if (saveVO.getDelYn3() != 0 && saveVO.getDelYn3() != null) {
            saveVO.setFileSeq(saveVO.getDelYn3());
            try {
                result += bbsListDAO.updateDeleteImg(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }

        //INF_CNT 저장
        if (result > 0) {
            try {
                int infCnt = bbsListDAO.getInfCnt(saveVO);
                saveVO.setInfCnt(infCnt);
                result += bbsListDAO.updateInfCnt(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }
        return result;
    }


    public int deleteImgDtlCUD(BbsList saveVO) {            // 수정 필요함..
        int result = 0;

        try {
            if (saveVO.getDelYn0() != 0 && saveVO.getDelYn0() != null) {
                saveVO.setFileSeq(saveVO.getDelYn0());
                result += bbsListDAO.deleteImgDtl(saveVO);
            }
            if (saveVO.getDelYn1() != 0 && saveVO.getDelYn1() != null) {
                saveVO.setFileSeq(saveVO.getDelYn1());
                result += bbsListDAO.deleteImgDtl(saveVO);
            }
            if (saveVO.getDelYn2() != 0 && saveVO.getDelYn2() != null) {
                saveVO.setFileSeq(saveVO.getDelYn2());
                result += bbsListDAO.deleteImgDtl(saveVO);
            }
            if (saveVO.getDelYn3() != 0 && saveVO.getDelYn3() != null) {
                saveVO.setFileSeq(saveVO.getDelYn3());
                result += bbsListDAO.deleteImgDtl(saveVO);
            }
            if (saveVO.getDelYn4() != 0 && saveVO.getDelYn4() != null) {
                saveVO.setFileSeq(saveVO.getDelYn4());
                result += bbsListDAO.deleteImgDtl(saveVO);
            }
            if (saveVO.getDelYn5() != 0 && saveVO.getDelYn5() != null) {
                saveVO.setFileSeq(saveVO.getDelYn5());
                result += bbsListDAO.deleteImgDtl(saveVO);
            }
            if (saveVO.getDelYn6() != 0 && saveVO.getDelYn6() != null) {
                saveVO.setFileSeq(saveVO.getDelYn6());
                result += bbsListDAO.deleteImgDtl(saveVO);
            }
            if (saveVO.getDelYn7() != 0 && saveVO.getDelYn7() != null) {
                saveVO.setFileSeq(saveVO.getDelYn7());
                result += bbsListDAO.deleteImgDtl(saveVO);
            }

            //INF_CNT 저장
            if (result > 0) {
                int infCnt = bbsListDAO.getInfCnt(saveVO);
                saveVO.setInfCnt(infCnt);
                result += bbsListDAO.updateInfCnt(saveVO);
            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    // 게시판에 첨부될 파일의 Directory경로 중간에 bbsCd를 넣어주기 위해 bbsCd를 가지고 오는 logic
    public String getBbsCd(int seq) {
        String result = "";
        try {
            result = bbsListDAO.getBbsCd(seq);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }


    /**
     * 통계표 연결 리스트 조회
     */
    public Map<String, Object> selectBbsTblIbPaging(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            List<BbsList> result = bbsListDAO.selectBbsTblList(bbsList);
            int cnt = 0;
            if (!result.isEmpty()) {
                cnt = result.get(0).getRowCnt();
            }
            map.put("resultList", result);
            map.put("resultCnt", cnt);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 통계표 연결 추가 팝업 리스트조회
     *
     * @param bbsList
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectSttsTblPopIbPaging(BbsList bbsList) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<BbsList> result = bbsListDAO.selectSttsTblPopList(bbsList);
            //int cnt = bbsListDAO.selectBbsInfPopListCnt(bbsList);
            int cnt = 0;
            if (result != null) {
                cnt = result.get(0).getRowCnt();
            }

            map.put("resultList", result);
            map.put("resultCnt", cnt);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    /**
     * 통계표 연결 CUD
     */
    @Override
    public int bbsTblCUD(ArrayList<BbsList> list, String gubun) {
        // gubun => 'D' : 삭제, 'A' : 등록/수정
        int result = 0;
        try {
            for (BbsList saveVO : list) {

                if ("D".equals(gubun)) {
                    if (saveVO.getStatus().equals("D")) {
                        result = bbsListDAO.deleteBbsTbl(saveVO);
                    }
                } else {
                    if (saveVO.getStatus().equals("I")) {
                        result = bbsListDAO.insertBbsTbl(saveVO);
                    } else if (saveVO.getStatus().equals("U")) {
                        result = bbsListDAO.updateBbsTbl(saveVO);
                    }
                }
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    @Override
    public Record selectGalleryPop(Params params) {
        // 게시판 내용을 확인한다.
        Record data = checkBbsList(params, "portal.error.000059");

        // 첨부파일이 있는 경우
        if (data.getInt("fileCnt") > 0) {
            // 게시판 첨부파일을 검색한다.
            data.put("files", searchBbsFile(params));
        }

        // 링크가 있는 경우
        if (data.getInt("linkCnt") > 0) {
            // 게시판 링크를 검색한다.
            data.put("link", portalBbsLinkDao.searchBbsLink(params));
        }

        // 공공데이터가 있는 경우
        if (data.getInt("infCnt") > 0) {
            // 게시판 공공데이터를 검색한다.
            data.put("data", portalBbsInfDao.searchBbsInf(params));
        }

        // 안내수신문자 여부 
        data.put("dvp", portalBbsListDao.searchBbsDvp(params));

        return data;
    }

    /**
     * 게시판 내용을 확인한다.
     *
     * @param params 파라메터
     * @param error  오류코드
     * @return 확인결과
     */
    private Record checkBbsList(Params params, String error) {
        // 게시판 내용을 조회한다.
        Record data = portalBbsListDao.selectBbsList(params);
        try {
            // 게시판 내용이 없는 경우
            if (data == null) {
                throw new ServiceException(error, getMessage(error));
            }

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return data;
    }

}
