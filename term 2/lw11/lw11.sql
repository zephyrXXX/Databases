-- TASK №1

CREATE OR REPLACE PROCEDURE ADMIN_USER.GET_TEACHERS(PCODE TEACHER.PULPIT%TYPE)
    IS
    CURSOR GETTEACHERS IS SELECT TEACHER, TEACHER_NAME, PULPIT FROM TEACHER WHERE PULPIT = PCODE;
    M_TEACHER      TEACHER.TEACHER%TYPE;
    M_TEACHER_NAME TEACHER.TEACHER_NAME%TYPE;
    M_PULPIT       TEACHER.PULPIT%TYPE;
BEGIN
    OPEN GETTEACHERS;
    FETCH GETTEACHERS INTO M_TEACHER, M_TEACHER_NAME, M_PULPIT;
    DBMS_OUTPUT.PUT_LINE(M_TEACHER || ' ' || M_TEACHER_NAME || ' ' || M_PULPIT);

    WHILE (GETTEACHERS%FOUND)
        LOOP
            DBMS_OUTPUT.PUT_LINE(M_TEACHER || ' ' || M_TEACHER_NAME || ' ' || M_PULPIT);
            FETCH GETTEACHERS INTO M_TEACHER, M_TEACHER_NAME, M_PULPIT;
        END LOOP;
    CLOSE GETTEACHERS;
END GET_TEACHERS;

BEGIN
    GET_TEACHERS('ИСиТ');
END;

-- TASK №2

CREATE OR REPLACE FUNCTION ADMIN_USER.GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE)
RETURN NUMBER
IS
    RESULT_NUM NUMBER;
BEGIN
    SELECT COUNT(TEACHER) INTO RESULT_NUM FROM TEACHER WHERE PULPIT=PCODE;
    RETURN RESULT_NUM;
END GET_NUM_TEACHERS;

BEGIN
     DBMS_OUTPUT.PUT_LINE(GET_NUM_TEACHERS('ИСиТ'));
END;

-- TASK №3

CREATE OR REPLACE PROCEDURE ADMIN_USER.GET_TEACHERS_BY_FACULTY (FCODE FACULTY.FACULTY%TYPE)
    IS
    CURSOR GETTEACHERSBYFACULTY IS
        SELECT TEACHER, TEACHER_NAME, P.PULPIT
        FROM TEACHER INNER JOIN PULPIT P ON P.PULPIT = TEACHER.PULPIT
        WHERE FACULTY = FCODE;

    M_TEACHER      TEACHER.TEACHER%TYPE;
    M_TEACHER_NAME TEACHER.TEACHER_NAME%TYPE;
    M_PULPIT       TEACHER.PULPIT%TYPE;
BEGIN
    OPEN GETTEACHERSBYFACULTY;
    FETCH GETTEACHERSBYFACULTY INTO M_TEACHER, M_TEACHER_NAME, M_PULPIT;

    WHILE (GETTEACHERSBYFACULTY%FOUND)
    LOOP
        DBMS_OUTPUT.PUT_LINE(M_TEACHER || ' ' || M_TEACHER_NAME || ' ' || M_PULPIT);
        FETCH GETTEACHERSBYFACULTY INTO M_TEACHER, M_TEACHER_NAME, M_PULPIT;
    END LOOP;

    CLOSE GETTEACHERSBYFACULTY;

END GET_TEACHERS_BY_FACULTY;

BEGIN
    GET_TEACHERS_BY_FACULTY('ИДиП');
END;


CREATE OR REPLACE PROCEDURE GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
IS
    CURSOR GETSUBJECTS IS
    SELECT * FROM SUBJECT WHERE PULPIT=PCODE;

    M_SUBJECT SUBJECT.SUBJECT%TYPE;
    M_SUBJECT_NAME SUBJECT.SUBJECT_NAME%TYPE;
    M_PULPIT SUBJECT.PULPIT%TYPE;
BEGIN
    OPEN GETSUBJECTS;
    FETCH GETSUBJECTS INTO M_SUBJECT, M_SUBJECT_NAME, M_PULPIT;

    WHILE (GETSUBJECTS%FOUND)
    LOOP
        DBMS_OUTPUT.PUT_LINE(M_SUBJECT || ' ' || M_SUBJECT_NAME || ' ' || M_PULPIT);
        FETCH GETSUBJECTS INTO M_SUBJECT, M_SUBJECT_NAME, M_PULPIT;
    END LOOP;
    CLOSE GETSUBJECTS;

END GET_SUBJECTS;

BEGIN
    GET_SUBJECTS('ИСиТ');
END;

-- TASK №4

CREATE OR REPLACE FUNCTION FGET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
RETURN NUMBER
IS
    RESULT_NUM NUMBER;
BEGIN
    SELECT COUNT(TEACHER) INTO RESULT_NUM FROM TEACHER
                          WHERE TEACHER.PULPIT IN (SELECT PULPIT FROM PULPIT WHERE FACULTY=FCODE);
    RETURN RESULT_NUM;
