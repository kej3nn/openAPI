
package egovframework.common.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;

import egovframework.admin.basicinf.service.CommMenu;
import egovframework.com.cmm.EgovWebUtil;

/**
 * 트리형태로 변환하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class UtilTree {

    Logger logger = LoggerFactory.getLogger(getClass());


    /**
     * 트리 형식으로 가공해서 리턴한다.
     *
     * @param list
     * @param itemCnt
     * @return
     */
    public static LinkedHashMap<String, String> getTree(List<LinkedHashMap<String, String>> list, int itemCnt) {
        LinkedHashMap<String, String> returnmap = new LinkedHashMap<String, String>();
        StringBuffer sb = new StringBuffer();
        String neqstartString = "\n<ul>\n<li data=\"#select##level#\" id=\"#id\" class=\"#class\" title=\"#title\">\n";
        String eqstartString = "\n</li>\n<li data=\"#select##level#\" id=\"#id\" class=\"#class\" title=\"#title\">\n";
        String levelEnd = "\n</li>\n</ul>";
        String content = "";
        int level = 0;
        String itemCd = "";
        String itemNm = "";
        int ItemLevel = 0;
        int cnt = 0;
        int firstCnt = 0;
        String defaultCheckYn = "";
        for (LinkedHashMap<String, String> map : list) {
            itemCd = map.get("ITEM_CD");
            itemNm = map.get("ITEM_NM");
            ItemLevel = Integer.parseInt(map.get("ITEM_LEVEL"));
            defaultCheckYn = map.get("DEFAULT_CHECK_YN");
            String classNm = "";
            if (ItemLevel == 1) {
                if (firstCnt > 0) {
                    if (sb.length() > 0) {
                        for (int i = 0; i < level; i++) {
                            sb.append(levelEnd);
                        }
                    }
                    returnmap.put("data" + 0, sb.toString());
                    sb = new StringBuffer();
                    level = 0;
                }
                firstCnt++;
            }
            if (cnt < list.size() - 1) {
                if (ItemLevel < Integer.parseInt(list.get(cnt + 1).get("ITEM_LEVEL"))) {
                    classNm = "folder";
                }
            }
            cnt++;
            if (level == ItemLevel) {//레벨이 같을때
                content = eqstartString;
            } else if (level < ItemLevel) {//레벨이 다르면서 기존 레벨 보다 클때
                content = neqstartString;
            } else {//레벨이 다르면서 기존 레벨 보다 작을때
                int levelMiuns = level - ItemLevel;
                for (int j = 0; j < levelMiuns; j++) {
                    sb.append(levelEnd);
                }
                content = eqstartString;
            }
            addBuffer(sb, UtilString.replace(UtilString.replace(UtilString.replace(UtilString.replace(UtilString.replace(content, "#class", classNm), "#title", itemNm), "#id", itemCd), "#select#", "select:" + defaultCheckYn), "#level#", ",level:" + ItemLevel + ""), itemNm);
            level = ItemLevel;
        }

        if (sb.length() > 0) {
            for (int i = 0; i < level; i++) {
                sb.append(levelEnd);
            }
        }

        if (firstCnt == 1) {
            returnmap.put("data" + 0, sb.toString());
        } else {
            returnmap.put("data" + 1, sb.toString());
        }


        return returnmap;
    }


    /**
     * 분류별 형태로 트리를 만들어서 리턴한다.
     *
     * @param list
     * @return
     */
    public static LinkedHashMap<String, String> getCateTree(List<LinkedHashMap<String, String>> list) {
        LinkedHashMap<String, String> returnmap = new LinkedHashMap<String, String>();
        StringBuffer sb = new StringBuffer();
        String neqstartString = "\n<ul>\n<li data=\"#level#\" id=\"#id\" class=\"#class\" title=\"#title\">\n";
        String eqstartString = "\n</li>\n<li data=\"#level#\" id=\"#id\" class=\"#class\" title=\"#title\">\n";
        String levelEnd = "\n</li>\n</ul>";
        String content = "";

        int level = 0;
        String itemCd = "";
        String itemNm = "";
        int ItemLevel = 0;
        String itmeType = "";
        String openSrv = "";
        for (LinkedHashMap<String, String> map : list) {
            itemCd = map.get("ITEM_CD");
            itemNm = map.get("ITEM_NM");

            openSrv = UtilString.replace(UtilString.null2Blank(map.get("OPEN_SRV")), "&nbsp;", "");
            ItemLevel = Integer.parseInt(map.get("ITEM_LEVEL"));
            itmeType = map.get("ITEM_TYPE");
            String classNm = "";

            if (itmeType.equals("C")) {
                classNm = "folder";
                itemCd = "";
            }
            if (level == ItemLevel) {//레벨이 같을때
                content = eqstartString;
            } else if (level < ItemLevel) {//레벨이 다르면서 기존 레벨 보다 클때
                content = neqstartString;
            } else {//레벨이 다르면서 기존 레벨 보다 작을때
                int levelMiuns = level - ItemLevel;
                for (int j = 0; j < levelMiuns; j++) {
                    sb.append(levelEnd);
                }
                content = eqstartString;
            }
            addBuffer(sb, UtilString.replace(UtilString.replace(UtilString.replace(UtilString.replace(content, "#class", classNm), "#title", itemNm), "#id", itemCd), "#level#", "level:" + ItemLevel + ""), itemNm + openSrv);
            level = ItemLevel;
        }

        if (sb.length() > 0) {
            for (int i = 0; i < level; i++) {
                sb.append(levelEnd);
            }
        }
        returnmap.put("data", sb.toString());

        return returnmap;
    }


    /*
     public static LinkedHashMap<String,String> getCateTree(List<LinkedHashMap<String,String>> list) {
        LinkedHashMap<String,String> returnmap = new  LinkedHashMap<String,String>();
        StringBuffer sb = new StringBuffer();
        String neqstartString ="\n<ul>\n<li data=\"openSrv:'#openSrv#'\" id=\"#id\" class=\"#class\" title=\"#title\">\n";
        String eqstartString ="\n</li>\n<li data=\"openSrv:'#openSrv#'\" id=\"#id\" class=\"#class\" title=\"#title\">\n";
        String levelEnd ="\n</li>\n</ul>";
        String content ="";

        int level = 0;
        String itemCd="";
        String itemNm="";
        int ItemLevel=0;
        String itmeType="";
        String openSrv ="";
        for(LinkedHashMap<String,String> map:list){
            itemCd = map.get("ITEM_CD");
            itemNm = map.get("ITEM_NM");

            openSrv = UtilString.replace(UtilString.null2Blank(map.get("OPEN_SRV")), "&nbsp;", "");
            ItemLevel = Integer.parseInt(map.get("ITEM_LEVEL"));
            itmeType = map.get("ITEM_TYPE");
            String classNm="";

            if(itmeType.equals("C")){
                classNm ="folder";
                itemCd ="";
            }
            if(level == ItemLevel){//레벨이 같을때
                content = eqstartString;
            }else if(level < ItemLevel){//레벨이 다르면서 기존 레벨 보다 클때
                content = neqstartString;
            }else{//레벨이 다르면서 기존 레벨 보다 작을때
                int levelMiuns = level - ItemLevel;
                for(int j=0; j < levelMiuns; j++){
                    sb.append(levelEnd);
                }
                content = eqstartString;
            }
            addBuffer(sb,UtilString.replace(UtilString.replace(UtilString.replace(UtilString.replace(content, "#class", classNm),"#title", itemNm),"#id", itemCd),"#openSrv#",openSrv),itemNm);
            level = ItemLevel;
        }

        if(sb.length() > 0){
            for(int i=0; i < level; i++){
                sb.append(levelEnd);
            }
        }
        returnmap.put("data", sb.toString());

        return returnmap;
    }
    /**
     * String을 추가한다.
     * @param sb
     * @param startString
     * @param menuNm
     */
    private static void addBuffer(StringBuffer sb, String startString, String menuNm) {
        addBuffer(sb, startString, "", menuNm, "");
    }

    /**
     * String을 추가한다.
     *
     * @param sb
     * @param startString
     * @param url
     * @param menuNm
     * @param endString
     */
    private static void addBuffer(StringBuffer sb, String startString, String url, String menuNm, String endString) {
        sb.append(startString);
        sb.append(url);
        sb.append(menuNm);
        sb.append(endString);
    }

    /**
     * 통계포털에서 부모/자식 관계의 데이터를 트리형식으로 재나열 한다.
     *
     * @param list      2차원 배열
     * @param rootId    최상위 id
     * @param idKey     유니크한 키(id가 될 필드명)
     * @param pIdKey    부모키(pId가 될 필드명)
     * @param titleKey  메뉴명이 표시될 필드명
     * @param folderKey 폴더가 될 기준인 필드명
     * @param orderKey  정렬이 필요한경우 정렬 필드명
     * @return
     */
    public static List<Map<String, Object>> convertorTreeData(List inList, String rootId, final String idKey, final String pIdKey, final String titleKey, final String folderKey, final String orderKey) {
        List<Map<String, Object>> treeList = new ArrayList<Map<String, Object>>();   // 최종 트리

        //if( inList == null || inList.size() == 0 )  throw new RuntimeException("List<Map> 데이터가 없습니다.");
        //if( inList.get(0) == null )                 throw new RuntimeException("Map 데이터가 없습니다.");

        if (inList == null || inList.size() == 0) return treeList;
        if (inList.get(0) == null) return treeList;

        final List<Map<String, Object>> list = new ArrayList<Map<String, Object>>(); // 원본데이터(Bean일경우 Map으로 변환)
        Iterator iter;
        for (iter = inList.iterator(); iter.hasNext(); ) {
            try {
                Object obj = iter.next();
                if (obj instanceof Map) {
                    list.add((Map<String, Object>) obj);
                } else {
//                    list.add((Map<String, Object>) BeanUtils.describe(obj));
                }
            } catch (Exception e) {
                EgovWebUtil.exLogging("Collection -> List<Map> 으로 변환 중 실패: " + e);
            }
        }


        int listLength = list.size();
        int loopLength = 0;
        final int[] treeLength = new int[]{0};

        while (treeLength[0] != listLength && listLength != loopLength++) {
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> item = list.get(i);

                if (rootId.equals(String.valueOf(item.get(pIdKey)))) {
                    Map<String, Object> view = new HashMap<String, Object>(item);

                    String sTitleNm = "<em>" + item.get(titleKey);
                    if (item.get("statblExtNm") != null) sTitleNm += "(" + item.get("statblExtNm") + ")";
                    sTitleNm += "</em>";
                    view.put("title", sTitleNm);
                    view.put("children", new ArrayList<Map<String, Object>>());
                    view.put("key", item.get(idKey));
                    view.put("tooltip", item.get(titleKey));    //2022.12.21 접근성 처리

                    treeList.add(view);
                    list.remove(i);

                    treeLength[0]++;

                    if (orderKey != null) {
                        Collections.sort(treeList, new Comparator<Map<String, Object>>() {
                            public int compare(Map<String, Object> arg0, Map<String, Object> arg1) {
                                //return (String.valueOf(arg0.get(orderKey))).compareTo(String.valueOf(arg1.get(orderKey)));
                                return ((BigDecimal) arg0.get(orderKey)).intValue() < ((BigDecimal) arg1.get(orderKey)).intValue() ? -1 : ((BigDecimal) arg0.get(orderKey)).intValue() > ((BigDecimal) arg1.get(orderKey)).intValue() ? 1 : 0;
                            }
                        });
                    }

                    view.put("isFolder", "C".equals(String.valueOf(item.get(folderKey))) || "O".equals(String.valueOf(item.get(folderKey))) ? true : false);    // 폴더인 경우
                    view.put("expand", "true".equals(String.valueOf(item.get("open"))) ? true : false);    // 트리 기본 open(DB값을 true로 넘겨주면 됨)
                    view.put("select", "true".equals(String.valueOf(item.get("checked"))) ? true : false);    // 트리 기본 선택(DB값을 true로 넘겨주면 됨)


                    break;
                } else {
                    new InnerClass() {
                        public void getParentNode(List<Map<String, Object>> children, Map<String, Object> item) {
                            for (int i = 0; i < children.size(); i++) {
                                Map<String, Object> child = children.get(i);
                                if (child.get(idKey).equals(item.get(pIdKey))) {
                                    Map<String, Object> view = new HashMap<String, Object>(item);

                                    String sTitleNm = "<em value='" + item.get("dtacycleCd") + "'>" + item.get(titleKey);
                                    if (item.get("statblExtNm") != null)
                                        sTitleNm += "(" + item.get("statblExtNm") + ")";
                                    sTitleNm += "</em>";

                                    view.put("title", sTitleNm);
                                    view.put("children", new ArrayList<Map<String, Object>>());
                                    view.put("key", item.get(idKey));
                                    view.put("tooltip", item.get(titleKey));    //2022.12.21 접근성 처리
                                    ((List<Map<String, Object>>) child.get("children")).add(view);

                                    treeLength[0]++;

                                    list.remove(list.indexOf(item));

                                    view.put("isFolder", "C".equals(String.valueOf(item.get(folderKey))) || "O".equals(String.valueOf(item.get(folderKey))) ? true : false);    // 폴더인 경우
                                    view.put("expand", "true".equals(String.valueOf(item.get("open"))) ? true : false);    // 트리 기본 open(DB값을 true로 넘겨주면 됨)
                                    view.put("select", "true".equals(String.valueOf(item.get("checked"))) ? true : false);    // 트리 기본 선택(DB값을 true로 넘겨주면 됨)

                                    if (orderKey != null) {
                                        Collections.sort(((List<Map<String, Object>>) child.get("children")), new Comparator<Map<String, Object>>() {
                                            public int compare(Map<String, Object> arg0, Map<String, Object> arg1) {
                                                //return (String.valueOf(arg0.get(orderKey))).compareTo(String.valueOf(arg1.get(orderKey)));
                                                return ((BigDecimal) arg0.get(orderKey)).intValue() < ((BigDecimal) arg1.get(orderKey)).intValue() ? -1 : ((BigDecimal) arg0.get(orderKey)).intValue() > ((BigDecimal) arg1.get(orderKey)).intValue() ? 1 : 0;
                                            }
                                        });
                                    }
                                    break;
                                } else {
                                    if (((List<Map<String, Object>>) child.get("children")).size() > 0) {
                                        getParentNode((List<Map<String, Object>>) child.get("children"), item);
                                    }
                                }
                            }
                        }
                    }.getParentNode(treeList, item);
                }
            }
        }
        return treeList;
    }

    public interface InnerClass {
        public void getParentNode(List<Map<String, Object>> list, Map<String, Object> item);
    }

}
