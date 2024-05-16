package egovframework.common.util;

import egovframework.common.WiseOpenConfig;

/**
 * 페이징 관련 class
 *
 * @author cheon
 */
public class PagingView {

    private int totalRows = 0;
    private int currentPage = 0;
    private int pageSize = 0;
    private int blockSize = WiseOpenConfig.PAGE_BLOCK;
    private int totalPages = 0;
    private int totalBlocks = 0;
    private int startPageNum = 0;
    private int endPageNum = 0;
    private int currentBlock = 0;

    public String firstLink = "";
    public String firstOffLink = "";
    public String prevLink = "";
    public String prevOffLink = "";
    public String nextLink = "";
    public String nextOffLink = "";
    public String lastLink = "";
    public String lastOffLink = "";
    public String queryString = "";
    public String delimiter = "";
    public String gubun = "";
    public String fileListYn = "";

    public StringBuffer pageString = new StringBuffer();

    //Pagesize가 없는 경우
    public PagingView(int currentPage, int totalRows, String gubun) {
        this.currentPage = currentPage;
        this.totalRows = totalRows;
        this.gubun = gubun;
        initialize();
    }

    //Pagesize 지정시
    public PagingView(int currentPage, int totalRows, String gubun, int pageSize) {
        this.currentPage = currentPage;
        this.totalRows = totalRows;
        this.gubun = gubun;
        this.pageSize = pageSize;
        initialize();
    }

    //Pagesize 지정시
    public PagingView(int currentPage, int totalRows, String gubun, int pageSize, String fileListYn) {
        this.currentPage = currentPage;
        this.totalRows = totalRows;
        this.gubun = gubun;
        this.pageSize = pageSize;
        this.fileListYn = fileListYn;
        initialize();
    }

    public void initialize() {
        //set num
        if (pageSize == 0) {
            this.pageSize = WiseOpenConfig.PAGE_SIZE;
        }
        this.totalPages = (int) Math.ceil((double) this.totalRows / this.pageSize);        //전체 행 / 페이지 사이즈
        this.totalBlocks = (int) Math.ceil((double) this.totalPages / this.blockSize);    //전체 행 / 블록사이즈
        this.currentBlock = (int) Math.ceil((double) ((this.currentPage - 1) / this.blockSize)) + 1;
        this.startPageNum = ((this.currentBlock - 1) * this.blockSize) + 1;
        this.endPageNum = this.startPageNum + this.blockSize > this.totalPages ? this.totalPages - ((this.startPageNum + this.blockSize) - this.totalPages) : this.startPageNum + this.blockSize;
        //set String
        if (this.fileListYn.equals("Y")) {// 파일 리스트 테이블이 하나더 있어서 페이징 로직이 하나더 추가되는 경우에 사용 ex)PortalBbsListController.259 line
            this.firstLink = "first";
            this.firstOffLink = "<li><a href='#' class='page-prev2' onclick=\"javascript:goPageFile" + this.gubun + "('1'); return false;\">&lt;&lt;</a></li>\n";
            this.prevLink = "prev";
            this.prevOffLink = "<li><a href='#' class='page-prev' onclick=\"javascript:goPageFile" + this.gubun + "('1'); return false;\">&lt;</a></li>\n";
            this.nextLink = "next";
            this.nextOffLink = "<li><a href='#' class='page-next' onclick=\"javascript:goPageFile" + this.gubun + "(" + (this.blockSize + 1) + "); return false;\">&gt;</a></li>\n";
            this.lastLink = "last";
            this.lastOffLink = "<li><a href='#' class='page-next2' onclick=\"javascript:goPageFile" + this.gubun + "('1'); return false;\">&gt;&gt;</a></li>\n";
        } else {
            this.firstLink = "first";
            this.firstOffLink = "<li><a href='#' class='page-prev2' onclick=\"javascript:goPage" + this.gubun + "('1'); return false;\">&lt;&lt;</a></li>\n";
            this.prevLink = "prev";
            this.prevOffLink = "<li><a href='#' class='page-prev' onclick=\"javascript:goPage" + this.gubun + "('1'); return false;\">&lt;</a></li>\n";
            this.nextLink = "next";
            this.nextOffLink = "<li><a href='#' class='page-next' onclick=\"javascript:goPage" + this.gubun + "(" + (this.blockSize + 1) + "); return false;\">&gt;</a></li>\n";
            this.lastLink = "last";
            this.lastOffLink = "<li><a href='#' class='page-next2' onclick=\"javascript:goPage" + this.gubun + "('1'); return false;\">&gt;&gt;</a></li>\n";
        }

    }

