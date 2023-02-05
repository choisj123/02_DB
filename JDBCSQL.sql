CREATE TABLE TB_TEST(
	TEST_NO NUMBER PRIMARY KEY,
	TEST_TITLE VARCHAR2(100) NOT NULL,
	TEST_CONTENT VARCHAR2(500) NOT NULL
);

SELECT EMP_NAME , JOB_NAME, SALARY , SALARY*12 AS ANUL 
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > 50000;

SELECT EMP_NAME , TO_CHAR(HIRE_DATE,'YYYY-MM-DD') AS HIRE_DATE , DECODE(SUBSTR(EMP_NO, 8, 1),1,'M',2,'F') AS GENDER
FROM EMPLOYEE 
WHERE HIRE_DATE > TO_CHAR(TO_DATE("2022-09-06", 'YYMMDD'),'YYYY-MM-DD');


SELECT EMP_NAME , TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') AS "HIRE_DATE" , 
		DECODE(SUBSTR(EMP_NO, 8, 1), '1', 'M', '2', 'F') AS GENDER 
		FROM EMPLOYEE 
		WHERE HIRE_DATE < TO_DATE('2022-09-06');
		
	