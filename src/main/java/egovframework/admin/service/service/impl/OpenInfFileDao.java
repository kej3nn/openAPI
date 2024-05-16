package egovframework.admin.service.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value = "openInfFileDao")
public class OpenInfFileDao extends BaseDao {

    /**
     * 서비스 목록 조회
     */
    public Paging selectOpenInfSrvList(Params params, int page, int rows) {
        return search("OpenInfFile.selectOpenInfSrvList", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 서비스 파일 상세 조회
     */
    public Record selectOpenInfSrvDtl(Params params) {
        return (Record) select("OpenInfFile.selectOpenInfSrvDtl", params);
    }

    /**
     * 서비스 파일 목록 조회
     */
    public List<Record> selectOpenInfFileList(Params params) {
        return (List<Record>) list("OpenInfFile.selectOpenInfFileList", params);
    }

    /**
     * 서비스 파일 등록
     */
    public Object insertOpeninfFile(Params params) {
        return insert("OpenInfFile.insertOpeninfFile", params);
    }

    /**
     * 서비스 파일 수정
     */
    public Object updateOpeninfFile(Params params) {
        return insert("OpenInfFile.updateOpeninfFile", params);
    }

    /**
     * 서비스 파일 삭제
     */
    public Object deleteOpeninfFile(Params params) {
        return insert("OpenInfFile.deleteOpeninfFile", params);
    }

    /**
     * 서비스 파일 다운로드 데이터 조회
     */
    public Record selectOpenInfDownFile(Params params) {
        return (Record) select("OpenInfFile.selectOpenInfDownFile", params);
    }

    /**
     * 파일서비스 순서 저장
     */
    public Object saveOpenInfFileOrder(Params params) {
        return update("OpenInfFile.saveOpenInfFileOrder", params);
    }
}