    //처음으로, 이전 세팅
    public void prePrint() {
        //set first
        pageString.append("<li><a href='#' class='page-prev2' onclick=\"goPage" + this.gubun + "('1'); return false;\">" + this.firstLink + "</a></li>\n");

        //set prev block
        if (this.currentBlock > 1) {
            pageString.append("<li><a href='#' class='page-prev' onclick=\"goPage" + this.gubun + "('" + (((this.currentBlock - 2) * this.blockSize) + this.blockSize) + "'); return false;\">" + this.prevLink + " </a></li>\n");
        } else {
            //setGubun(gubun);
            pageString.append(this.prevOffLink);
        }
    }

    //다음, 마지막으로 세팅
    public void postPrint() {
        //set next block
        if (this.currentBlock == this.totalBlocks) {
            pageString.append("<li><a href='#' class='page-next' onclick=\"goPage" + this.gubun + "('" + this.totalPages + "'); return false;\">" + this.nextLink + " </a></li>\n");
        } else if (this.currentBlock > 1) {
            pageString.append("<li><a href='#' class='page-next' onclick=\"goPage" + this.gubun + "('" + (((this.currentBlock - 1) * this.blockSize) + this.blockSize + 1) + "'); return false;\">" + this.nextLink + " </a></li>\n");
        } else {
            pageString.append(this.nextOffLink);
        }

        //set last
        pageString.append("<li><a href='#' class='page-next2' onclick=\"goPage" + this.gubun + "('" + this.totalPages + "'); return false;\">" + this.lastLink + " </a></li>\n");
    }

