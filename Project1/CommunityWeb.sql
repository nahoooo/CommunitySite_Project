select * from MEMBER
drop table MEMBER
--회원 테이블
CREATE TABLE MEMBER(
ID VARCHAR2(20) NOT NULL PRIMARY KEY, --회원 아이디
NICKNAME VARCHAR2(20) NOT NULL, --회원 닉네임
EMAIL VARCHAR2(30) NOT NULL, --회원 이메일
PASSWORD VARCHAR2(20) NOT NULL,--회원 비밀번호
REGIST_DATE DATE DEFAULT SYSDATE,--가입일
GRADE VARCHAR2(7) DEFAULT 'User', --회원등급
USERPROFILE VARCHAR2(100) --회원프로필사진
)

update member set nickname='매실차' email='qweqwe123@qweqwe.com' where id='qqq123'

UPDATE MEMBER SET userProfile='/userProfile/20210115051410309_photo_fe1650f3c4307.jpg' WHERE nickname='말랑카우'

--커뮤니티게시판 테이블(다중게시판)
create table board_(
seq number(5) not null, --게시글 번호
title varchar2(200) not null, -- 게시글 제목
id varchar2(20) not null, --작성자 아이디
nickname varchar2(20) not null, -- 작성자 닉네임
content varchar2(2000) not null, --게시글 내용
regdate date default sysdate, --게시글 작성일
cnt number(5) default 0, --게시글 조회수
like_cnt number(5) default 0, --게시글 좋아요
comment_cnt number(5) default 0, --게시글 댓글수
boardtype varchar2(20) not null, --게시판 타입(타입을 나누어서 하나의 테이블로 다수의 게시판을 구현할 수 있음)
imageurl varchar2(500), --이미지 경로
constraint board_PK primary key(seq,boardtype)
)

select * from replyboard_
drop table replyboard_


--게시판 댓글 테이블  대댓글도 만들어야....
create table replyboard_(
boardseq number(5) not null, --board테이블의 seq를 참고하는 필드(외래키)
boardtype varchar2(20) not null, --board테이블의 게시판 타입 필드(외래키)
seq number(5) not null, --같은 게시물의 댓글들의 순번을 지정하는 필드
nickname varchar2(30) not null, --댓글 남긴 사람 닉네임.
id varchar2(20) not null, --댓글 남긴 사람 아이디
regdate date default sysdate, --댓글 남긴 시간.
reply varchar2(1000) not null, --댓글 내용.
userprofilephto varchar2(100), -- 댓글 작성자 프로필 사진.
primary key(boardseq,boardtype,seq) --두 개의 필드를 조합해서 기본키로 정의
)
--댓글 삭제를 위한 외래키 설정
ALTER TABLE replyboard_ ADD CONSTRAINT reply_fk foreign KEY(boardseq,boardtype) references board_ (seq,boardtype) ON DELETE CASCADE;
ALTER TABLE replyboard_ DROP CONSTRAINT reply_fk;

select * from recommend_R
drop table R_replyboard_

--나만의 맛집 추천 테이블
create table recommend_R(
seq number(5) not null primary key, --게시글 번호
title varchar2(200) not null, -- 게시글 제목
nickname varchar2(20) not null, -- 작성자 닉네임
id varchar2(20) not null, --작성자 아이디
restaurantname varchar2(40) not null, --식당이름
restaurantaddr varchar2(100) not null, --식당 주소
onelinereview varchar2(100) not null, --식당 한줄평
tel varchar2(20), --식당 전화번호
openinghours varchar2(50), --식당 영업시간
parking varchar2(50), --식당 주차가능여부s
closed varchar2(50), --식당 휴뮤일
content varchar2(4000) not null, --게시글 내용
imageurl varchar2(500), --이미지 경로
thumbnail varchar2(100), --썸네일
starrating number(5) default 0, --별점.
regdate date default sysdate, --게시글 작성일
cnt number(5) default 0, --게시글 조회수
like_cnt number(5) default 0, --게시글 좋아요
comment_cnt number(5) default 0, --게시글 댓글수
placeLa varchar2(30), --식당 위도
placeLO varchar2(30) --식당 경도
)

drop table R_replyboard_ 

--맛집추천 댓글(별점추가)
create table R_replyboard_(
boardseq number(5) not null, --board테이블의 seq를 참고하는 필드(외래키)
seq number(5) not null, --같은 게시물의 댓글들의 순번을 지정하는 필드
nickname varchar2(30) not null, --댓글 남긴 사람 닉네임.
id varchar2(20) not null, --댓글 남긴 사람 아이디
regdate date default sysdate, --댓글 남긴 시간.
reply varchar2(1000) not null, --댓글 내용.
starrating number(5), --별점.
userprofilephto varchar2(100), -- 댓글 작성자 프로필 사진.
primary key(boardseq,seq) --두 개의 필드를 조합해서 기본키로 정의
)
--댓글 삭제를 위한 외래키 설정
ALTER TABLE R_replyboard_ ADD CONSTRAINT R_reply_fk foreign KEY(boardseq) references recommend_R (seq) ON DELETE CASCADE;
ALTER TABLE R_replyboard_ DROP CONSTRAINT R_reply_fk;

select * from board_ where id='qqq123';

select * from R_replyboard_

drop table R_replyboard_

insert into R_replyboard_(boardseq,seq,nickname,reply,starrating) values(1,(select nvl(max(seq),0)+1 from R_replyboard_ where boardseq =1),'말랑카우','말랑카우',3)

update recommend_R a set(starrating)=(select avg(b.starrating) from R_replyboard_ b  where b.seq=a.seq) where a.seq=1


create table mes



select  * from R_replyboard_

select seq,restaurantname,placeLa,placeLO,title,nickname,onelinereview,imageurl from recommend_R where placeLa is not null and placeLO is not null

select seq,restaurantname,placeLa,placeLO,title,nickname from recommend_R where placeLa is not null and placeLO is not null

select * from recommend_R

drop table R_replyboard_

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

insert into MEMBER VALUES('system123','관리자','system@system.com','abcabc123!',DEFAULT,'Manager',null);

insert into MEMBER VALUES('abc123','홍길동','abc@abc.com','abcabc123!',DEFAULT,DEFAULT); 

select * from member where id='system123' and password='system123!';