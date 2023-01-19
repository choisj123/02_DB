--춘 대학교 워크북 과제
--SQL02_SELECT(Function)

-- 1번
-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL문장을 작성하시오.
-- (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- 2번
-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 두 명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL문장을 작성해보자.
-- (*이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇인지 생각해볼 것) ?? 무슨 말인지 잘 모르겠음
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3번
-- 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오.
-- 단 이 때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오.
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름"으로 한다. 나이는 '만'으로 계산한다.)
SELECT PROFESSOR_NAME 교수이름,
   FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(PROFESSOR_SSN, 1, 6),'YYYYMMDD')) /12) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 나이;

-- 4번
-- 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는 "이름"이 찍히도록 한다.
-- (성이 2자인 경우의 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME, 2) AS 이름
FROM TB_PROFESSOR;

-- 5번
-- 춘 기술대학교의 재수생 입학자를 구하려고 한다 어떻게 찾아낼 거인가?
-- 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주한다.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)
 - EXTRACT(YEAR FROM TO_DATE('19'||SUBSTR(STUDENT_SSN, 1, 6),'YYYYMMDD')) > 19;
 
-- 6번
-- 2020년 크리스마스는 무슨 요일인가?
--'DAY': 금요일 'DY': 금 'D': 6
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'DAY') 
FROM DUAL;


-- 7번
-- TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')은 각각 몇 년 몇 월 몇 일을 의미할까?
-- 또 TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')은 각각 몇 년 몇 월 몇 일을 의미할까?
-- YY는 모두 2000년대
-- RR은 49이하는 2000년대 50이상은 1900년대
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYY'), TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYY'),
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'RRRR'), TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'RRRR')
       
FROM DUAL;


-- 8번
-- 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9번
-- 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT ROUND(AVG(POINT),1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10번
-- 학과별 학생 수를 구하여 "학과번호", "학생수(명)"의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11번
-- 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는지 알아내는 SQL문을 작성하시오
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12번
-- 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력화면의 헤더는 "년도", "년도 별 평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT SUBSTR(TERM_NO,1,4) AS 년도, ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;


-- 13번
-- 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL문장을 작성하시오.
SELECT DEPARTMENT_NO 학과코드명, SUM(DECODE(ABSENCE_YN, 'Y', 1, 0)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

SELECT DEPARTMENT_NO "학과코드명", COUNT(DECODE(ABSENCE_YN,'Y','Y','NO',0))"휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;


-- 14번
-- 춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다.
-- 어떤 SQL 문장을 사용하면 가능하겠는가?
SELECT STUDENT_NAME AS 동일이름, COUNT(*) AS "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 1;

-- 15번
-- 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하는 SQL문을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT NVL(SUBSTR(TERM_NO,1,4), ' ') AS 년도, NVL(SUBSTR(TERM_NO,5,2),' ') AS 학기, ROUND(AVG(POINT),1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2))
ORDER BY SUBSTR(TERM_NO,1,4);