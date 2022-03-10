select * from MEMBER

CREATE TABLE MEMBER(
ID VARCHAR2(20) NOT NULL PRIMARY KEY,
NICKNAME VARCHAR2(20) NOT NULL,
EMAIL VARCHAR2(30) NOT NULL,
PASSWORD VARCHAR2(20) NOT NULL,
REGIST_DATE DATE DEFAULT SYSDATE,
GRADE VARCHAR2(7) DEFAULT 'User'
)

DROP TABLE MEMBER

insert into MEMBER VALUES('system123','관리자','system@system.com','system123!',DEFAULT,'Manager');

insert into MEMBER VALUES('abc123','홍길동','abc@abc.com','abcabc123!',DEFAULT,DEFAULT); 

select * from member where id='system123' and password='system123!';