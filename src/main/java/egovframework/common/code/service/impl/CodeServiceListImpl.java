package egovframework.common.code.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.ComboIBSVo;
import egovframework.common.util.UtilString;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * was가 시작될때 콩통코드를 map에 담는 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

@Service("CodeListService")
public class CodeServiceListImpl extends AbstractServiceImpl implements CodeListService {

    @Resource(name = "CodeDAO")
    private CodeDAO codeDAO;

    private static final Logger logger = Logger.getLogger(CodeServiceListImpl.class.getClass());


    public Map<String, CommCode> cmcdCodeMap; //공통코드 전체 맵 (코드, 객체)


    /**
     * <PRE>
     * 1. MethodName : init
     * 2. Comment    : 공통코드를 DB에서 가져와 맵에 저장하는 초기화 메소드
     * 3. 작성자       : cyy
     * 4. 작성일       : 2013. 3. 28.
     * </PRE>
     *
     * @return void
     */
    @Override
    @PostConstruct
    public void init() {
        //공통코드 맵을 확인 후 있으면 비운다.
        if (cmcdCodeMap != null && !cmcdCodeMap.isEmpty()) {
            cmcdCodeMap = null;
        }

        //공통코드 전체 리스트를 매퍼를 통해 리스트에 담는다.
        List<CommCode> commDcdList = new ArrayList<CommCode>();
        try {
            commDcdList = codeDAO.selectCodeList();
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        //공통코드 맵을 초기화 한다.
        cmcdCodeMap = new HashMap<String, CommCode>();

        //리스트의 내용을 공통코드, 공통코드객체 형태의 맵으로 변
        for (CommCode commDcd : commDcdList) {
            cmcdCodeMap.put(commDcd.getDitcCd(), commDcd);
        }

    }

    public Map<String, CommCode> getCmcdCodeMap() {
        return cmcdCodeMap;
    }


    public void setCmcdCodeMap(Map<String, CommCode> cmcdCodeMap) {
        if (!cmcdCodeMap.isEmpty()) {
            Set<String> entrySet = cmcdCodeMap.keySet();
            Iterator<String> iter = entrySet.iterator();
            while (iter.hasNext()) {
                String sKey = ((String) iter.next());
                this.cmcdCodeMap.put(sKey, cmcdCodeMap.get(sKey));
            }
        }
    }

    /**
     * 공통코드 조회 - 코드값
     */
    public CommCode getCmcdDcdbyCode(String Code) {
        //공통코드 맵에 내용 확인 후 없으면 초기화 한다.
        if (cmcdCodeMap == null || cmcdCodeMap.isEmpty()) {
            init();
        }
//		해당 코드를 찾아서 리턴한다.
        return this.cmcdCodeMap.get(Code);

    }

    /**
     * 공통코드의 상세코드 리스트 조회
     */
    @Override
    public List<CommCode> getCodeList(String codenm) {
        CommCode commCode = getCmcdDcdbyCode(codenm);
        return commCode != null ? commCode.getCommCodeLists() : null;

    }

    public ComboIBSVo getCodeListIBS(String codenm) {
        return getCodeListIBS(codenm, false);
    }

    public ComboIBSVo getCodeListIBS(String codenm, boolean firstBlankYn) {
        return getCodeListIBS(codenm, firstBlankYn, "");
    }

    /**
     * IBSheet Combo 코드용 코드 조회
     */
    @Override
    public ComboIBSVo getCodeListIBS(String codenm, boolean firstBlankYn, String langType) {

        ComboIBSVo comboIbs = new ComboIBSVo();
        StringBuilder code = new StringBuilder();
        StringBuilder text = new StringBuilder();

        if (firstBlankYn) {
            code.append("|");
            text.append("|");
        }
        List<CommCode> codeList = getCodeList(codenm);
        if (codeList != null) {
            int i = 0;
            for (CommCode vo : codeList) {
                if (i++ > 0) {
                    code.append("|");
                    text.append("|");
                }
                code.append(vo.getDitcCd());
                if (UtilString.null2Blank(langType).equals("E")) {
                    text.append(vo.getDitcNmEng());
                } else {
                    text.append(vo.getDitcNm());
                }

            }
            comboIbs.ComboCode = code.toString();
            comboIbs.ComboText = text.toString();
        } else {
            comboIbs.ComboCode = "코드미존재";
            comboIbs.ComboText = "코드미존재";
        }

        return comboIbs;
    }

    @Override
    public List<CommCode> getEntityCodeList(String codenm) {
        return getEntityCodeList(codenm, "");
    }

    public List<CommCode> getEntityCodeList(String codenm, String value) {
        return getEntityCodeList(codenm, value, "");
    }

    /**
     * 공통코드의 상세코드 리스트 조회
     */
    @Override
    public List<CommCode> getEntityCodeList(String codenm, String value, String langType) {
        List<CommCode> list = new ArrayList<CommCode>();
        try {
            if (codenm.equals("ORG_CD")) {//조직코드
                list = codeDAO.selectEntityOrgCodeList();
            } else if (codenm.equals("INF_STATS")) {
                String codeCd[] = {"N", "Y", "X", "C"};
                String codeNm[] = {"미개방", "개방", "개방불가", "개방취소"};
                String codeNmEng[] = {"미개방", "개방", "개방불가", "개방취소"};
                list = new ArrayList<CommCode>();
                for (int i = 0; i < codeCd.length; i++) {
                    CommCode code = new CommCode();
                    code.setGrpCd("");
                    code.setDitcCd(codeCd[i]);
                    code.setDitcNm(codeNm[i]);
                    code.setDitcNmEng(codeNmEng[i]);
                    code.setRefCd("");
                    code.setUseYn("Y");
                    list.add(code);
                }
            } else if (codenm.equals("OP")) {
                String codeCd[] = {">", ">=", "<=", "<", "<>", "=", "IN", "LIKE", "IS"};
                String codeNm[] = {">", ">=", "<=", "<", "<>", "=", "IN", "LIKE", "IS"};
                String codeNmEng[] = {">", ">=", "<=", "<", "<>", "=", "IN", "LIKE", "IS"};
                list = new ArrayList<CommCode>();
                for (int i = 0; i < codeCd.length; i++) {
                    CommCode code = new CommCode();
                    code.setGrpCd("");
                    code.setDitcCd(codeCd[i]);
                    code.setDitcNm(codeNm[i]);
                    code.setDitcNmEng(codeNmEng[i]);
                    code.setRefCd("");
                    code.setUseYn("Y");
                    list.add(code);
                }
            } else if (codenm.equals("PRSS_STATE")) {
                String codeCd[] = {"AO", "AE", "AA", "AK", "AC", "CA", "CK", "CC"};
                String codeNm[] = {"등록중", "등록완료", "개방요청", "개방승인", "개방승인불가", "개방취소요청", "개방취소승인", "개방취소승인불가"};
                String codeNmEng[] = {"등록중", "등록완료", "개방요청", "개방승인", "개방승인불가", "개방취소요청", "개방취소승인", "개방취소승인불가"};
                list = new ArrayList<CommCode>();
                for (int i = 0; i < codeCd.length; i++) {
                    CommCode code = new CommCode();
                    code.setGrpCd("");
                    code.setDitcCd(codeCd[i]);
                    code.setDitcNm(codeNm[i]);
                    code.setDitcNmEng(codeNmEng[i]);
                    code.setRefCd("");
                    code.setUseYn("Y");
                    list.add(code);
                }
            } else if (codenm.equals("FILT_CODE")) {
                list = codeDAO.selectEntityFiltCodeList(value);
            } else if (codenm.equals("CATE_NM")) {
                list = codeDAO.selectEntityCateNmCodeList(value);
            } else if (codenm.equals("ITEM_CD")) {
                list = codeDAO.selectEntityItemCdCodeList(value);
            } else if (codenm.equals("UNIT_SUB_CD")) {
                list = codeDAO.selectUnitSubCdCodeList(value);
            } else if (codenm.equals("GRP_CD")) {
                list = codeDAO.selectEntityGrpCdCodeList(value);
            } else if (codenm.equals("TBL_CD")) {
                list = codeDAO.selectEntityTblCdCdCodeList(value);
            } else if (codenm.equals("LIST_CD")) {
                list = codeDAO.selectCodeDtlList(value);
            } else if (codenm.equals("BAR")) {
                list = codeDAO.selectSeriesCdBarList(value);
            } else if (codenm.equals("PIE")) {
                list = codeDAO.selectSeriesCdPieList(value);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return list;

    }

    public ComboIBSVo getEntityCodeListIBS(String codenm) {
        return getEntityCodeListIBS(codenm, false);
    }

    public ComboIBSVo getEntityCodeListIBS(String codenm, boolean firstBlankYn) {
        return getEntityCodeListIBS(codenm, false, "");
    }

    /**
     * IBSheet Combo 코드용 코드 조회
     */
    @Override
    public ComboIBSVo getEntityCodeListIBS(String codenm, boolean firstBlankYn, String langType) {

        ComboIBSVo comboIbs = new ComboIBSVo();
        StringBuilder code = new StringBuilder();
        StringBuilder text = new StringBuilder();
        if (firstBlankYn) {
            code.append("|");
            text.append("|");
        }
        List<CommCode> codeList = getEntityCodeList(codenm);
        if (codeList != null) {
            int i = 0;
            for (CommCode vo : codeList) {
                if (i++ > 0) {
                    code.append("|");
                    text.append("|");
                }
                code.append(vo.getDitcCd());
                if (UtilString.null2Blank(langType).equals("E")) {
                    text.append(vo.getDitcNmEng());
                } else {
                    text.append(vo.getDitcNm());
                }

            }
            comboIbs.ComboCode = code.toString();
            comboIbs.ComboText = text.toString();
        } else {
            comboIbs.ComboCode = "코드미존재";
            comboIbs.ComboText = "코드미존재";
        }

        return comboIbs;
    }

    /**
     * <PRE>
     * 1. MethodName : getCodeForIBS
     * 2. Comment    : IBS용 공통코드 제공 - String[0]-상세코드 "|" 조인,  String[1]-상세코드명 "|" 조인
     * 3. 작성자       : insomnia(장명수)
     * 4. 작성일       : 2013. 4. 1.
     * </PRE>
     *
     * @param commCd
     * @return String[]
     * @return
     */
    public String[] getCodeForIBS(String commCd) {
        StringBuilder sbcd = new StringBuilder();
        StringBuilder sbnm = new StringBuilder();

        CommCode commCode = getCmcdDcdbyCode(commCd);
        if (commCode != null && !commCode.getGrpCd().isEmpty()) {

            int i = 0;
            for (CommCode commDtlCd : commCode.getCommCodeLists()) {
                if (i++ > 0) {
                    sbcd.append("|");
                    sbnm.append("|");
                }
                sbcd.append(commDtlCd.getDitcCd());
                sbnm.append(commDtlCd.getDitcNm());
            }
        }

        return new String[]{sbcd.toString(), sbnm.toString()};

    }

    /**
     * <PRE>
     * 1. MethodName : getCodeJsonIBS
     * 2. Comment    : IBSheet용 콤보 코드를 VO 형태로 제공(Json으로 변환하여 사용 가능...)
     * 3. 작성자       : insomnia(장명수)
     * 4. 작성일       : 2013. 4. 18.
     * </PRE>
     *
     * @param commCd
     * @return ComboIBSVo
     * @return
     */
    public ComboIBSVo getCodeJsonIBS(String commCd) {

        ComboIBSVo comboIbs = new ComboIBSVo();

        String[] combo = getCodeForIBS(commCd);

        comboIbs.ComboCode = combo[1];
        comboIbs.ComboText = combo[2];

        return comboIbs;
    }

    /**
     * <PRE>
     * 1. MethodName : getComboIBSJson
     * 2. Comment    : 공통 코드를 IBSheet용 Json String 형태로 제공...
     * 3. 작성자       : insomnia(장명수)
     * 4. 작성일       : 2013. 4. 18.
     * </PRE>
     *
     * @param codenm
     * @return String
     * @return
     */
    public String getComboIBSJson(String codenm) {

        String result = null;
        ComboIBSVo vo = getCodeJsonIBS(codenm);
        ObjectMapper om = new ObjectMapper();

        try {
            result = om.writeValueAsString(vo);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        logger.debug(result);
        return result;
    }


    /**
     * 공통 상세코드명을 가져온다. insomnia
     */
    public String getDetailCodeNm(String commDcd, String commDtlCd) {
        List<CommCode> codeList = getCodeList(commDcd);

        if (codeList != null) {
            for (CommCode codevo : codeList) {
                if (commDtlCd.equals(codevo.getGrpCd())) {
                    return codevo.getDitcNm();
                }
            }
        }


        return null;
    }

    /**
     * 통계 기준정보 조회
     */
    @Override
    public List<CommCode> getSTTSCodeList(String codenm) {
        List<CommCode> result = new ArrayList<CommCode>();
        try {
            result = (List<CommCode>) codeDAO.selectSTTSCodeList(codenm);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }


}
