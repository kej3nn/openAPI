/*
 * @(#)opnLogin.js 1.0 2019/07/22
 */

/**
 * 정보공개 > 실명인증 스크립트이다.
 *
 * @author SoftOn
 * @version 1.0 2021/06/09
 */
$(function () {
    // 컴포넌트를 초기화한다.
    initComp();
    // 이벤트를 바인딩한다.
    bindEvent();
    //웹접근성 조치 20.11.09
    $("title").text($(".contents-title-wrapper > h3").text() + " | " + $("title").text());
});


////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var origin = window.location.origin;
var userCd = $("#portalUserCd").val();
////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {

}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    // KCB 휴대폰 인증
    $("#btnKcb").bind("click", function (e) {
        e.preventDefault();
        // Kcb
        fnKcbPopup();
    });

    // KCB 아이핀 인증
    $("#btnIpin").bind("click", function (e) {
        e.preventDefault();
        // Kcb
        fnIpinPopup();
    });

    // KMC 휴대폰 인증
    $("#btnKmc").bind("click", function (e) {
        e.preventDefault();
        // Kmc
        fnKmcPopup("M");
    });

    // NICE 공동인증서 인증
    $("#btnNice").bind("click", function (e) {
        e.preventDefault();
        fnNicePopup();
    });
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
//KCB 휴대전화 인증
function fnKcbPopup() {
    $.ajax({
        type: "post",
        url: com.wise.help.url("/portal/expose/kcb/selectCertPlus.do"),
        data: {
            returnUrl: origin + "/portal/expose/kcb/certPlusResult.do"
        },
        success: function (data, status, request) {
            window.open(
                'about:blank',
                'popupChk',
                'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no'
            );
            $("form[name=form_chk]").find("input[name=cp_cd]").val(data.cpCd);
            $("form[name=form_chk]").find("input[name=mdl_tkn]").val(data.mdlToken);
            $("#form_chk").submit();
        },
        error: function (request, status, error) {
            alert("[본인인증] 처리도중 오류가 발생하였습니다.");
        }
    });
}

// KCB 아이핀 인증
function fnIpinPopup() {
    $.ajax({
        type: "post",
        url: com.wise.help.url("/portal/expose/kcb/selectIPin.do"),
        data: {
            returnUrl: origin + "/portal/expose/kcb/certIPinResult.do"
        },
        success: function (data, status, request) {
            //OpenWindow("", "popupIPIN", "450", "550", "yes");
            window.open(
                'about:blank',
                'popupIPIN',
                'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no'
            );
            $("form[name=form_ipin]").find("input[name=cpCd]").val(data.cpCd);
            $("form[name=form_ipin]").find("input[name=mdlTkn]").val(data.mdlToken);
            $("#form_ipin").submit();
        },
        error: function (request, status, error) {
            alert("[본인인증] 처리도중 오류가 발생하였습니다.");
        }
    });
}

//KMC 본인 인증
function fnKmcPopup(certMet) {
    $.ajax({
        type: "post",
        url: com.wise.help.url("/portal/expose/kmc/selectKmcCert.do"),
        data: {
            tr_url: origin + "/portal/expose/kmc/kmcCertResult.do",
            tr_add: "N",
            certMet: certMet
        },
        success: function (data, status, request) {
            window.open(
                'about:blank',
                'popupChk',
                'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no'
            );
            $("form[name=form_chk]").find("input[name=tr_cert]").val(data.tr_cert);
            $("form[name=form_chk]").find("input[name=tr_url]").val(data.tr_url);
            $("form[name=form_chk]").find("input[name=tr_add]").val(data.tr_add);
            $("#form_chk").submit();
        },
        error: function (request, status, error) {
            alert("[본인인증] 처리도중 오류가 발생하였습니다.");
        }
    });
}

// Nice 본인 인증(공동인증서)
// Edited by giinie on 2022-11-29
function fnNicePopup() {
    $.ajax({
        type: "post",
        url: com.wise.help.url("/portal/expose/nice/selectNiceCertPlus.do"),
        data: {
            sReturnUrl: origin + "/portal/expose/nice/niceCertPlusResult.do",
            sErrorUrl: origin
        },
        success: function (data) {
            window.open(
                'about:blank',
                'popupChk',
                'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no'
            );
            var $form = $("form[name=form_nice]");
            $form.find("input[name=EncodeData]").val(data.sencData);
            $form.submit();
        },
        error: function (request, status, error) {
            alert("[본인인증] 처리도중 오류가 발생하였습니다.");
        }
    });
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////

//실명인증 콜백 함수
function fnKcbCallBack(obj) {
    var url = $("form[name=form]").find("input[name=url]").val();

    if (!com.wise.util.isBlank(userCd)) {
        $.ajax({
            type: "post",
            url: com.wise.help.url("/portal/expose/updateUserRauth.do"),
            data: {
                portalUserCd: userCd
            },
            success: function (data, status, request) {
                location.href = com.wise.help.url(url);
            },
            error: function (request, status, error) {
                alert("[본인인증] 처리도중 오류가 발생하였습니다.");
            }
        });

    } else {
        location.href = com.wise.help.url(url);
    }
}
