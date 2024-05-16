UPDATE TB_OPEN_CATE A SET
    CATE_NM = CASE CATE_ID
              WHEN 'GG05' THEN '가족보건복지'
              WHEN 'GG09' THEN '관광문화체육'
              WHEN 'GG23' THEN '교육취업'
              WHEN 'GG01' THEN '교통건설환경'
              WHEN 'GG16' THEN '농림축산해양'
              WHEN 'GG26' THEN '도시주택'
              WHEN 'GG20' THEN '산업경제'
              WHEN 'GG13' THEN '소방재난안전'
              WHEN 'GG29' THEN '조세법무행정'
              END,
    V_ORDER = CASE CATE_ID
              WHEN 'GG05' THEN 2
              WHEN 'GG09' THEN 3
              WHEN 'GG23' THEN 7
              WHEN 'GG01' THEN 1
              WHEN 'GG16' THEN 5
              WHEN 'GG26' THEN 8
              WHEN 'GG20' THEN 6
              WHEN 'GG13' THEN 4
              WHEN 'GG29' THEN 9
              END
END WHERE A.CATE_ID IN (
    'GG05', -- 보건복지 26
    'GG09', -- 문화관광 22
    'GG23', -- 교육취업 9
    'GG01', -- 환경기상 30
    'GG16', -- 농림축산 15
    'GG26', -- 도시관리 6
    'GG20', -- 산업경제 12
    'GG13', -- 재난안전 19
    'GG29'  -- 공공행정 1
);