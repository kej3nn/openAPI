package egovframework.admin.bbs.service;

import java.util.ArrayList;
import java.util.Map;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.file.service.FileVo;


public interface BbsListService {

    public Map<String, Object> selectBbsListIbPaging(BbsList bbsList);

    public Map<String, Object> selectBbsAdminInfo(BbsList bbsList);

    public String selectBbsTypeCd(BbsList bbsList);

    public BbsAdmin selectBbsDitcCd(BbsList bbsList);

    public String selectDelYn(BbsList bbsList);

    public BbsList selectBbsDtlList(BbsList bbsList);

    public Map<String, Object> selectBbsinfPopIbPaging(BbsList bbsList);

    public Map<String, Object> selectBbsLinkListIbPaging(BbsList bbsList);

    public Map<String, Object> selectBbsInfListIbPaging(BbsList bbsList);

    public Map<String, Object> selectBbsFileListIbPaging(BbsList bbsList);

    public Map<String, Object> bbsImgDetailView(BbsList bbsList);

    public int saveBbsDtlListCUD(BbsList saveVO, String status);

    public int updateTopYn(BbsList saveVO, String status);

    public int deleteImg(BbsList saveVO, String status);

    public int updateAnsStateCUD(BbsList saveVO);

    public int saveBbsLinkListCUD(ArrayList<BbsList> list);

    public int deleteBbsLinkListCUD(ArrayList<BbsList> list);

    public int saveBbsInfListCUD(ArrayList<BbsList> list);

    public int updateDeleteImgCUD(BbsList saveVO);

    public int deleteImgDtlCUD(BbsList saveVO);

    public int deleteBbsInfListCUD(ArrayList<BbsList> list);

    public int deleteBbsFileListCUD(ArrayList<BbsList> list);

    public int saveBbsFileListCUD(BbsList bbsList, ArrayList<?> list, FileVo fileVo);

    // 게시판에 첨부될 파일의 Directory경로 중간에 bbsCd를 넣어주기 위해 bbsCd를 가지고 오는 logic
    public String getBbsCd(int seq);


    public Map<String, Object> selectBbsTblIbPaging(BbsList bbsList);

    public Map<String, Object> selectSttsTblPopIbPaging(BbsList bbsList);

    public int bbsTblCUD(ArrayList<BbsList> list, String gubun);

    public Record selectGalleryPop(Params params);


}
