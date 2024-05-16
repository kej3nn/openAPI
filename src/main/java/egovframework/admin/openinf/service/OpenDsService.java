package egovframework.admin.openinf.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

/**
 * @author hwang
 */
public interface OpenDsService {

    public Map<String, Object> selectOpenDsIbPaging(OpenDs openDs);


    public List<OpenDs> selectOpenDsDtl(OpenDs openDs);

    public Map<String, Object> selectOpenDsColIbPaging(OpenDscol openDscol);

    public Map<String, Object> selectOpenDsSrcColIbPaging(OpenDscol openDscol);

    public Map<String, Object> selectOpenDsPopIbPaging(OpenDs openDs);

    public Map<String, Object> selectBackDsPopIbPaging(OpenDs openDs);

    public Map<String, Object> selectOpenDtPopIbPaging(OpenDs openDs);

    public Map<String, Object> samplePopIbPaging(OpenDscol openDscol);

    public Map<String, Object> selectSamplePop(OpenDscol openDscol);

    public int saveOpenDsCUD(ArrayList<OpenDscol> list, OpenDscol saveVO);

    public int saveOpenDsDtlCUD(OpenDscol saveVO, String status);

    //	public int updateOpenDscolCUD(ArrayList<OpenDscol> list);
    public int saveOpenDscolCUD(ArrayList<OpenDscol> list);

    public int saveOpenDsTableListCUD(ArrayList<OpenDtbl> list);

    public int selectOpenCdCheck(OpenDscol saveVO);

    public int dupDsId(OpenDscol saveVO);

    /**
     * 관련 데이터셋 리스트 조회(공표기준등록 및 수정에서 사용)
     *
     * @param openDs
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> openPubCfgRefDsPopUpListIbPaging(OpenDs openDs);

    //재정용어 목록 조회
    public Map<String, Object> selectOpenDsTermPopListIbPaging(OpenDscol openDscol);

    public List<Map<String, Object>> selectOpenDscoltyCd();

    public Result saveOpenDsAll(Params params);

    public List<Record> selectOpenDsUsrList(Params params);

    public Map<String, Integer> selectExistSrcDsId(Params params);
}
