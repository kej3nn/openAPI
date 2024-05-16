
package egovframework.common.aspect;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.grid.CommVo;
import egovframework.common.util.UtilString;

/**
 * 페이징 처리 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class AspectIbSheetPaging {

    Logger logger = LoggerFactory.getLogger(getClass());


    /**
     * 시작 페이지 구하기
     *
     * @param page
     * @param pageRow
     * @return
     */
    public int startPageNum(int page, int pageRow) {
        if (page == 0) {
            return 0;
        }
        return ((page - 1) * pageRow) + 1;
    }

    /**
     * 마지막 페이지 구하기
     *
     * @param page
     * @param pageRow
     * @return
     */
    public int EndPageNum(int page, int pageRow) {
        if (page == 0) {
            return 0;
        }
        logger.debug(page + " " + pageRow);
        return page * pageRow;
    }

    /**
     * 페이징 처리.
     *
     * @param Vo
     * @return
     */
    public void PageNum(Object Vo) {
        int page = ((CommVo) Vo).getIbpage();
        int pageRow = ((CommVo) Vo).getOnepagerow();
        ((CommVo) Vo).setStartPage(startPageNum(page, pageRow));
        ((CommVo) Vo).setEndPage(EndPageNum(page, pageRow));


        if (EgovUserDetailsHelper.isAuthenticated()) {
            EgovUserDetailsHelper.getAuthenticatedUser();
            CommUsr resultVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            ((CommVo) Vo).setSessionUsrCd(resultVO.getUsrCd());
            ((CommVo) Vo).setSessionUsrId(resultVO.getUsrId() + "");
            ((CommVo) Vo).setSessionOrgCd(resultVO.getOrgCd() + "");        //추가(2014.11.18)
            ((CommVo) Vo).setSessionOrgNm(resultVO.getOrgNm() + "");    //추가(2014.11.18)
            ((CommVo) Vo).setSessionUsrNm(resultVO.getUsrNm() + "");    //추가(2014.11.18)
        }

        setOrderBy(Vo);
    }


    /**
     * IbSheet 정렬 처리
     *
     * @param Vo
     */
    private void setOrderBy(Object Vo) {
        String iborderby = ((CommVo) Vo).getIborderby();

        if (iborderby != null && !iborderby.equals("")) {
            String orderBy[] = UtilString.getSplitArray(iborderby, "^");
            String colNm[] = UtilString.getSplitArray(orderBy[0], "|");
            String sort[] = UtilString.getSplitArray(orderBy[1], "|");
            String orderStr = "";
            for (int i = 0; i < colNm.length; i++) {

                if (colNm[i].indexOf("_") > -1) {
                    orderStr += colNm[i].toUpperCase() + " " + sort[i].toUpperCase() + ",";
                } else {
                    orderStr += colConvert(colNm[i]).toUpperCase() + " " + sort[i].toUpperCase() + ",";
                }
            }
            //취약점 조치사항
            ((CommVo) Vo).setiOrderBy(UtilString.SQLInjectionFilter2(orderStr.substring(0, orderStr.length() - 1)));
            logger.debug("IBSheet order by : " + ((CommVo) Vo).getiOrderBy());
        }
    }

    /**
     * IbSheet 컬럼명은 변환
     *
     * @param input
     * @return
     */
    public String colConvert(String input) {
        Pattern pattern = Pattern.compile("[A-Z]");
        Pattern pattern2 = Pattern.compile("[0-9]");
        Matcher matcher;
        Matcher matcher2;
        StringBuffer sb = new StringBuffer();
        //대문자만...
        int UpperCnt = 0;
        for (int i = 0; i < input.length(); i++) {
            matcher = pattern.matcher(Character.toString(input.charAt(i)));
            if (matcher.matches()) {
                sb.append("_" + input.charAt(i));
            } else {
                matcher2 = pattern2.matcher(Character.toString(input.charAt(i)));
                if (!matcher2.matches()) {
                    UpperCnt++;
                }
                sb.append(input.charAt(i));
            }
        }
        if (UpperCnt == 0) {
            return input;
        } else {
            return sb.toString();
        }


    }
}
