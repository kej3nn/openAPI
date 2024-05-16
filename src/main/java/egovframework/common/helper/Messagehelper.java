
package egovframework.common.helper;

import egovframework.com.cmm.EgovMessageSource;

/**
 * 메세지를 관리하하는 Class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class Messagehelper {
    EgovMessageSource message;

    /**
     * 메세지를 셋팅한다.
     *
     * @param message
     */
    public void setEgovMessageSource(EgovMessageSource message) {
        this.message = message;
    }

    /**
     * 저장시 메세지를 리턴한다
     *
     * @param result
     * @return
     */
    public String getSavaMessage(int result) {
        if (result > 0) { //코드값으로...
            return message.getMessage("MSG.SAVE");
        } else if (result == -1) {
            return message.getMessage("DUP.SAVE");
        } else if (result == -10) {
            return message.getMessage("MSG.MSG.10");
        } else {
            return message.getMessage("ERR.SAVE");
        }
    }

    /**
     * 저장시 메세지를 리턴한다.
     *
     * @param result
     * @param msg
     * @return
     */
    public String getSavaMessage2(int result, String msg) {
        if (result > 0) { //코드값으로...
            return msg;
        } else if (result == -1) {
            return message.getMessage("DUP.SAVE");
        } else {
            return message.getMessage("ERR.SAVE");
        }
    }


    /**
     * 변경시 메세지를 리턴한다.
     *
     * @param result
     * @return
     */
    public String getUpdateMessage(int result) {
        if (result > 0) { //코드값으로...
            return message.getMessage("MSG.UPD");
        } else if (result == -1) {
            return message.getMessage("DUP.SAVE");
        } else {
            return message.getMessage("ERR.SAVE");
        }
    }

    /**
     * 삭제시 메세지를 리턴한다.
     *
     * @param result
     * @return
     */
    public String getDeleteMessage(int result) {
        if (result > 0) { //코드값으로...
            return message.getMessage("MSG.DEL");
        } else if (result == -1) {
            return message.getMessage("DUP.SAVE");
        } else {
            return message.getMessage("ERR.SAVE");
        }
    }
}
