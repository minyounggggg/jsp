show tables;

create table schedule (
	idx int not null auto_increment, 		/* 스케줄관리 고유번호 */
	mid varchar (20) not null,				/* 회원 아이디(일정검색시 필요) */
	sDate datetime not null,				/* 일정등록 날짜 */
	part varchar (10) not null,				/* 일정분류(1.모임, 2.업무, 3.학습, 4.여행, 5.기타) */
	content text not null,					/* 일정 상세내역 */
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc schedule;

insert into schedule values (default, 'cmy1234', '2024-05-2', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-4', '학습', '공부해');
insert into schedule values (default, 'cmy1234', '2024-05-4', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-8', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-9', '학습', '공부해2');
insert into schedule values (default, 'mk1234', '2024-05-14', '학습', '공부해');
insert into schedule values (default, 'cmy1234', '2024-05-15', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-16', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-16', '여행', '여행갈꺼야 맛있는거');
insert into schedule values (default, 'cmy1234', '2024-05-17', '모임', '술 와장창 먹기');
insert into schedule values (default, 'mk1234', '2024-05-17', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-17', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-18', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-19', '기타', '호락호락하지 않은 나는 모락모락');
insert into schedule values (default, 'cmy1234', '2024-05-20', '업무', '밀키 산책 시키기');
insert into schedule values (default, 'mk1234', '2024-05-21', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-21', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-21', '업무', '우주정복');
insert into schedule values (default, 'mk1234', '2024-05-24', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-24', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-05-24', '여행', '여행갈꺼야 맛있는거2');
insert into schedule values (default, 'cmy1234', '2024-05-25', '여행', '여행갈꺼야 맛있는거3');
insert into schedule values (default, 'cmy1234', '2024-05-25', '모임', '술 와장창 먹기');
insert into schedule values (default, 'mk1234', '2024-05-25', '모임', '술 와장창 먹기');
insert into schedule values (default, 'cmy1234', '2024-06-5', '업무', '피부과가기');
insert into schedule values (default, 'cmy1234', '2024-06-7', '업무', '땅파면 돈나와라');
insert into schedule values (default, 'admin', '2024-06-13', '모임', '술 와장창 먹기');


/*문자로비교*/
select * from schedule where mid='cmy1234' and substring(sDate, 1, 10) = '2024-06-13' order by sDate;
/*날짜로비교*/
select * from schedule where mid='cmy1234' and date_format(sDate, '%Y-%m-%d') = '2024-05-16' order by sDate;

select * from schedule where mid='cmy1234' and date_format(sDate, '%Y-%m') = '2024-05' order by sDate, part;
select *, count(*) as cnt from schedule where mid='cmy1234' and date_format(sDate, '%Y-%m') = '2024-05' order by sDate, part;
select *, count(*) as cnt from schedule where mid='cmy1234' and date_format(sDate, '%Y-%m') = '2024-05' group by sDate order by sDate, part;
select *, count(*) as cnt from schedule where mid='cmy1234' and date_format(sDate, '%Y-%m') = '2024-05' group by sDate,part order by sDate, part;

select * from schedule where mid='cmy1234' and date_format(sDate, '%Y-%m-%d') = '2024-05-16' order by sDate, part;
select *, count(*) as cnt from schedule where mid='cmy1234' and date_format(sDate, '%Y-%m-%d') = '2024-05-16' order by sDate, part;
select *, count(*) as cnt from schedule where mid='cmy1234' and date_format(sDate, '%Y-%m-%d') = '2024-05-16' group by part order by sDate, part;

