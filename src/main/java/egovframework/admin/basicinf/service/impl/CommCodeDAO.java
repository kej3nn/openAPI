package egovframework.admin.basicinf.service.impl;

import java.util.List;

import egovframework.admin.basicinf.service.CommMenuAcc;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.opendt.service.OpenCate;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 코드 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("CommCodeDAO")
public class CommCodeDAO extends EgovComAbstractDAO {

    /**
     * 조건에 맞는 공통코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectCommCodeAllList(CommCode commCode) throws DataAccessException, Exception {
        return (List<CommCode>) list("CommCodeDAO.selectCommCodeAllList", commCode);
    }

    /**
     * 조건에 맞는 공통코드 목록에 대한 전체 건수를 조회 한다.
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int selectCommCodeAllListCnt(CommCode CommCode) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommCodeDAO.selectCommCodeAllListCnt", CommCode);
    }

    /**
     * 공통코드를 단건 조회한다.
     *
     * @param CommCode
     * @return CommCode
     * @throws DataAccessException, Exception
     */
    public CommCode selectCommCodeOne(CommCode commCode) throws DataAccessException, Exception {
        return (CommCode) selectByPk("CommCodeDAO.selectCommCodeOne", commCode);
    }

    /**
     * 공통코드를 등록한다.
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int insertCommCode(CommCode commCode) throws DataAccessException, Exception {
        return (Integer) update("CommCodeDAO.insertCommCode", commCode);
    }

    /**
     * 공통코드를 변경한다.
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int updateCommCode(CommCode commCode) throws DataAccessException, Exception {
        return (Integer) update("CommCodeDAO.updateCommCode", commCode);
    }

    /**
     * 해당 공통코드가 그룹코드일 경우 하위 서브 코드들의 정보를 수정한다.
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int updateSubCommCode(CommCode commCode) throws DataAccessException, Exception {
        return (Integer) update("CommCodeDAO.updateSubCommCode", commCode);
    }

    /**
     * 공통코드 정보를 삭제한다.
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int deleteCommCode(CommCode CommCode) throws DataAccessException, Exception {
        return (Integer) update("CommCodeDAO.deleteCommCode", CommCode);
    }

    /**
     * 해당 공통코드가 그룹코드일 경우 하위 서브 코드들을 삭제한다.
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int deleteSubCommCode(CommCode CommCode) throws DataAccessException, Exception {
        return (Integer) update("CommCodeDAO.deleteSubCommCode", CommCode);
    }

    /**
     * 공통코드 중복을 체크한다.
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int selectCommCodeCheckDup(CommCode commCode) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommCodeDAO.selectCommCodeCheckDup", commCode);
    }

    /**
     * 공통코드 순서를 변경 한다.
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int updateOrderby(CommCode commCode) throws DataAccessException, Exception {
        return (Integer) update("CommCodeDAO.updateOrderby", commCode);
    }

    /**
     * 그룹 코드 목록을 조회 한다.(팝업)
     *
     * @param List<CommCode>
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectGrpcodeList(CommCode CommCode) throws DataAccessException, Exception {
        return (List<CommCode>) list("CommCodeDAO.selectGrpcodeList", CommCode);
    }

    /**
     * 그룹 코드 목록에 대한 전체 건수를 조회 한다.(팝업)
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int selectGrpcodeListCnt(CommCode CommCode) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommCodeDAO.selectGrpcodeListCnt", CommCode);
    }


    /**
     * 조건에 맞는 코드 목록을 조회 한다.(분류관리 등록시 표준맵핑 선택에 사용)
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectOpenCateDitcList(CommCode CommCode) throws DataAccessException, Exception {
        return (List<CommCode>) list("CommCodeDAO.selectOpenCateDitcList", CommCode);
    }

    /**
     * 조건에 맞는 코드 목록 대한 전체 건수를 조회 한다.(분류관리 등록시 표준맵핑 선택에 사용)
     *
     * @param CommCode
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int selectOpenCateDitcListCnt(CommCode CommCode) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommCodeDAO.selectOpenCateDitcListCnt", CommCode);
    }


}
