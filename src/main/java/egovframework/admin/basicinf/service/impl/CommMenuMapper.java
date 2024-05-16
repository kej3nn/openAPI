package egovframework.admin.basicinf.service.impl;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.basicinf.service.CommMenu;
import egovframework.admin.basicinf.service.CommOrg;
import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.openinf.service.OpenDs;
import egovframework.admin.openinf.service.OpenDscol;
import egovframework.admin.openinf.service.OpenDtbl;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Mapper("commMenuMapper")
public interface CommMenuMapper {
    /**
     * 관리자 상단 메뉴를 조회 한다.
     *
     * @param CommMenu
     * @return
     * @throws Exception
     */
    List<CommMenu> selectCommMenuList(CommUsr commUsr);

    /**
     * 전체 리스트 조회
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    List<CommMenu> selectMenuList(CommMenu commMenu);

    /**
     * 전체 리스트 조회 건수
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    public int selectMenuListCnt(CommMenu commMenu);

    /**
     * 키워드 조회
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommMenu> selectMenuListKeywd(CommMenu commMenu);

    /**
     * 키워드 조회 건수
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    public int selectMenuListKeywdCnt(CommMenu commMenu);

    /**
     * 단건 상세 조회
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    public CommMenu selectMenuListInfo(CommMenu commMenu);

    /**
     * 메뉴 등록
     *
     * @param saveVO
     * @return
     * @throws Exception
     */
    public int insertMenu(CommMenu saveVO);

    /**
     * 메뉴 수정
     *
     * @param saveVO
     * @return
     * @throws Exception
     */
    public int updateMenu(CommMenu saveVO);

    /**
     * 메뉴 삭제
     *
     * @param saveVO
     * @return
     * @throws Exception
     */
    public int deleteMenu(CommMenu saveVO);

    /**
     * 메뉴아이디 조회(최대값+1)
     *
     * @param saveVO
     * @return
     * @throws Exception
     */
    public int getMenuId(CommMenu saveVO);

    /**
     * 하위 메뉴 조회
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    public List selectCommLowMenuList(CommMenu commMenu);

    /**
     * 하위 메뉴 조회 건수
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    public int selectCommLowMenuListCnt(CommMenu commMenu);

    /**
     * 메뉴정보 메뉴순서 수정
     *
     * @param commMenu
     * @return
     * @throws Exception
     */
    public int commMenuListUpdateTreeOrder(CommMenu commMenu);
}
