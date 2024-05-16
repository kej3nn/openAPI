
package egovframework.common.util;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.admin.basicinf.service.CommMenu;

/**
 * 메뉴 가공하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class UtilMenu {

    Logger logger = LoggerFactory.getLogger(getClass());


    /**
     * 관리자 메뉴를 html 형식을 가공해서 리턴한다.
     *
     * @param list
     * @return
     */
    public static String getAdminMenu(List<CommMenu> list) {
        StringBuffer sb = new StringBuffer();
        String neqstartString = "\n<ul class='${UL_CLASS}' style='${UL_STYLE}'>\n<li class='${LI_CLASS}' ${name}>\n";
        String eqstartString = "\n</li>\n<li class='${LI_CLASS}' ${name}>\n";
        String levelEnd = "\n</li>\n</ul>";
        String aEndString = "</a>";
        String aStartString = "<a href=\"#\" onclick=\"${ON_CLICK}\">";
        String menuNm = "";
        int level = 0;
        int menuLevel = 0;
        String url = "";
        int cnt = 0;
        String param = "";
        String StartString = "";
        for (CommMenu commMenu : list) {
            menuNm = commMenu.getMenuNm();
            menuLevel = commMenu.getLevel();
            url = commMenu.getMenuUrl();
            param = commMenu.getMenuParam();
            if (!UtilString.null2Blank(param).equals("")) {
                url += param;
            }
            //if(url != null) url = "/research" + url;
            if (UtilString.null2Blank(url).equals("")) {
                StartString = UtilString.replace(aStartString, "${ON_CLICK}", "return false;");
            } else {
                StartString = UtilString.replace(aStartString, "${ON_CLICK}", "adminTopMenu('" + url + "');return false;");
            }
            if (level == menuLevel) {//레벨이 같을때
                addBuffer(sb, eqstartString, StartString, menuNm, aEndString, menuLevel);
            } else if (level < menuLevel) {//레벨이 다르면서 기존 레벨 보다 클때
                if (cnt == 0) {
                    addBuffer(sb, neqstartString, StartString, menuNm, aEndString, 0);
                } else {
                    addBuffer(sb, neqstartString, StartString, menuNm, aEndString, menuLevel);
                }

            } else {//레벨이 다르면서 기존 레벨 보다 작을때
                int levelMiuns = level - menuLevel;
                for (int j = 0; j < levelMiuns; j++) {
                    sb.append(levelEnd);
                }
                addBuffer(sb, eqstartString, StartString, menuNm, aEndString, menuLevel);
            }
            level = menuLevel;
            cnt++;
        }

        if (sb.length() > 0) {
            for (int i = 0; i < level; i++) {
                sb.append(levelEnd);
            }
        }
        return sb.toString();
    }

    /**
     * String을 Buffer에 넣는다.
     *
     * @param sb
     * @param startString
     * @param aStartString
     * @param menuNm
     * @param endString
     * @param level
     */
    private static void addBuffer(StringBuffer sb, String startString, String aStartString, String menuNm, String endString, int level) {
        if (level == 0) {
            startString = UtilString.replace(startString, "${UL_STYLE}", "");
            startString = UtilString.replace(startString, "${UL_CLASS}", "lnb");
            startString = UtilString.replace(startString, "${LI_CLASS}", "dp01");
            startString = UtilString.replace(startString, "${name}", "");
        } else if (level == 1) {
            startString = UtilString.replace(startString, "${UL_STYLE}", "");
            startString = UtilString.replace(startString, "${UL_CLASS}", "");
            startString = UtilString.replace(startString, "${LI_CLASS}", "dp01");
            startString = UtilString.replace(startString, "${name}", "");
        } else if (level == 2) {
            startString = UtilString.replace(startString, "${UL_STYLE}", "visibility: hidden;");
            startString = UtilString.replace(startString, "${UL_CLASS}", "dp02");
            startString = UtilString.replace(startString, "${LI_CLASS}", "");
            startString = UtilString.replace(startString, "${name}", "name='dp02name'");
        } else {
            startString = UtilString.replace(startString, "${UL_STYLE}", "visibility: hidden;");
            startString = UtilString.replace(startString, "${UL_CLASS}", "dp03");
            startString = UtilString.replace(startString, "${LI_CLASS}", "");
            startString = UtilString.replace(startString, "${name}", "name='dp03name'");
        }
        sb.append(startString);
        if (level > 1) {
            sb.append(aStartString);
            sb.append("<span>");
            sb.append(menuNm);
            sb.append("<span name='removeSpan'>&nbsp;</span></span>");
        } else {
            sb.append(aStartString);
            sb.append(menuNm);
        }

        sb.append(endString);
    }

}
