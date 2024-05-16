-- ASIS: 재정정보를 활용하여 제작한 앱, 웹사이트, 행사 등을 공유해 주세요.<br/> 담당자의 확인을 거쳐 국민들 누구나 다양하게 활용할 수 있습니다.
-- ASIS: 10
UPDATE TB_BBS_ADMIN SET
    BBS_EXP = '당신이 만든 앱이나 홈페이지를 공유하세요.<br />담당자의 확인을 거쳐 대중에 공개됩니다.',
    LIST_CNT = 8
WHERE BBS_CD = 'GALLERY';

/*
INSERT INTO TB_BBS_ADMIN (
    BBS_CD, BBS_NM, LANG_CD, BBS_TYPE_CD, BBS_OPEN_DTTM, BBS_CLOSE_DTTM, BBS_EXP, USE_YN,
    LOGIN_WT_YN, LIST_CNT, HL_CNT, LIST_CD, NOTICE_YN, SECRET_YN, ATFILE_YN, EXT_LIMIT,
    SIZE_LIMIT, LINK_YN, INF_YN, DEPT_YN, EMAIL_REG_YN, EMAIL_NEED_YN, TEL_YN, TEL_NEED_YN,
    ANS_YN, ANS_TAG, HTML_YN, REG_ID, REG_DTTM, UPD_ID, UPD_DTTM
) VALUES (
    'IDEA', '아이디어 제안', 'LADE01', 'G001', NULL, NULL, '아이디어 제안 게시판 입니다.', 'Y',
    'Y', 20, 100, 'B1009', 'N', 'Y', 'Y', 'BOTH',
    5, 'N', 'N', 'N', 'N', 'N', 'N', 'N',
    'N', 'N', 'Y', NULL, SYSDATE, NULL, NULL
);
*/

/*
INSERT INTO TB_BBS_ADMIN (
    BBS_CD, BBS_NM, LANG_CD, BBS_TYPE_CD, BBS_OPEN_DTTM, BBS_CLOSE_DTTM, BBS_EXP, USE_YN,
    LOGIN_WT_YN, LIST_CNT, HL_CNT, LIST_CD, NOTICE_YN, SECRET_YN, ATFILE_YN, EXT_LIMIT,
    SIZE_LIMIT, LINK_YN, INF_YN, DEPT_YN, EMAIL_REG_YN, EMAIL_NEED_YN, TEL_YN, TEL_NEED_YN,
    ANS_YN, ANS_TAG, HTML_YN, REG_ID, REG_DTTM, UPD_ID, UPD_DTTM
) VALUES (
    'DEVELOP', '개발자 공간', 'LADE01', 'G001', NULL, NULL, '개발자들간의 각종 문제해결 방안, 개발 노하우 등의 각종 의견을 <br />자유롭게 교환하고, 문제 해결을 할 수 있는 공간입니다.', 'Y',
    'Y', 20, 100, 'B1010', 'N', 'N', 'Y', 'BOTH',
    5, 'N', 'N', 'N', 'N', 'N', 'N', 'N',
    'Y', 'N', 'Y', NULL, SYSDATE, NULL, NULL
);
*/
INSERT INTO TB_BBS_ADMIN (
    BBS_CD, BBS_NM, LANG_CD, BBS_TYPE_CD, BBS_OPEN_DTTM, BBS_CLOSE_DTTM, BBS_EXP, USE_YN,
    LOGIN_WT_YN, LIST_CNT, HL_CNT, LIST_CD, NOTICE_YN, SECRET_YN, ATFILE_YN, EXT_LIMIT,
    SIZE_LIMIT, LINK_YN, INF_YN, DEPT_YN, EMAIL_REG_YN, EMAIL_NEED_YN, TEL_YN, TEL_NEED_YN,
    ANS_YN, ANS_TAG, HTML_YN, REG_ID, REG_DTTM, UPD_ID, UPD_DTTM
) VALUES (
    'DEVELOP', '개발자 공간', 'LADE01', 'G001', NULL, NULL, '개발자들간의 각종 문제해결 방안, 개발 노하우 등의 각종 의견을 <br />자유롭게 교환하고, 문제 해결을 할 수 있는 공간입니다.', 'Y',
    'Y', 20, 100, NULL, 'N', 'N', 'Y', 'BOTH',
    5, 'N', 'N', 'N', 'N', 'N', 'N', 'N',
    'Y', 'N', 'Y', NULL, SYSDATE, NULL, NULL
);

