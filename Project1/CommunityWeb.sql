select * from MEMBER

--회원 테이블
CREATE TABLE MEMBER(
ID VARCHAR2(20) NOT NULL PRIMARY KEY, --회원 아이디
NICKNAME VARCHAR2(20) NOT NULL, --회원 닉네임
EMAIL VARCHAR2(30) NOT NULL, --회원 이메일
PASSWORD VARCHAR2(20) NOT NULL,--회원 비밀번호
REGIST_DATE DATE DEFAULT SYSDATE,--가입일
GRADE VARCHAR2(7) DEFAULT 'User' --회원등급
)

--게시판 테이블(다중게시판)
create table board_(
seq number(5) not null, --게시글 번호
title varchar2(200) not null, -- 게시글 제목
nickname varchar2(20) not null, -- 작성자 닉네임
content varchar2(2000) not null, --게시글 내용
regdate date default sysdate, --게시글 작성일
cnt number(5) default 0, --게시글 조회수
like_cnt number(5) default 0, --게시글 좋아요
comment_cnt number(5) default 0, --게시글 댓글수
boardno number(2) not null, --게시판 타입
constraint board_PK primary key(seq,boardno)
)

select * from BOARD_

--게시판 댓글 테이블
create table replyboard_(
boardseq number(5) not null, --board테이블의 seq를 참고하는 필드(외래키)
boardno number(2) not null, --board테이블의 게시판 타입 필드(외래키)
seq number(5) not null, --같은 게시물의 댓글들의 순번을 지정하는 필드
nickname varchar2(30) not null, --댓글 남긴 사람 닉네임.
regdate date default sysdate, --댓글 남긴 시간.
reply varchar2(1000) not null, --댓글 내용.
primary key(boardseq,boardno,seq) --두 개의 필드를 조합해서 기본키로 정의
)

ALTER TABLE replyboard_ ADD CONSTRAINT reply_fk foreign KEY(boardseq,boardno) references board_ (seq,boardno) ON DELETE CASCADE;

ALTER TABLE replyboard_ DROP CONSTRAINT reply_fk;



--대댓글도 만들어야

select * from REPLYBOARD_

drop table replyboard_

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 3),'2 번째 게시물','홍길동','2 번째 게시물 내용.','2022-02-01',3);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 3),'3 번째 게시물','홍길동','3 번째 게시물 내용.','2022-02-01',3);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 3),'4 번째 게시물','홍길동','4 번째 게시물 내용.','2022-02-01',3);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'5 번째 게시물','홍길동','5 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'6 번째 게시물','홍길동','6 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'7 번째 게시물','홍길동','7 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'8 번째 게시물','홍길동','8 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'9 번째 게시물','홍길동','9 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'10 번째 게시물','홍길동','10 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'11 번째 게시물','홍길동','11 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'12 번째 게시물','홍길동','12 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'13 번째 게시물','홍길동','13 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'14 번째 게시물','홍길동','14 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'15 번째 게시물','홍길동','15 번째 게시물 내용.','2022-02-01',2);

insert into board_(seq,title,nickname,content,regdate,boardno)
values ((select nvl(max(seq),0)+1 from board_ where boardno = 2),'16 번째 게시물','홍길동','16 번째 게시물 내용.','2022-02-01',2);



select * from BOARD_;

drop table board_

DROP TABLE MEMBER

insert into MEMBER VALUES('system123','관리자','system@system.com','system123!',DEFAULT,'Manager');

insert into MEMBER VALUES('abc123','홍길동','abc@abc.com','abcabc123!',DEFAULT,DEFAULT); 

select * from member where id='system123' and password='system123!';