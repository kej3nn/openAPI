package egovframework.portal.search.service;

import java.util.HashMap;


public class WnCollection {
	
	
	public HashMap<String,HashMap<String,String>> collectionInfo = null;
	
	public HashMap<String,HashMap<String,String>> SearchConfig(){
		
		collectionInfo = new HashMap<String,HashMap<String,String>>();
		HashMap<String,String> temp = new HashMap<String,String>();
		
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "정보공개데이터");
		temp.put("collection", "iopen"); //index name
		temp.put("searchField", "INF_TIT,REL_DATA,INF_CONT,SCHW_TAG_CONT");
		temp.put("documentField", "DOCID,RDATE,DREDATE,SYS_CD,INF_TIT,INF_CONT/200,SYS_NM,DIR_CD,ORG_CD,OPENTY_TAG_NM,INFA_ID,SCHW_TAG_CONT,INF_PATH,OPEN_YMD,VIEW_CNT,INF_URL,OPEN_SRV,LOAD_DTTM,REL_DATA/190,REL_LINK,FILE_TITLE,FILE_URL,FILE_CONTENT/200,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "INF_TIT");
		temp.put("searchContent", "REL_DATA,INF_CONT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("iopen", temp);
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "정보공개명칭");
		temp.put("collection", "iopen_name"); //index name
		temp.put("searchField", "INF_TIT,SCHW_TAG_CONT,COLS");
		temp.put("documentField", "DOCID,RDATE,OPEN_YMD,INF_TIT,INF_CONT/200,SCHW_TAG_CONT,INF_PATH,VIEW_CNT,INF_URL,LOAD_DTTM,COLS/100,ALIAS");
		temp.put("searchTitle", "INF_TIT");
		temp.put("searchContent", "COLS");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("iopen_name", temp);
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "의원소개");
		temp.put("collection", "iopen_chairman"); //index name
		temp.put("searchField", "HG_NM,ENG_NM");
		temp.put("documentField", "DOCID,RDATE,HG_NM,ENG_NM,DEPT_IMG_URL,POLY_NM,ORIG_NM,CMITS,REELE_GBN_NM,UNITS,HOMEPAGE,E_MAIL,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "HG_NM");
		temp.put("searchContent", "HG_NM");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("iopen_chairman", temp);
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "국회정보나침반");
		temp.put("collection", "iopen_compass"); //index name
		temp.put("searchField", "INFO_NM,CATE_FULLNM,ORG_NM,INFO_SRC_EXP");
		temp.put("documentField", "DOCID,RDATE,INFO_ID,INFO_NM,CATE_FULLNM,ORG_NM,INFO_SRC_EXP,SRC_URL,VIEW_CNT,C_ORDER,N_ORDER,UPD_DTTM,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "CATE_FULLNM");
		temp.put("searchContent", "INFO_SRC_EXP");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("iopen_compass", temp);
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "메뉴검색");
		temp.put("collection", "iopen_menu"); //index name
		temp.put("searchField", "MENU_FULLNM,MENU_NM");
		temp.put("documentField", "DOCID,RDATE,MENU_ID,MENU_NM,MENU_FULLNM,MENU_URL,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "MENU_NM");
		temp.put("searchContent", "MENU_FULLNM");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("iopen_menu", temp);
		
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "첨부파일");
		temp.put("collection", "iopen_file"); //index name
		temp.put("searchField", "FILE_TITLE,FILE_CONTENT");
		temp.put("documentField", "DOCID,RDATE,FILE_TITLE,EXT,FILE_URL,FILE_CONTENT/200,INF_PATH,ALIAS");
		temp.put("searchTitle", "FILE_TITLE");
		temp.put("searchContent", "FILE_CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("iopen_file", temp);
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "알림마당");
		temp.put("collection", "iopen_notice"); //index name
		temp.put("searchField", "BBS_TIT,BBS_CONT");
		temp.put("documentField", "DOCID,RDATE,SEQ,REG_DTTM,BBS_CD,BBS_NM,BBS_TIT,USER_NM,BBS_CONT/200,VIEW_CNT,MENU_PATH,FILE_TITLE,FILE_URL,FILE_CONTENT/200,URL,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "BBS_TIT");
		temp.put("searchContent", "BBS_CONT,FILE_CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("iopen_notice", temp);
		
		
		/*    L  국회 활동  */
		temp = new HashMap<String,String>();
		temp.put("collectionName", "국회활동");
		temp.put("collection", "assem_act"); //index name
		temp.put("searchField", "STITLE,CONTENT,MENU_PATH,FILE_CONTENT");
		temp.put("documentField", "DOCID,RDATE,DREDATE,STITLE/40,CONTENT/200,MENU_PATH,URL,TOPIC,TERMS,FILE_CONTENT/200,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC");
		
		collectionInfo.put("assem_act", temp);
		temp = null;

		/*    L  홈페이지 도움말 */
		temp = new HashMap<String,String>();
		temp.put("collectionName", "홈페이지 도움말");
		temp.put("collection", "homehelp"); //index name
		temp.put("searchField", "STITLE,CONTENT,MENU_PATH");
		temp.put("documentField", "DOCID,RDATE,DREDATE,STITLE/40,CONTENT/200,MENU_PATH,URL,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC");
		
		collectionInfo.put("homehelp", temp);
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "메뉴찾기");
		temp.put("collection", "home_menu"); //index name
		temp.put("searchField", "MENU_FULL_LOCATION,CONTENT,STITLE");
		temp.put("documentField", "DOCID,RDATE,UPDATE,STITLE,CONTENT/200,URL,MENU_FULL_LOCATION,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC");
		
		collectionInfo.put("home_menu", temp);
		temp = null;
		
		/*    L  공지사항  */
		temp = new HashMap<String,String>();
		temp.put("collectionName", "알림마당");
		temp.put("collection", "notice"); //index name
		temp.put("searchField", "STITLE,CONTENT,MENU_PATH");
		temp.put("documentField", "DOCID,RDATE,DREDATE,STITLE/40,CONTENT/200,MENU_PATH,URL,IMG_PATH,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC");
		
		collectionInfo.put("notice", temp);
		temp = null;

		/*    L  지식 */
	 	temp = new HashMap<String,String>();
		temp.put("collectionName", "소통마당·국회소개");
		temp.put("collection", "cmmnt"); //index name
		temp.put("searchField", "STITLE,CONTENT,MENU_PATH");
		temp.put("documentField", "DOCID,RDATE,DREDATE,STITLE/40,CONTENT/200,MENU_PATH,URL,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("cmmnt", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "의원활동");
		temp.put("collection", "chairman"); //index name
		temp.put("searchField", "STITLE,CONTENT,MENU_PATH");
		temp.put("documentField", "DOCID,RDATE,DREDATE,STITLE,CONTENT/200,MENU_PATH,URL,IMG_PATH,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("chairman", temp); 
		temp = null;
		
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "의원소개");
		temp.put("collection", "chairman_intro"); //index name
		temp.put("searchField", "IF_HG_NM,IF_HJ_NM,IF_ENG_NM");
		temp.put("documentField", "DOCID,RDATE,NUM,IF_HG_NM,IF_HJ_NM,IF_ENG_NM,BTH_DATE,ORIG_NM,REELE_GBN_NM,DEPT_CD,DEPT_NM,ASSEM_HOMEP,ASSEM_EMAIL,DTL_NM,COMMITE_NAME,UNIT_LIST,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("chairman_intro", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "본회의");
		temp.put("collection", "record1"); //index name
		temp.put("searchField", "CONTENT,SPEAKER,STITLE,TITLE_DOC,TAG");
		temp.put("documentField", "DOCID,RDATE,STITLE/40,CONTENT/200,SPEAKER,CLS_CD,COM_CD,COM_NM,DAE_NM,SES_NM,DEG_NM,PAGE,HWP,PDF,BA_GB,CONFER_NUM,SUB_NUM,PDF_ID,HWP_ID,VODCOMM_CODE,TAG,PDF_A,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "STITLE,TITLE_DOC");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("record1", temp); 
		temp = null;
		
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "상임위원회");
		temp.put("collection", "record2"); //index name
		temp.put("searchField", "CONTENT,SPEAKER,STITLE,TITLE_DOC,TAG");
		temp.put("documentField", "DOCID,RDATE,STITLE/40,CONTENT/200,SPEAKER,CLS_CD,COM_CD,COM_NM,DAE_NM,SES_NM,DEG_NM,PAGE,HWP,PDF,BA_GB,CONFER_NUM,SUB_NUM,PDF_ID,HWP_ID,VODCOMM_CODE,TAG,PDF_A,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "STITLE,TITLE_DOC");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("record2", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "특별위원회");
		temp.put("collection", "record3"); //index name
		temp.put("searchField", "CONTENT,SPEAKER,STITLE,TITLE_DOC,TAG");
		temp.put("documentField", "DOCID,RDATE,STITLE/40,CONTENT/200,SPEAKER,CLS_CD,COM_CD,COM_NM,DAE_NM,SES_NM,DEG_NM,PAGE,HWP,PDF,BA_GB,CONFER_NUM,SUB_NUM,PDF_ID,HWP_ID,VODCOMM_CODE,TAG,PDF_A,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "STITLE,TITLE_DOC");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("record3", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "예산결산특별위원회");
		temp.put("collection", "record4"); //index name
		temp.put("searchField", "CONTENT,SPEAKER,STITLE,TITLE_DOC,TAG");
		temp.put("documentField", "DOCID,RDATE,STITLE/40,CONTENT/200,SPEAKER,CLS_CD,COM_CD,COM_NM,DAE_NM,SES_NM,DEG_NM,PAGE,HWP,PDF,BA_GB,CONFER_NUM,SUB_NUM,PDF_ID,HWP_ID,VODCOMM_CODE,TAG,PDF_A,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "STITLE,TITLE_DOC");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("record4", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "국정감사");
		temp.put("collection", "record5"); //index name
		temp.put("searchField", "CONTENT,SPEAKER,STITLE,TITLE_DOC,TAG");
		temp.put("documentField", "DOCID,RDATE,STITLE/40,CONTENT/200,SPEAKER,CLS_CD,COM_CD,COM_NM,DAE_NM,SES_NM,DEG_NM,PAGE,HWP,PDF,BA_GB,CONFER_NUM,SUB_NUM,PDF_ID,HWP_ID,VODCOMM_CODE,TAG,PDF_A,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "STITLE,TITLE_DOC");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("record5", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "국정조사");
		temp.put("collection", "record6"); //index name
		temp.put("searchField", "CONTENT,SPEAKER,STITLE,TITLE_DOC,TAG");
		temp.put("documentField", "DOCID,RDATE,STITLE/40,CONTENT/200,SPEAKER,CLS_CD,COM_CD,COM_NM,DAE_NM,SES_NM,DEG_NM,PAGE,HWP,PDF,BA_GB,CONFER_NUM,SUB_NUM,PDF_ID,HWP_ID,VODCOMM_CODE,TAG,PDF_A,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "STITLE,TITLE_DOC");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("record6", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "국정감사");
		temp.put("collection", "audit"); //index name
		temp.put("searchField", "STITLE,CONTENT,DP_CONTENT01,DP_CONTENT02");
		temp.put("documentField", "DOCID,RDATE,SEQNO,STITLE/70,DP_CONTENT01/200,DP_CONTENT02/200,CONTENT/200,PDF_NM,HWP_NM,PAGE,TYPE,YEAR,CMT_NM,START_PAGE,END_PAGE,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "STITLE,");
		temp.put("searchContent", "CONTENT, DP_CONTENT01,DP_CONTENT02");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("audit", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "제안 및 주요내용");
		temp.put("collection", "bill"); //index name
		temp.put("searchField", "SUMMARY,BILLNAME,AGE,PROPSEPERIOD");
		temp.put("documentField", "DOCID,RDATE,PROPSEDT,BILLNO,BILLKINDCD,AGE,BILLNAME,BILLNAMEC,LAWTITLE,PROPOSER,PROCRESULTCD,SUMMARY/200,SUMMARYCD,PROPOSERKINDCD,PROPSEPERIOD,BILLNAMESORT,TERMS,TOPIC,ALIAS");
		temp.put("searchTitle", "BILLNAME");
		temp.put("searchContent", "SUMMARY");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("bill", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "심사보고서");
		temp.put("collection", "bill_simsa"); //index name
		temp.put("searchField", "STITLE,CONTENT");
		temp.put("documentField", "DOCID,RDATE,STITLE,BILL_NO,BILL_ID,DAE,RSESSION,KIND,PROPOSAL,PROPOSER,COMT_NM,RST_CD,PROPOSE_DT,CONTENT/200,TERMS,TOPIC,ALIAS");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("bill_simsa", temp);
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "검토보고서");
		temp.put("collection", "bill_review"); //index name
		temp.put("searchField", "STITLE,CONTENT");
		temp.put("documentField", "DOCID,RDATE,STITLE,BILL_ID,PROPOSER,PROPOSE_DT,BILL_NO,BILL_KIND_CD,AGE,PROC_SESSION,PROPOSER_KIND_CD,CURR_COMMITTEE,PROC_DT,PROC_RESULT_CD,BOOK_ID,CONTENT/200,TERMS,TOPIC,ALIAS");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("bill_review", temp);
		
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "법률지식정보");
		temp.put("collection", "nalaw"); //index name
		temp.put("searchField", "STITLE,TITLE_SER,CONTENT");
		temp.put("documentField", "DOCID,RDATE,CONT_ID,CONT_SID,STITLE,TITLE_SER,DOCMAP_WDNM,DOCMAPGRP_NM,DOCREVTYPE_NM,PROM_DNO,PROM_DT,EXE_DT,CONTENT/200,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE,TITLE_SER");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("nalaw", temp); 
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "국회위원회");
		temp.put("collection", "committee"); //index name
		temp.put("searchField", "STITLE,CONTENT");
		temp.put("documentField", "DOCID,RDATE,STITLE,CONTENT/200,CREATE_DT,DREDATE,MENU_NAV,PAGE,V_URL,SITE_ID,MF_SITE_ID,SITE_NM,V_SITE_MENU_NAV,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("committee", temp); 
		

		temp = new HashMap<String,String>();
		temp.put("collectionName", "첨부파일"); 
		temp.put("collection", "committee_file"); //index name
		temp.put("searchField", "STITLE,FILE_CONTENT");
		temp.put("documentField", "DOCID,RDATE,STITLE,FILE_CONTENT/200,ARTICLE_NO,FILE_PATH,ENCODE_NM,FILE_NM,CREATE_DT,DREDATE,MENU_NAV,PAGE,V_URL,SITE_ID,MF_SITE_ID,SITE_NM,V_SITE_MENU_NAV,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "FILE_CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("committee_file", temp);
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "국회사무처");
		temp.put("collection", "nas"); //index name
		temp.put("searchField", "STITLE,CONTENT");
		temp.put("documentField", "DOCID,RDATE,STITLE,CONTENT/200,CREATE_DT,DREDATE,MENU_NAV,PAGE,V_URL,SITE_ID,MF_SITE_ID,SITE_NM,V_SITE_MENU_NAV,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("nas", temp);
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "연구용역보고서");
		temp.put("collection", "nas_ebook"); //index name
		temp.put("searchField", "STITLE,FILE_CONTENT");
		temp.put("documentField", "DOCID,RDATE,V_DOMAIN,STITLE/50,DREDATE,V_COMMITTEENM,V_BOARDNM,MF_COMMITTEEID,FILE_CONTENT/200,GB_DEP_ID,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "FILE_CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("nas_ebook", temp);	
		
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "첨부파일");
		temp.put("collection", "nas_file"); //index name
		temp.put("searchField", "STITLE,FILE_CONTENT");
		temp.put("documentField", "DOCID,RDATE,STITLE,FILE_CONTENT/200,ARTICLE_NO,FILE_PATH,ENCODE_NM,FILE_NM,CREATE_DT,DREDATE,MENU_NAV,PAGE,V_URL,SITE_ID,MF_SITE_ID,SITE_NM,V_SITE_MENU_NAV,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "FILE_CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC"); 
		
		collectionInfo.put("nas_file", temp);
		
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "청원");
		temp.put("collection", "petit"); //index name
		temp.put("searchField", "PETIT_SJ,PETIT_CN,PETIT_OBJET");
		temp.put("documentField", "DOCID,RDATE,PETIT_ID,PETIT_SJ/70,PETIT_OBJET,PETIT_CN/200,PETIT_REALM_NM,STTUS_CODE,HASHTAG_NM,RESULT_CODE,TOPIC,TERMS,ALIAS");
		temp.put("searchTitle", "PETIT_SJ");
		temp.put("searchContent", "PETIT_CN");
		temp.put("sortField", "RANK/DESC,RDATE/DESC");
		
		collectionInfo.put("petit", temp);
		
		
		//new homepage start
		temp = new HashMap<String,String>();
		temp.put("collectionName", "홈페이지");
		temp.put("collection", "home_data"); //index name
		temp.put("searchField", "STITLE,CONTENT");
		temp.put("documentField", "DOCID,DATE,RDATE,MENU_PATH,STITLE/60,CONTENT/200,LINK_URL,STD_NM,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC");
		
		collectionInfo.put("home_data", temp);
		temp = null;
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "홈페이지첨부파일");
		temp.put("collection", "home_file"); //index name
		temp.put("searchField", "STITLE,CONTENT");
		temp.put("documentField", "DOCID,DATE,RDATE,MENU_PATH,STITLE/60,CONTENT/200,LINK_URL,STD_NM,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC");
		
		collectionInfo.put("home_file", temp);
		temp = null;
		
		
		temp = new HashMap<String,String>();
		temp.put("collectionName", "국회보");
		temp.put("collection", "home_magazine"); //index name
		temp.put("searchField", "STITLE,CONTENT");
		temp.put("documentField", "DOCID,DATE,RDATE,MENU_PATH,STITLE/60,CONTENT/200,LINK_URL,STD_NM,ALIAS");
		temp.put("searchTitle", "STITLE");
		temp.put("searchContent", "CONTENT");
		temp.put("sortField", "RANK/DESC,RDATE/DESC");
		
		
		collectionInfo.put("home_magazine", temp);
		temp = null;
		//new homepage end
		
		return collectionInfo;
	}
}
