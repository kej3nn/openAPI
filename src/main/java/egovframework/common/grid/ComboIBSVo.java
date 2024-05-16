package egovframework.common.grid;

/**
 * ibsheet 콤보box 결과를 리턴하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public class ComboIBSVo {

    public String ComboText;    //콤보코드 텍스트
    public String ComboCode;    //콤보코드


    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("ComboIBSVo [ComboText=");
        builder.append(ComboText);
        builder.append(", ComboCode=");
        builder.append(ComboCode);
        builder.append("]");
        return builder.toString();
    }

}
