package egovframework.admin.opendt.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.opendt.service.OpenCate;
import egovframework.admin.opendt.service.OpenCateService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.file.service.FileVo;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

/**
 * 분류정보 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

@Service("OpenCateService")
public class OpenCateServiceImpl extends AbstractServiceImpl implements OpenCateService {

    @Resource(name = "OpenCateDAO")
    protected OpenCateDAO openCateDAO;

    private static final Logger logger = Logger.getLogger(OpenCateServiceImpl.class);


    public Map<String, Object> selectOpenCateListAllMainTreeIbPaging(OpenCate openCate) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenCate> result = openCateDAO.selectOpenCateListAllMainTree(openCate);
            int cnt = openCateDAO.selectOpenCateListAllCnt(openCate);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public Map<String, Object> selectOpenCateListSubTreeIbPaging(OpenCate openCate) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenCate> result = openCateDAO.selectOpenCateListSubTree(openCate);
            int cnt = openCateDAO.selectOpenCateListSubTreeAllCnt(openCate);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }
    
    /*public OpenCate selectOpenCateOne(OpenCate openCate) {
		return  openCateDAO.selectOpenCateOne(openCate);
    }*/

    public List<OpenCate> selectOpenCateOne(OpenCate openCate) {
        List<OpenCate> result = new ArrayList<OpenCate>();
        try {
            result = openCateDAO.selectOpenCateOne(openCate);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public int openCateOrderBySave(ArrayList<OpenCate> list) {
        int result = 0;
        try {
            for (OpenCate openCate : list) {
                result = openCateDAO.updateOrderby(openCate);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public int openCateCheckDup(OpenCate openCate) {
        int result = 0;
        try {
            if (openCateDAO.selectOpenCateCheckDup(openCate) > 0) {
                return -1;
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


    public int saveOpenCateCUD(@NonNull OpenCate openCate, String status) {
        int result = 0;

        try {
            openCate.setCateIdTop(openCateDAO.selectOpenCateIdTop(openCate));
            if (StringUtils.defaultString(openCate.getCateIdPar()).equals("KOR") || StringUtils.defaultString(openCate.getCateIdPar()).equals("ENG") || StringUtils.defaultString(openCate.getCateIdPar()).equals("MOB")) {
                openCate.setCateIdParKEM("Y");
            } else {
                openCate.setCateIdParKEM(null);
            }
            if ((WiseOpenConfig.STATUS_D.equals(status))) {    // 분류 삭제
                result = openCateDAO.selectOpenCateListSubTreeAllCnt(openCate);// 하위분류 존재 유무 확인
                if (result > 1) {
                    result = -1;
                } else {
                    result = openCateDAO.delete(openCate);
                }
            }


            if (WiseOpenConfig.STATUS_I.equals(status)) {        // 분류 등록
                if (openCateDAO.selectOpenCateCheckDup(openCate) > 0) //중복체크
                    return -1;
                result = openCateDAO.mergeInto(openCate);
            }

            if (WiseOpenConfig.STATUS_U.equals(status)) {        // 분류 수정
                if (StringUtils.defaultString(openCate.getCateCib()).equals("Y")) {    //하위 분류가 있을 시

                    for (int i = 0; i < openCateDAO.checkUnderLvlCate(openCate).size(); i++) {  // 해당 분류를 해당분류의 하위분류로 삽입했을 경우 insert가 안되게 오류를 던져줌
                        if (openCateDAO.checkUnderLvlCate(openCate).get(i).getCateId().equals(StringUtils.defaultString(openCate.getCateIdPar())))
                            return 0;
                    }

                    String lvl = StringUtils.defaultString(openCate.getCateLvl());
                    String topPrev = StringUtils.defaultString(openCate.getCateIdTop());
                    result = openCateDAO.mergeInto(openCate);
                    openCateDAO.updateUseYn(openCate);//변경시 하위 까지 사용, 미사용처리
                    openCate = (OpenCate) openCateDAO.selectOpenCateOne(openCate);
                    int updlvl = 0;
                    if ((Integer.parseInt(lvl) - Integer.parseInt(StringUtils.defaultString(openCate.getCateLvl()))) == 0) {    // 레벨변경이 없을 시
                        updlvl = 0;
                    } else {    // 레벨 변경시
                        updlvl = (Integer.parseInt(StringUtils.defaultString(openCate.getCateLvl())) - Integer.parseInt(lvl));
                        openCate.setUpdlvl(updlvl);
                        openCate.setTopPrev(topPrev);
                        result = openCateDAO.updOpenCateLvl(openCate);
                    }
                    // 하위 분류의 cateFullnm,cateFullnmEng 변경하기 위한 logic
                    List<OpenCate> UpdCate = openCateDAO.getCateFullNmQuery(openCate);
                    for (int i = 0; i < UpdCate.size(); i++) {
                        result = openCateDAO.actCateFullNmUpd(UpdCate.get(i));
                    }
                } else {                                    // 하위 분류가 없을 시
                    result = openCateDAO.mergeInto(openCate);
                }
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public Map<String, Object> selectOpenCateParListTreeIbPaging(OpenCate openCate) {

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenCate> result = openCateDAO.selectOpenCateParListTree(openCate);
            //    	int cnt = openCateDAO.selectOpenCateListAllCnt(openCate);
            //		map.put("resultCnt", Integer.toString(cnt));
            map.put("resultList", result);
            map.put("resultCnt", result.size());
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }


    public int saveOpenCateLvlCUD(OpenCate openCate) {

        int result = 0;
        try {
            result = openCateDAO.updOpenCateLvl(openCate);

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public List<OpenCate> selectOpenCateTop() {
        List<OpenCate> result = new ArrayList<OpenCate>();
        try {
            result = openCateDAO.selectOpenCateTop();

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    //첨부파일 저장, 수정
    public int saveImgFileListCUD(OpenCate opencate, ArrayList<?> list, FileVo fileVo) {
        int result = 0;
        String fileName = "";
        String[] fileNames = fileVo.getSaveFileNm();
        for (String name : fileNames) {
            fileName = name;
        }

        try {
            for (int i = 0; i < list.size(); i++) {
                logger.debug("-----------------------------------------------------\n" + ((OpenCate) list.get(i)).getSaveFileNm());
                ((OpenCate) list.get(i)).setSaveFileNm(fileName);
                logger.debug("-----------------------------------------------------\n" + ((OpenCate) list.get(i)).getSaveFileNm());
                result += openCateDAO.updateImgFile((OpenCate) list.get(i));
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    @Override
    public Map<String, Object> cateImgDetailView(OpenCate opencate) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenCate> resultImg = openCateDAO.cateImgDetailView(opencate);
            //List<BbsList> resultTopYn = bbsListDAO.getTopImg(opencate);
            map.put("resultImg", resultImg);
            //map.put("resultTopYn", resultTopYn);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public int deleteImgDtlCUD(OpenCate opencate) {            // 수정 필요함..
        int result = 0;
        try {
            if (result > 1) {
                result = -1;
            } else {
                result = openCateDAO.deleteImg(opencate);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }


}