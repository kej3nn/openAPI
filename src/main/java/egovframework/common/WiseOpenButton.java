package egovframework.common;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.common.util.UtilString;
import egovframework.com.cmm.service.EgovProperties;

/**
 * 버튼관련
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class WiseOpenButton {
    protected static final Log logger = LogFactory.getLog(WiseOpenButton.class);

    private String btn_reg = "<button type='button' class='btn01' title='${btn_reg}' name='btn_reg'>${btn_reg}</button>";                            //등록
    private String a_reg = "<a href='javascript:;' class='btn03'  title='${btn_reg}' name='a_reg'>${btn_reg}</a>";                                //등록
    private String a_modify = "<a href='javascript:;' class='btn03'  title='${btn_modify}' name='a_modify'>${btn_modify}</a>";                        //수정
    private String a_vOrderSave = "<a href='javascript:;' class='btn03'  title='${btn_vOrderSave}' name='a_vOrderSave'>${btn_vOrderSave}</a>";            //순서저장
    private String a_save = "<a href='javascript:;' class='btn03'  title='${btn_save}' name='a_save'>${btn_save}</a>";                            //저장
    private String a_req = "<a href='javascript:;' class='btn02'  title='${btn_req}' name='a_req'>${btn_req}</a>";                                //요청
    private String btn_del = "<button type='button'  title='${btn_del}' class='btn03' name='btn_del'>${btn_del}</button>";                            //삭제
    private String a_del = "<a href='javascript:;' class='btn03'  title='${btn_del}' name='a_del'>${btn_del}</a>";                                //삭제
    private String a_appr = "<a href='javascript:;' class='btn02'  title='${btn_appr}' name='a_appr'>${btn_appr}</a>";                            //승인
    private String a_apprCancel = "<a href='javascript:;' class='btn02'  title='${btn_apprCancel}' name='a_apprCancel'>${btn_apprCancel}</a>";            //승인취소
    private String a_openState = "<a href='javascript:;' class='btn02'  title='${btn_openState}' name='a_openState'>${btn_openState}</a>";                        //공개
    private String a_openStateCancel = "<a href='javascript:;' class='btn02'  title='${btn_openStateCancel}' name='a_openStateCancel'>${btn_openStateCancel}</a>";        //공개취소
    private String a_infState = "<a href='javascript:;' class='btn02'  title='${btn_infState}' name='a_infState'>${btn_infState}</a>";                        //개방
    private String a_infStateCancel = "<a href='javascript:;' class='btn02'  title='${btn_infStateCancel}' name='a_infStateCancel'>${btn_infStateCancel}</a>";        //개방취소
    //***************************************************************
    //	▼▼▼▼▼▼▼▼▼▼ 권한이 필요없는 버튼들 ▼▼▼▼▼▼▼▼▼▼
    //***************************************************************
    private String a_up = "<a href='javascript:;' class='btn02'  title='${btn_up}' name='a_up'>${btn_up}</a>";                                            //아래로이동
    private String a_down = "<a href='javascript:;' class='btn02'  title='${btn_down}' name='a_down'>${btn_down}</a>";                                    //위로이동
    private String a_import = "<a href='#' class='btn02'  title='${btn_import}' name='a_import'>${btn_import}</a>";                                        //불러오기
    private String a_init = "<a href='javascript:;' class='btn02'  title='${btn_init}' name='a_init'>${btn_init}</a>";                                    //초기화
    private String btn_init = "<button type='button' class='btn01' title='${btn_init}' name='btn_init'>${btn_init}</button>";                            //초기화
    private String a_view = "<a href='#' class='btn02'  title='${btn_view}' name='a_view'>${btn_view}</a>";                                                //미리보기
    private String a_close = "<a href='#' class='btn02'  title='${btn_close}' name='a_close'>${btn_close}</a>";                                            //닫기
    private String btn_reSearch = "<button type='button'  title='${btn_reSearch}' class='btn01L' name='btn_reSearch'>${btn_reSearch}</button>";            //재검색
    private String a_dataSample = "<a href='#' class='btn02'  title='${btn_dataSample}' name='a_dataSample'>${btn_dataSample}</a>";                        //데이터샘플
    private String btn_inquiry = "<button type='button' class='btn01B' title='${btn_inquiry}' name='btn_inquiry'>${btn_inquiry}</button>";                //조회
    private String btn_search = "<button type='button' class='btn01' title='${btn_search}' name='btn_search'>${btn_search}</button>";                    //검색
    private String btn_dataSetDtl = "<button type='button' class='btn01L' title='${btn_dataSetDtl}' name='btn_dataSetDtl' >${btn_dataSetDtl}</button>";    //데이터셋상세
    private String btn_metaDtl = "<button type='button' class='btn01' title='${btn_metaDtl}' name='btn_metaDtl' >${btn_metaDtl}</button>";                //메타상세
    private String a_add = "<a href='#' class='btn03'  title='${btn_add}' name='a_add'>${btn_add}</a>";                                                    //추가
    private String btn_add = "<button type='button' class='btn06' title='${btn_add}' name='btn_add' >${btn_add}</button>";                                //추가
    private String btn_dup = "<button type='button' class='btn01' title='${btn_dup}' name='btn_dup' >${btn_dup}</button>";                                //중복체크
    private String par_del = "<button type='button' class='btn01'  title='${btn_del}' name='par_del'>${btn_del}</button>";                                //상위분류 초기화
    private String grp_del = "<button type='button' class='btn01'  title='${btn_del}' name='grp_del'>${btn_del}</button>";                                //그룹코드 초기화
    private String a_pubok = "<a href='#' class='btn03'  title='${btn_pubok}' name='a_pubok'>${btn_pubok}</a>";                                            //데이터샘플
    private String btn_xlsDown = "<button type='button' class='btn01' title='${btn_xlsDown}' name='btn_xlsDown' style='float:right'>${btn_xlsDown}</button>";                //엑셀다운
    private String btn_modAll = "<button type='button' class='btn01' title='${btn_modAll}' name='btn_modAll'>${btn_modAll}</button>";                    //일괄변경
    private String btn_printSave = "<button type='button' class='btn01' title='${btn_printSave}' name='btn_printSave' style='float:right'>${btn_printSave}</button>";                //출력 및 저장
    private String a_end = "<a href='#' class='btn03'  title='${btn_end}' name='btn_end'>${btn_end}</a>";                                                //마감
    private String a_endCancel = "<a href='#' class='btn03'  title='${btn_endCancel}' name='btn_endCancel'>${btn_endCancel}</a>";                        //마감취소
    private String a_usr = "<a href='#'  title='${a_usr}' class='btn02' name='a_usr'>${a_usr}</a>";                                                        //대상선택
    private String a_press = "<a href='#'  title='${a_press}' class='btn03' name='a_press'>${a_press}</a>";                                                //독촉

    /**
     * 버튼을 셋팅한다.
     */
    private void setbutton() {
        //등록
        a_reg = UtilString.replace(a_reg, "${btn_reg}", EgovProperties.getMessageProperty("btn.reg"));
        btn_reg = UtilString.replace(btn_reg, "${btn_reg}", EgovProperties.getMessageProperty("btn.reg"));
        //저장
        a_modify = UtilString.replace(a_modify, "${btn_modify}", EgovProperties.getMessageProperty("btn.modify"));
        a_save = UtilString.replace(a_save, "${btn_save}", EgovProperties.getMessageProperty("btn.save"));
        //순서저장
        a_vOrderSave = UtilString.replace(a_vOrderSave, "${btn_vOrderSave}", EgovProperties.getMessageProperty("btn.vOrderSave"));
        //삭제
        a_del = UtilString.replace(a_del, "${btn_del}", EgovProperties.getMessageProperty("btn.del"));
        btn_del = UtilString.replace(btn_del, "${btn_del}", EgovProperties.getMessageProperty("btn.del"));
        //승인
        a_appr = UtilString.replace(a_appr, "${btn_appr}", EgovProperties.getMessageProperty("btn.appr"));
        a_apprCancel = UtilString.replace(a_apprCancel, "${btn_apprCancel}", EgovProperties.getMessageProperty("btn.apprCancel"));
        //요청
        a_req = UtilString.replace(a_req, "${btn_req}", EgovProperties.getMessageProperty("btn.req"));
        //공개/공개취소
        a_openState = UtilString.replace(a_openState, "${btn_openState}", EgovProperties.getMessageProperty("btn.openState"));
        a_openStateCancel = UtilString.replace(a_openStateCancel, "${btn_openStateCancel}", EgovProperties.getMessageProperty("btn.openStateCancel"));
        //개방/개방취소
        a_infState = UtilString.replace(a_infState, "${btn_infState}", EgovProperties.getMessageProperty("btn.infState"));
        a_infStateCancel = UtilString.replace(a_infStateCancel, "${btn_infStateCancel}", EgovProperties.getMessageProperty("btn.infStateCancel"));

        //***************************************************************
        //	▼▼▼▼▼▼▼▼▼▼ 권한이 필요없는 버튼들 ▼▼▼▼▼▼▼▼▼▼
        //***************************************************************
        //조회
        btn_inquiry = UtilString.replace(btn_inquiry, "${btn_inquiry}", EgovProperties.getMessageProperty("btn.inquiry"));
        btn_search = UtilString.replace(btn_search, "${btn_search}", EgovProperties.getMessageProperty("btn.search"));
        //초기화
        btn_init = UtilString.replace(btn_init, "${btn_init}", EgovProperties.getMessageProperty("btn.init"));
        a_init = UtilString.replace(a_init, "${btn_init}", EgovProperties.getMessageProperty("btn.init"));
        a_up = UtilString.replace(a_up, "${btn_up}", EgovProperties.getMessageProperty("btn.up"));
        a_down = UtilString.replace(a_down, "${btn_down}", EgovProperties.getMessageProperty("btn.down"));
        a_import = UtilString.replace(a_import, "${btn_import}", EgovProperties.getMessageProperty("btn.import"));
        a_view = UtilString.replace(a_view, "${btn_view}", EgovProperties.getMessageProperty("btn.view"));
        a_close = UtilString.replace(a_close, "${btn_close}", EgovProperties.getMessageProperty("btn.close"));
        btn_reSearch = UtilString.replace(btn_reSearch, "${btn_reSearch}", EgovProperties.getMessageProperty("btn.reSearch"));
        a_dataSample = UtilString.replace(a_dataSample, "${btn_dataSample}", EgovProperties.getMessageProperty("btn.dataSample"));
        btn_dataSetDtl = UtilString.replace(btn_dataSetDtl, "${btn_dataSetDtl}", EgovProperties.getMessageProperty("btn.dataSetDtl"));
        btn_metaDtl = UtilString.replace(btn_metaDtl, "${btn_metaDtl}", EgovProperties.getMessageProperty("btn.metaDtl"));
        a_add = UtilString.replace(a_add, "${btn_add}", EgovProperties.getMessageProperty("btn.add"));
        btn_add = UtilString.replace(btn_add, "${btn_add}", EgovProperties.getMessageProperty("btn.add"));
        btn_dup = UtilString.replace(btn_dup, "${btn_dup}", EgovProperties.getMessageProperty("btn.dup"));
        par_del = UtilString.replace(par_del, "${btn_del}", EgovProperties.getMessageProperty("par.del"));//상위분류 초기화
        grp_del = UtilString.replace(grp_del, "${btn_del}", EgovProperties.getMessageProperty("grp.del"));//그룹코드 초기화
        a_pubok = UtilString.replace(a_pubok, "${btn_pubok}", EgovProperties.getMessageProperty("btn.pubok"));
        btn_xlsDown = UtilString.replace(btn_xlsDown, "${btn_xlsDown}", EgovProperties.getMessageProperty("btn.xlsDown"));
        btn_modAll = UtilString.replace(btn_modAll, "${btn_modAll}", EgovProperties.getMessageProperty("labal.changeAll")); //일괄변경
        btn_printSave = UtilString.replace(btn_printSave, "${btn_printSave}", EgovProperties.getMessageProperty("btn.printSave"));
        a_end = UtilString.replace(a_end, "${btn_end}", EgovProperties.getMessageProperty("btn.end"));    //마감
        a_endCancel = UtilString.replace(a_endCancel, "${btn_endCancel}", EgovProperties.getMessageProperty("btn.endCancel"));    //마감
        a_usr = UtilString.replace(a_usr, "${a_usr}", EgovProperties.getMessageProperty("btn.usr"));    //대상선택
        a_press = UtilString.replace(a_press, "${a_press}", EgovProperties.getMessageProperty("btn.press"));    //독촉
    }

    /**
     * 권한 코드별로 버튼을 셋팅한다.
     *
     * @param menuAcc
     */
    public void setAcc(int menuAcc) {
        //SetColProperty("menuAcc", {ComboCode:"0|10|20|40|50|90", ComboText:"없음|조회/다운로드|등록/수정|승인|삭제|ALL"});
        setbutton();
        logger.debug("MenuAcc : " + menuAcc);
        switch (menuAcc) {
            case 20:        //데이터등록
                this.a_modify = "";
                this.a_save = "";
                this.a_vOrderSave = "";
                this.a_appr = "";
                this.a_openState = "";
                this.a_openStateCancel = "";
                this.a_infState = "";
                this.a_infStateCancel = "";
                this.btn_del = "";
                this.a_del = "";
                break;
            case 30:        //데이터조회/수정
                this.a_appr = "";
                this.a_openState = "";
                this.a_openStateCancel = "";
                this.a_infState = "";
                this.a_infStateCancel = "";
                this.a_del = "";
                this.btn_del = "";
                break;
            case 40:        //데이터조회, 수정, 승인
                this.btn_del = "";
                this.a_del = "";
                break;
            case 50:        //데이터조회, 수정, 승인, 삭제
                break;
            default:
                this.a_reg = "";
                this.a_del = "";
                this.btn_reg = "";
                this.a_modify = "";
                this.a_up = "";
                this.a_down = "";
                this.a_import = "";
                this.a_req = "";
                this.a_init = "";
                this.a_appr = "";
                this.a_apprCancel = "";
                this.btn_del = "";
                this.a_save = "";
                this.btn_modAll = "";
                this.a_end = "";
                this.a_endCancel = "";
                this.a_usr = "";
                this.a_press = "";
        }
    }

    public String getBtn_reg() {
        return btn_reg;
    }

    public void setBtn_reg(String btn_reg) {
        this.btn_reg = btn_reg;
    }

    public String getA_modify() {
        return a_modify;
    }

    public void setA_modify(String a_modify) {
        this.a_modify = a_modify;
    }

    public String getA_up() {
        return a_up;
    }

    public void setA_up(String a_up) {
        this.a_up = a_up;
    }

    public String getA_down() {
        return a_down;
    }

    public void setA_down(String a_down) {
        this.a_down = a_down;
    }

    public String getA_import() {
        return a_import;
    }

    public void setA_import(String a_import) {
        this.a_import = a_import;
    }

    public String getA_req() {
        return a_req;
    }

    public void setA_req(String a_req) {
        this.a_req = a_req;
    }

    public String getA_appr() {
        return a_appr;
    }

    public void setA_appr(String a_appr) {
        this.a_appr = a_appr;
    }

    public String getBtn_del() {
        return btn_del;
    }

    public void setBtn_del(String btn_del) {
        this.btn_del = btn_del;
    }

    public String getA_reg() {
        return a_reg;
    }

    public void setA_reg(String a_reg) {
        this.a_reg = a_reg;
    }

    public String getA_view() {
        return a_view;
    }

    public void setA_view(String a_view) {
        this.a_view = a_view;
    }

    public String getA_save() {
        return a_save;
    }

    public void setA_save(String a_save) {
        this.a_save = a_save;
    }

    public String getA_close() {
        return a_close;
    }

    public void setA_close(String a_close) {
        this.a_close = a_close;
    }

    public String getA_del() {
        return a_del;
    }

    public void setA_del(String a_del) {
        this.a_del = a_del;
    }

    public String getBtn_reSearch() {
        return btn_reSearch;
    }

    public void setBtn_reSearch(String btn_reSearch) {
        this.btn_reSearch = btn_reSearch;
    }

    public String getA_dataSample() {
        return a_dataSample;
    }

    public void setA_dataSample(String a_dataSample) {
        this.a_dataSample = a_dataSample;
    }

    public String getBtn_inquiry() {
        return btn_inquiry;
    }

    public void setBtn_inquiry(String btn_inquiry) {
        this.btn_inquiry = btn_inquiry;
    }

    public String getBtn_search() {
        return btn_search;
    }

    public void setBtn_search(String btn_search) {
        this.btn_search = btn_search;
    }

    public String getBtn_dataSetDtl() {
        return btn_dataSetDtl;
    }

    public void setBtn_dataSetDtl(String btn_dataSetDtl) {
        this.btn_dataSetDtl = btn_dataSetDtl;
    }

    public String getBtn_metaDtl() {
        return btn_metaDtl;
    }

    public void setBtn_metaDtl(String btn_metaDtl) {
        this.btn_metaDtl = btn_metaDtl;
    }

    public String getA_add() {
        return a_add;
    }

    public void setA_add(String a_add) {
        this.a_add = a_add;
    }

    public String getBtn_add() {
        return btn_add;
    }

    public void setBtn_add(String btn_add) {
        this.btn_add = btn_add;
    }

    public String getBtn_dup() {
        return btn_dup;
    }

    public void setBtn_dup(String btn_dup) {
        this.btn_dup = btn_dup;
    }

    public String getA_apprCancel() {
        return a_apprCancel;
    }

    public void setA_apprCancel(String a_apprCancel) {
        this.a_apprCancel = a_apprCancel;
    }

    public String getPar_del() {
        return par_del;
    }

    public void setPar_del(String par_del) {
        this.par_del = par_del;
    }

    public String getGrp_del() {
        return grp_del;
    }

    public void setGrp_del(String grp_del) {
        this.grp_del = grp_del;
    }

    public String getA_pubok() {
        return a_pubok;
    }

    public void setA_pubok(String a_pubok) {
        this.a_pubok = a_pubok;
    }

    public String getA_init() {
        return a_init;
    }

    public void setA_init(String a_init) {
        this.a_init = a_init;
    }

    public String getBtn_init() {
        return btn_init;
    }

    public void setBtn_init(String btn_init) {
        this.btn_init = btn_init;
    }

    public String getBtn_xlsDown() {
        return btn_xlsDown;
    }

    public void setBtn_xlsDown(String btn_xlsDown) {
        this.btn_xlsDown = btn_xlsDown;
    }

    public String getBtn_modAll() {
        return btn_modAll;
    }

    public void setBtn_modAll(String btn_modAll) {
        this.btn_modAll = btn_modAll;
    }

    public String getBtn_printSave() {
        return btn_printSave;
    }

    public void setBtn_printSave(String btn_printSave) {
        this.btn_printSave = btn_printSave;
    }

    public String getA_end() {
        return a_end;
    }

    public void setA_end(String a_end) {
        this.a_end = a_end;
    }

    public String getA_endCancel() {
        return a_endCancel;
    }

    public void setA_endCancel(String a_endCancel) {
        this.a_endCancel = a_endCancel;
    }

    public String getA_usr() {
        return a_usr;
    }

    public void setA_usr(String a_usr) {
        this.a_usr = a_usr;
    }

    public String getA_press() {
        return a_press;
    }

    public void setA_press(String a_press) {
        this.a_press = a_press;
    }

    public String getA_vOrderSave() {
        return a_vOrderSave;
    }

    public void setA_vOrderSave(String a_vOrderSave) {
        this.a_vOrderSave = a_vOrderSave;
    }

    public String getA_openState() {
        return a_openState;
    }

    public void setA_openState(String a_openState) {
        this.a_openState = a_openState;
    }

    public String getA_openStateCancel() {
        return a_openStateCancel;
    }

    public void setA_openStateCancel(String a_openStateCancel) {
        this.a_openStateCancel = a_openStateCancel;
    }

    public String getA_infState() {
        return a_infState;
    }

    public void setA_infState(String a_infState) {
        this.a_infState = a_infState;
    }

    public String getA_infStateCancel() {
        return a_infStateCancel;
    }

    public void setA_infStateCancel(String a_infStateCancel) {
        this.a_infStateCancel = a_infStateCancel;
    }

}