END FGET_NUM_TEACHERS;

BEGIN
    DBMS_OUTPUT.PUT_LINE(FGET_NUM_TEACHERS('ИДиП'));
END;

CREATE OR REPLACE FUNCTION GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER
IS
    RESULT_NUM NUMBER;
BEGIN
    SELECT COUNT(SUBJECT) INTO RESULT_NUM FROM SUBJECT WHERE PULPIT=PCODE;
    RETURN RESULT_NUM;
END GET_NUM_SUBJECTS;

begin
    DBMS_OUTPUT.PUT_LINE(GET_NUM_SUBJECTS('ИСиТ'));
end;

-- TASK №5

CREATE OR REPLACE PACKAGE TEACHERS AS
  FCODE FACULTY.FACULTY%TYPE;
  PCODE SUBJECT.PULPIT%TYPE;
  PROCEDURE P_GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE);
  PROCEDURE P_GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE);
  FUNCTION P_GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER;
  FUNCTION P_GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER;
END TEACHERS;

CREATE OR REPLACE PACKAGE BODY TEACHERS
IS
    PROCEDURE P_GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE)
        IS
        CURSOR GETTEACHERSBYFACULTY IS
            SELECT TEACHER, TEACHER_NAME, P.PULPIT
            FROM TEACHER
                     INNER JOIN PULPIT P ON P.PULPIT = TEACHER.PULPIT
            WHERE FACULTY = FCODE;
        M_TEACHER      TEACHER.TEACHER%TYPE;
        M_TEACHER_NAME TEACHER.TEACHER_NAME%TYPE;
        M_PULPIT       TEACHER.PULPIT%TYPE;
    BEGIN
        OPEN GETTEACHERSBYFACULTY;
        FETCH GETTEACHERSBYFACULTY INTO M_TEACHER, M_TEACHER_NAME, M_PULPIT;

        WHILE (GETTEACHERSBYFACULTY%FOUND)
            LOOP
                DBMS_OUTPUT.PUT_LINE(M_TEACHER || ' ' || M_TEACHER_NAME || ' ' || M_PULPIT);
                FETCH GETTEACHERSBYFACULTY INTO M_TEACHER, M_TEACHER_NAME, M_PULPIT;
            END LOOP;

        CLOSE GETTEACHERSBYFACULTY;

    END P_GET_TEACHERS;
    PROCEDURE P_GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE)
        IS
        CURSOR GETSUBJECTS IS
            SELECT *
            FROM SUBJECT
            WHERE PULPIT = PCODE;
        M_SUBJECT      SUBJECT.SUBJECT%TYPE;
        M_SUBJECT_NAME SUBJECT.SUBJECT_NAME%TYPE;
        M_PULPIT       SUBJECT.PULPIT%TYPE;
    BEGIN
        OPEN GETSUBJECTS;
        FETCH GETSUBJECTS INTO M_SUBJECT, M_SUBJECT_NAME, M_PULPIT;

        WHILE (GETSUBJECTS%FOUND)
            LOOP
                DBMS_OUTPUT.PUT_LINE(M_SUBJECT || ' ' || M_SUBJECT_NAME || ' ' || M_PULPIT);
                FETCH GETSUBJECTS INTO M_SUBJECT, M_SUBJECT_NAME, M_PULPIT;
            END LOOP;
        CLOSE GETSUBJECTS;

    END P_GET_SUBJECTS;
    FUNCTION P_GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE)
        RETURN NUMBER
        IS
        RESULT_NUM NUMBER;
    BEGIN
        SELECT COUNT(TEACHER)
        INTO RESULT_NUM
        FROM TEACHER
        WHERE TEACHER.PULPIT IN (SELECT PULPIT FROM PULPIT WHERE FACULTY = FCODE);
        RETURN RESULT_NUM;
    END P_GET_NUM_TEACHERS;
    FUNCTION P_GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER
        IS
        RESULT_NUM NUMBER;
    BEGIN
        SELECT COUNT(SUBJECT) INTO RESULT_NUM FROM SUBJECT WHERE PULPIT = PCODE;
        RETURN RESULT_NUM;
    END P_GET_NUM_SUBJECTS;
BEGIN
    NULL;
END TEACHERS;

-- TASK №6
begin
  DBMS_OUTPUT.PUT_LINE('Кол-во преподавателей на факультете: ' || TEACHERS.P_GET_NUM_TEACHERS('ИДиП'));
  DBMS_OUTPUT.PUT_LINE('Кол-во предметов на кафедре: ' || TEACHERS.P_GET_NUM_SUBJECTS('ИСиТ'));
  DBMS_OUTPUT.PUT_LINE('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  TEACHERS.P_GET_TEACHERS('ИДиП');
  DBMS_OUTPUT.PUT_LINE('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  TEACHERS.P_GET_SUBJECTS('ИСиТ');
end;