    //리스트..
    public void printList() {
        int startPageNum = this.startPageNum;
        int listMod = this.totalPages % this.blockSize;            //리스트 블록 갯수 나머지 값
        int listPageNum = this.currentPage % this.blockSize;    //블록 내 리스트 페이지 번호
        boolean bLastPage = this.currentPage == this.totalPages ? true : false;    //마지막 페이지 여부
        int surplusNum = 0;
        if (listMod == 0) {        //나누어 떨어질 경우
            surplusNum = this.blockSize + 1;
        } else {
            surplusNum = listMod + 1;
        }
        if (this.totalBlocks == this.currentBlock) {        //블록이 처음이거나 마지막일경우 리스트 출력
            for (int i = 1; i < surplusNum; i++) {
                if (i == listPageNum) {
                    pageString.append("<li><a href='#' class='on' onclick=\"goPage" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                } else if (listMod == 0) {        //나누어 떨어질 경우 마지막 페이지는 선택되어지도록
                    if (i == listPageNum) {
                        pageString.append("<li><a href='#' class='on' onclick=\"goPage" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                    } else {
                        if (i == this.blockSize && bLastPage == true) {    //마지막 페이지를 선택했을 경우 on
                            pageString.append("<li><a href='#' class='on' onclick=\"goPage" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                        } else {
                            pageString.append("<li><a href='#' onclick=\"goPage" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                        }
                    }
                } else {
                    pageString.append("<li><a href='#' onclick=\"goPage" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                }

                startPageNum++;
            }
        } else {                                            //블록이 중간일경우
            for (int i = startPageNum; i <= endPageNum; i++) {
                if (i > this.totalRows || i == endPageNum) {
                    break;
                } else if (i > startPageNum) {
                    pageString.append(this.delimiter);
                }

                if (i == this.currentPage)
                    pageString.append("<li><a href='#' class='on' onclick=\"goPage" + this.gubun + "('" + i + "'); return false;\">" + i + "</a></li>\n");
                else
                    pageString.append("<li><a href='#' onclick=\"goPage" + this.gubun + "('" + i + "'); return false;\">" + i + "</a></li>\n");
            }
        }
    }

    //처음으로, 이전 세팅
    public void preFilePrint() {
        //set first
        pageString.append("<li><a href='#' class='page-prev2' onclick=\"goPageFile" + this.gubun + "('1'); return false;\">" + this.firstLink + "</a></li>\n");

        //set prev block
        if (this.currentBlock > 1) {
            pageString.append("<li><a href='#' class='page-prev' onclick=\"goPageFile" + this.gubun + "('" + (((this.currentBlock - 2) * this.blockSize) + this.blockSize) + "'); return false;\">" + this.prevLink + " </a></li>\n");
        } else {
            //setGubun(gubun);
            pageString.append(this.prevOffLink);
        }
    }

    //다음, 마지막으로 세팅
    public void postFilePrint() {
        //set next block
        if (this.currentBlock == this.totalBlocks) {
            pageString.append("<li><a href='#' class='page-next' onclick=\"goPageFile" + this.gubun + "('" + this.totalPages + "'); return false;\">" + this.nextLink + " </a></li>\n");
        } else if (this.currentBlock > 1) {
            pageString.append("<li><a href='#' class='page-next' onclick=\"goPageFile" + this.gubun + "('" + (((this.currentBlock - 1) * this.blockSize) + this.blockSize + 1) + "'); return false;\">" + this.nextLink + " </a></li>\n");
        } else {
            pageString.append(this.nextOffLink);
        }

        //set last
        pageString.append("<li><a href='#' class='page-next2' onclick=\"goPageFile" + this.gubun + "('" + this.totalPages + "'); return false;\">" + this.lastLink + " </a></li>\n");
    }

    //리스트..
    public void printFileList() {

        int startPageNum = this.startPageNum;
        int listMod = this.totalPages % this.blockSize;            //리스트 블록 갯수 나머지 값
        int listPageNum = this.currentPage % this.blockSize;    //블록 내 리스트 페이지 번호
        boolean bLastPage = this.currentPage == this.totalPages ? true : false;    //마지막 페이지 여부
        int surplusNum = 0;
        if (listMod == 0) {        //나누어 떨어질 경우
            surplusNum = this.blockSize + 1;
        } else {
            surplusNum = listMod + 1;
        }
        if (this.totalBlocks == this.currentBlock) {        //블록이 처음이거나 마지막일경우 리스트 출력
            for (int i = 1; i < surplusNum; i++) {
                if (i == listPageNum) {
                    pageString.append("<li><a href='#' class='on' onclick=\"goPageFile" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                } else if (listMod == 0) {        //나누어 떨어질 경우 마지막 페이지는 선택되어지도록
                    if (i == listPageNum) {
                        pageString.append("<li><a href='#' class='on' onclick=\"goPageFile" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                    } else {
                        if (i == this.blockSize && bLastPage == true) {    //마지막 페이지를 선택했을 경우 on
                            pageString.append("<li><a href='#' class='on' onclick=\"goPageFile" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                        } else {
                            pageString.append("<li><a href='#' onclick=\"goPageFile" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                        }
                    }
                } else {
                    pageString.append("<li><a href='#' onclick=\"goPageFile" + this.gubun + "('" + startPageNum + "'); return false;\">" + startPageNum + "</a></li>\n");
                }

                startPageNum++;
            }
        } else {                                            //블록이 중간일경우
            for (int i = startPageNum; i <= endPageNum; i++) {
                if (i > this.totalRows || i == endPageNum) {
                    break;
                } else if (i > startPageNum) {
                    pageString.append(this.delimiter);
                }

                if (i == this.currentPage)
                    pageString.append("<li><a href='#' class='on' onclick=\"goPageFile" + this.gubun + "('" + i + "'); return false;\">" + i + "</a></li>\n");
                else
                    pageString.append("<li><a href='#' onclick=\"goPageFile" + this.gubun + "('" + i + "'); return false;\">" + i + "</a></li>\n");
            }
        }
    }


    public String print() {
        if (this.fileListYn.equals("Y")) {
            this.preFilePrint();
            this.printFileList();
            this.postFilePrint();
        } else {
            this.prePrint();
            this.printList();
            this.postPrint();
        }
        return (pageString.toString());
    }

}