/*
INSERT INTO TB_BBS_ADMIN (
    BBS_CD, BBS_NM, LANG_CD, BBS_TYPE_CD, BBS_OPEN_DTTM, BBS_CLOSE_DTTM, BBS_EXP, USE_YN,
    LOGIN_WT_YN, LIST_CNT, HL_CNT, LIST_CD, NOTICE_YN, SECRET_YN, ATFILE_YN, EXT_LIMIT,
    SIZE_LIMIT, LINK_YN, INF_YN, DEPT_YN, EMAIL_REG_YN, EMAIL_NEED_YN, TEL_YN, TEL_NEED_YN,
    ANS_YN, ANS_TAG, HTML_YN, REG_ID, REG_DTTM, UPD_ID, UPD_DTTM
) VALUES (
    'DATA', '자료실', 'LADE01', 'G001', NULL, NULL, '개발자들의 개발 작업시 도움이 되는 자료들을 모아서<br /> 활용할 수 있도록 도와주는 공간입니다.', 'Y',
    'Y', 20, 100, 'B1011', 'N', 'N', 'Y', 'BOTH',
    5, 'N', 'N', 'Y', 'N', 'N', 'N', 'N',
    'N', 'N', 'Y', NULL, SYSDATE, NULL, NULL
);
*/
INSERT INTO TB_BBS_ADMIN (
    BBS_CD, BBS_NM, LANG_CD, BBS_TYPE_CD, BBS_OPEN_DTTM, BBS_CLOSE_DTTM, BBS_EXP, USE_YN,
    LOGIN_WT_YN, LIST_CNT, HL_CNT, LIST_CD, NOTICE_YN, SECRET_YN, ATFILE_YN, EXT_LIMIT,
    SIZE_LIMIT, LINK_YN, INF_YN, DEPT_YN, EMAIL_REG_YN, EMAIL_NEED_YN, TEL_YN, TEL_NEED_YN,
    ANS_YN, ANS_TAG, HTML_YN, REG_ID, REG_DTTM, UPD_ID, UPD_DTTM
) VALUES (
    'DATA', '자료실', 'LADE01', 'G001', NULL, NULL, '개발자들의 개발 작업시 도움이 되는 자료들을 모아서<br /> 활용할 수 있도록 도와주는 공간입니다.', 'Y',
    'Y', 20, 100, NULL, 'N', 'N', 'Y', 'BOTH',
    5, 'N', 'N', 'Y', 'N', 'N', 'N', 'N',
    'N', 'N', 'Y', NULL, SYSDATE, NULL, NULL
);

-- ASIS: 열린 재정에서 알려드리는 공지사항입니다. <br/>기획재정부는 재정정보 공개와 관련된 알찬소식을 전하기 위해 항상 노력하겠습니다.
-- ASIS: Y
UPDATE TB_BBS_ADMIN SET
    BBS_EXP = '경기도 개방 포털 공지사항입니다. <br />알차고, 유익한 정보를 신속히 전해 드리기 위해 항상 노력하겠습니다.',
    ANS_YN = 'N'
WHERE BBS_CD = 'NOTICE';

-- ASIS: 열린 재정 이용 중 흔히 제기될 수 있는 궁금증 및 그에 대한 답변을 모아 놓은 공간입니다. <br/>궁금하신 내용이 FAQ에 없을 경우 Q&A 코너에서 직접 질문하실 수 있습니다.
-- ASIS: B1001
UPDATE TB_BBS_ADMIN SET
    BBS_EXP = '경기도 개방 포털 이용 중 흔히 제기될 수 있는 궁금증 및<br />그에 대한 답변을 모아 놓은 공간입니다.',
    LIST_CD = NULL
WHERE BBS_CD = 'FAQ01';

-- ASIS: 재정정보 공개와 관련된 질의에 대한 신속한 답변을 드리기 위하여 마련된 공간입니다. <br/> 불편하시거나 궁금한 사항은 언제든 문의해 주십시오.
-- ASIS: B1002
UPDATE TB_BBS_ADMIN SET
    BBS_EXP = '경기도 개방 포털 이용시 관련업무와 관련된 질의에 대한<br /> 신속한 답변을 드리기 위하여 마련된 공간입니다.',
    LIST_CD = NULL
WHERE BBS_CD = 'QNA01';

