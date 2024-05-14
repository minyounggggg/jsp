show tables;

create table board(
	idx int not null auto_increment,		/*게시글의 고유번호*/
	mid varchar(20) not null,				/*게시글 올린이 아이디*/
	nickName varchar(20) not null,			/*게시글 올린이 닉네임*/
	title varchar(100) not null,			/*게시글 제목*/
	content text not null,					/*글 내용*/
	readNum int default 0,					/*글 조회수*/
	hostIp varchar(40) not null,			/*글 올린이 IP*/
	openSw char(2) default 'OK',			/*게시글 공개여부(OK:공개, NO:비공개)*/
	wDate datetime default now(),			/*글쓴날짜*/
	good int default 0,						/*좋아요 버튼 클릭 횟수 누적*/
	primary key(idx),						/*기본키 : 고유번호*/
	foreign key(mid) references member(mid)
);

drop table board;
desc board;

insert into board values (default,'admin','관리맨','게시판 서비스를 시작합니다.','안녕하세요.',default,'192.168.50.53',default,default,default);

select * from board;
select * from board where idx = 5; /*현재글*/
select idx, title from board where idx > 5 order by idx limit 1; /*다음글*/
select idx, title from board where idx < 5 order by idx desc limit 1; /*이전글*/

-- 시간으로 비교해서 필드에 값 저장하기
select *, timestampdiff(hour, wDate, now()) as hour_diff from board;    /* as 뒤는 변수명*/

-- 날짜로 비교해서 필드에 값 저장하기
select *, datediff(wDate, now()) as date_diff from board;
