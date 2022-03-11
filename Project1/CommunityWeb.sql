select * from MEMBER

CREATE TABLE MEMBER(
ID VARCHAR2(20) NOT NULL PRIMARY KEY, --회원 아이디
NICKNAME VARCHAR2(20) NOT NULL, --회원 닉네임
EMAIL VARCHAR2(30) NOT NULL, --회원 이메일
PASSWORD VARCHAR2(20) NOT NULL,--회원 비밀번호
REGIST_DATE DATE DEFAULT SYSDATE,--가입일
GRADE VARCHAR2(7) DEFAULT 'User' --회원등급
)

create table board_(
seq number(5) primary key, --게시글 번호
title varchar2(200) not null, -- 게시글 제목
nickname varchar2(20) not null, -- 작성자 닉네임
userid varchar2(20) not null, --작성자 아이디
content varchar2(2000) not null, --게시글 내용
regdate date default sysdate, --게시글 작성일
cnt number(5) default 0, --게시글 조회수
comment_cnt number(5), --게시글 댓글수
boardno number(2) --게시판 타입
)



DROP TABLE MEMBER

insert into MEMBER VALUES('system123','관리자','system@system.com','system123!',DEFAULT,'Manager');

insert into MEMBER VALUES('abc123','홍길동','abc@abc.com','abcabc123!',DEFAULT,DEFAULT); 

select * from member where id='system123' and password='system123!';