-- ASIS: 경기데이터드림 포털에서 제공하지 않는 공공데이터를 신청하시면<br /> 제공여부 심의 후 제공 받으실 수 있습니다.
UPDATE TB_BBS_ADMIN SET
    BBS_EXP = '경기데이터드림에서 서비스 되지 않는 공공데이터는 신청을 통해 제공여부 심의 후 제공 받으실 수 있습니다.'
WHERE BBS_CD = 'OPDNEED';

UPDATE TB_BBS_ADMIN SET
    LOGIN_WT_YN = 'Y',
    LINK_YN = 'Y',
    EMAIL_REG_YN = 'N',
    TEL_YN = 'N',
    ANS_YN = 'N',
    ANS_TAG = 'N',
    HTML_YN = 'N'
WHERE BBS_CD = 'GALLERY';

UPDATE TB_BBS_ADMIN SET
    LOGIN_WT_YN = 'N',
    LINK_YN = 'N',
    EMAIL_REG_YN = 'N',
    TEL_YN = 'N',
    ANS_YN = 'Y',
    ANS_TAG = 'N',
    HTML_YN = 'N'
WHERE BBS_CD = 'DEVELOP';

UPDATE TB_BBS_ADMIN SET
    LOGIN_WT_YN = 'Y',
    LINK_YN = 'N',
    EMAIL_REG_YN = 'N',
    TEL_YN = 'N',
    ANS_YN = 'N',
    ANS_TAG = 'N',
    HTML_YN = 'Y'
WHERE BBS_CD = 'DATA';

UPDATE TB_BBS_ADMIN SET
    LOGIN_WT_YN = 'Y',
    LINK_YN = 'N',
    EMAIL_REG_YN = 'N',
    TEL_YN = 'N',
    ANS_YN = 'N',
    ANS_TAG = 'N',
    HTML_YN = 'Y'
WHERE BBS_CD = 'FAQ01';

UPDATE TB_BBS_ADMIN SET
    LOGIN_WT_YN = 'N',
    LINK_YN = 'N',
    EMAIL_REG_YN = 'N',
    TEL_YN = 'N',
    ANS_YN = 'Y',
    ANS_TAG = 'R',
    HTML_YN = 'N'
WHERE BBS_CD = 'QNA01';

UPDATE TB_BBS_ADMIN SET
    LOGIN_WT_YN = 'Y',
    LINK_YN = 'N',
    EMAIL_REG_YN = 'N',
    TEL_YN = 'N',
    ANS_YN = 'N',
    ANS_TAG = 'N',
    HTML_YN = 'Y'
WHERE BBS_CD = 'NOTICE';

INSERT INTO TB_BBS_ADMIN (
    BBS_CD, BBS_NM, LANG_CD, BBS_TYPE_CD, BBS_OPEN_DTTM, BBS_CLOSE_DTTM, BBS_EXP, USE_YN,
    LOGIN_WT_YN, LIST_CNT, HL_CNT, LIST_CD, NOTICE_YN, SECRET_YN, ATFILE_YN, EXT_LIMIT,
    SIZE_LIMIT, LINK_YN, INF_YN, DEPT_YN, EMAIL_REG_YN, EMAIL_NEED_YN, TEL_YN, TEL_NEED_YN,
    ANS_YN, ANS_TAG, HTML_YN, REG_ID, REG_DTTM, UPD_ID, UPD_DTTM
) VALUES (
    'EVENT', '이벤트', 'LADE01', 'G001', TO_DATE('20150924', 'YYYYMMDD'), TO_DATE('20151007', 'YYYYMMDD'), '경기도 공공데이터 개방포털 오픈 이벤트 옥의 티를 찾아라 여러분의 경기데이터드림의 버그를 찾아주세요! 추첨을 통해 소정의 상품을 드립니다', 'Y',
    'N', 20, 100, NULL, 'N', 'N', 'Y', 'BOTH',
    5, 'N', 'N', 'N', 'Y', 'Y', 'Y', 'Y',
    'N', 'N', 'N', NULL, SYSDATE, NULL, NULL
);

UPDATE TB_BBS_ADMIN SET
    BBS_OPEN_DTTM = TO_DATE('20151005', 'YYYYMMDD'),
    BBS_CLOSE_DTTM = TO_DATE('20151016', 'YYYYMMDD')
WHERE BBS_CD = 'EVENT';