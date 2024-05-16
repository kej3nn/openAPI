package egovframework.common.helper;


/**
 * ibsheet 리스트를 리턴하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public class TABListVo<T> {

    public Object DATA;
    public Object DATA2;

    public TABListVo() {
    }

    public TABListVo(Object data) {
        this.DATA = data;
    }

    public TABListVo(Object data, Object data2) {
        this.DATA = data;
        this.DATA2 = data2;
    }

}
