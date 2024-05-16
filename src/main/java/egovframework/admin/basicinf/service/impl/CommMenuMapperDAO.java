package egovframework.admin.basicinf.service.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommMenu;
import egovframework.admin.basicinf.service.CommUsr;

@Repository("commMenuMapperDAO")
public class CommMenuMapperDAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    /**
     * 관리자 상단 메뉴를 조회 한다.
     *
     * @param CommMenu
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommMenu> selectCommMenuList(CommUsr commUsr) throws DataAccessException, Exception {
        return sqlSession.selectList("CommMenuMapperDAO.selectCommMenuList", commUsr);
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
        return sqlSession.selectList("CommMenuMapperDAO.selectMenuList", commMenu);
    }

    /**
     * 전체 리스트 조회 건수
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectMenuListCnt(CommMenu commMenu) throws DataAccessException, Exception {
        return (Integer) sqlSession.selectOne("CommMenuMapperDAO.selectMenuListCnt", commMenu);
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
        return sqlSession.selectList("CommMenuMapperDAO.selectMenuListKeywd", commMenu);
    }

    /**
     * 키워드 조회 건수
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectMenuListKeywdCnt(CommMenu commMenu) throws DataAccessException, Exception {
        return (Integer) sqlSession.selectOne("CommMenuMapperDAO.selectMenuListKeywdCnt", commMenu);
    }

    /**
     * 단건 상세 조회
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public CommMenu selectMenuListInfo(CommMenu commMenu) throws DataAccessException, Exception {
        return (CommMenu) sqlSession.selectOne("CommMenuMapperDAO.selectMenuListInfo", commMenu);
    }

    /**
     * 메뉴 등록
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertMenu(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) sqlSession.update("CommMenuMapperDAO.insertMenu", saveVO);
    }

    /**
     * 메뉴 수정
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateMenu(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) sqlSession.update("CommMenuMapperDAO.updateMenu", saveVO);
    }

    /**
     * 메뉴 삭제
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteMenu(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) sqlSession.update("CommMenuMapperDAO.deleteMenu", saveVO);
    }

    /**
     * 메뉴아이디 조회(최대값+1)
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int getMenuId(CommMenu saveVO) throws DataAccessException, Exception {
        return (Integer) sqlSession.selectOne("CommMenuMapperDAO.getMenuId", saveVO);
    }

    /**
     * 하위 메뉴 조회
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public List selectCommLowMenuList(CommMenu commMenu) throws DataAccessException, Exception {
        return sqlSession.selectList("CommMenuMapperDAO.selectCommLowMenuList", commMenu);
    }

    /**
     * 하위 메뉴 조회 건수
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectCommLowMenuListCnt(CommMenu commMenu) throws DataAccessException, Exception {
        return (Integer) sqlSession.selectOne("CommMenuMapperDAO.selectCommLowMenuListCnt", commMenu);
    }

    /**
     * 메뉴정보 메뉴순서 수정
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int commMenuListUpdateTreeOrder(CommMenu commMenu) throws DataAccessException, Exception {
        return (Integer) sqlSession.update("CommMenuMapperDAO.commMenuListUpdateTreeOrder", commMenu);
    }
}
