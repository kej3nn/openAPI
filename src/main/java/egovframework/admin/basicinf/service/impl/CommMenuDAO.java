package egovframework.admin.basicinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommMenu;
import egovframework.admin.basicinf.service.CommUsr;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 메뉴 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("CommMenuDAO")
public class CommMenuDAO extends EgovComAbstractDAO {

    /**
     * 관리자 상단 메뉴를 조회 한다.
     *
     * @param CommMenu
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommMenu> selectCommMenuList(CommUsr commUsr) throws DataAccessException, Exception {
        return (List<CommMenu>) list("CommMenuDAO.selectCommMenuList", commUsr);
    }

    /**
     * 전체 리스트 조회
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommMenu> selectMenuList(CommMenu commMenu) throws DataAccessException, Exception {
        return (List<CommMenu>) list("CommMenuDAO.selectMenuList", commMenu);
    }

    /**
     * 전체 리스트 조회 건수
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectMenuListCnt(CommMenu commMenu) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommMenuDAO.selectMenuListCnt", commMenu);
    }

    /**
     * 키워드 조회
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommMenu> selectMenuListKeywd(CommMenu commMenu) throws DataAccessException, Exception {
        return (List<CommMenu>) list("CommMenuDAO.selectMenuListKeywd", commMenu);
    }

    /**
     * 키워드 조회 건수
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectMenuListKeywdCnt(CommMenu commMenu) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommMenuDAO.selectMenuListKeywdCnt", commMenu);
    }

    /**
     * 단건 상세 조회
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public CommMenu selectMenuListInfo(CommMenu commMenu) throws DataAccessException, Exception {
        return (CommMenu) selectByPk("CommMenuDAO.selectMenuListInfo", commMenu);
    }

    /**
     * 메뉴 등록
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertMenu(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) update("CommMenuDAO.insertMenu", saveVO);
    }

    /**
     * 메뉴 수정
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateMenu(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) update("CommMenuDAO.updateMenu", saveVO);
    }

    /**
     * 메뉴 삭제
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteMenu(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) update("CommMenuDAO.deleteMenu", saveVO);
    }

    /**
     * 메뉴아이디 조회(최대값+1)
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int getMenuId(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommMenuDAO.getMenuId", saveVO);
    }

    /**
     * 하위 메뉴 조회
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public List selectCommLowMenuList(CommMenu commMenu) throws DataAccessException, Exception {
        return list("CommMenuDAO.selectCommLowMenuList", commMenu);
    }

    /**
     * 하위 메뉴 조회 건수
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectCommLowMenuListCnt(CommMenu commMenu) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommMenuDAO.selectCommLowMenuListCnt", commMenu);
    }

    /**
     * 메뉴정보 메뉴순서 수정
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int commMenuListUpdateTreeOrder(CommMenu commMenu) throws DataAccessException, Exception {
        return (Integer) update("CommMenuDAO.commMenuListUpdateTreeOrder", commMenu);
    }

    /**
     * 메뉴 fullnm 업데이트
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateMenuFullnm(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) update("CommMenuDAO.updateMenuFullnm", saveVO);
    }


}

