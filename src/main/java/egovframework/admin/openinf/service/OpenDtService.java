package egovframework.admin.openinf.service;

import java.util.ArrayList;
import java.util.Map;

public interface OpenDtService {

    public Map<String, Object> selectOpenDtIbPaging(OpenDt openDt);

    public OpenDt selectOpenDtDtl(OpenDt openDt);

    public Map<String, Object> selectOpenDtblIbPaging(OpenDtbl openDtbl);

    public Map<String, Object> selectopenDtSrcPopPopIbPaging(OpenDtbl openDtbl);

    //보유데이터 전체 저장
    public int saveOpenDtCUD(ArrayList<OpenDtbl> list, OpenDtbl saveVO);

    //보유데이터 상세정보 수정
    public int saveOpenDtDtlCUD(ArrayList<OpenDtbl> list);

    //보유데이터 데이터목록 수정
    public int updateOpenDtblCUD(ArrayList<OpenDtbl> list);

    //보유데이터 데이터목록 삭제
    public int deleteOpenDtblCUD(ArrayList<OpenDtbl> list);

    // OpenInf에서 사용중인지 확인
    public int getUseDtInf(OpenDtbl saveVO);


}
