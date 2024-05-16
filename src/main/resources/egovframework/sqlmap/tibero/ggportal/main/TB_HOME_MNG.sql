UPDATE TB_HOME_MNG SET
    USE_YN = 'N'
WHERE HOME_TAG_CD = 'PROMT';

INSERT INTO TB_HOME_MNG (
    SEQCE_NO, SRV_TIT, HOME_TAG_CD, STRT_DTTM,
    END_DTTM, LINK_URL, SAVE_FILE_NM, POPUP_YN,
    V_ORDER, USE_YN, REG_ID, REG_DTTM
) VALUES (
    (SELECT MAX(SEQCE_NO) + 1 FROM TB_HOME_MNG), '경기도 공공데이터 개방포털 공공데이터를 민간에 공개하고 소통함으로써 경제적 가치를 창출할 수 있도록 하는 서비스입니다', 'PROMT', NULL,
    NULL, '/portal/data/dataset/searchDatasetPage.do', '20150918104400001.png', 'N',
    1, 'Y', NULL, SYSDATE
);
INSERT INTO TB_HOME_MNG (
    SEQCE_NO, SRV_TIT, HOME_TAG_CD, STRT_DTTM,
    END_DTTM, LINK_URL, SAVE_FILE_NM, POPUP_YN,
    V_ORDER, USE_YN, REG_ID, REG_DTTM
) VALUES (
    (SELECT MAX(SEQCE_NO) + 1 FROM TB_HOME_MNG), '경기도 공공데이터 개방포털 오픈 이벤트 옥의 티를 찾아라 여러분의 경기데이터드림의 버그를 찾아주세요! 추첨을 통해 소정의 상품을 드립니다', 'PROMT', NULL,
    NULL, '#', '20150918104400002.png', 'N',
    2, 'Y', NULL, SYSDATE
);
INSERT INTO TB_HOME_MNG (
    SEQCE_NO, SRV_TIT, HOME_TAG_CD, STRT_DTTM,
    END_DTTM, LINK_URL, SAVE_FILE_NM, POPUP_YN,
    V_ORDER, USE_YN, REG_ID, REG_DTTM
) VALUES (
    (SELECT MAX(SEQCE_NO) + 1 FROM TB_HOME_MNG), '멀티미디어데이터 경기도가 지자체 최초로 멀티미디어 데이터를 공개합니다', 'PROMT', NULL,
    NULL, '/portal/data/multimedia/searchMultimediaPage.do', '20150918104400003.png', 'N',
    3, 'Y', NULL, SYSDATE
);
INSERT INTO TB_HOME_MNG (
    SEQCE_NO, SRV_TIT, HOME_TAG_CD, STRT_DTTM,
    END_DTTM, LINK_URL, SAVE_FILE_NM, POPUP_YN,
    V_ORDER, USE_YN, REG_ID, REG_DTTM
) VALUES (
    (SELECT MAX(SEQCE_NO) + 1 FROM TB_HOME_MNG), '우리지역 데이터 찾기 지도 기반으로 우리지역 관련 공공데이터를 손쉽게 찾으실 수 있습니다', 'PROMT', NULL,
    NULL, '/portal/data/village/searchVillagePage.do', '20150918104400004.png', 'N',
    4, 'Y', NULL, SYSDATE
);

UPDATE TB_HOME_MNG SET
    LINK_URL = '/portal/etc/event/selectBulletinPage.do',
    POPUP_YN = 'Y'
WHERE LINK_URL = '#';

UPDATE TB_HOME_MNG SET
    LINK_URL = '/portal/data/dataset/searchDatasetPage.do?searchWord=추석'
WHERE SRV_TIT LIKE '추석%';

UPDATE TB_HOME_MNG SET
    LINK_URL = '/portal/data/dataset/searchChuseok.do'
WHERE SRV_TIT LIKE '추석%';