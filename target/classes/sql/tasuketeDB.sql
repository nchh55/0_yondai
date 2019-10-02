
/* Drop Tables */

DROP TABLE blacklist CASCADE CONSTRAINTS;
DROP TABLE comrereply CASCADE CONSTRAINTS;
DROP TABLE compreply CASCADE CONSTRAINTS;
DROP TABLE compliment CASCADE CONSTRAINTS;
DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE report CASCADE CONSTRAINTS;
DROP TABLE request CASCADE CONSTRAINTS;
DROP TABLE reservations CASCADE CONSTRAINTS;
DROP TABLE sugrereply CASCADE CONSTRAINTS;
DROP TABLE suggreply CASCADE CONSTRAINTS;
DROP TABLE suggestion CASCADE CONSTRAINTS;
DROP TABLE user_auth CASCADE CONSTRAINTS;
DROP TABLE tasukete_user CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_compliment_complimentseq;
DROP SEQUENCE SEQ_compreply_compreplyseq;
DROP SEQUENCE SEQ_comrereply_comrereplyseq;
DROP SEQUENCE SEQ_notice_noticeseq;
DROP SEQUENCE SEQ_report_reportseq;
DROP SEQUENCE SEQ_request_requestseq;
DROP SEQUENCE SEQ_reservations_reserseq;
DROP SEQUENCE SEQ_suggestion_suggestionseq;
DROP SEQUENCE SEQ_suggreply_suggreplyseq;
DROP SEQUENCE SEQ_sugrereply_sugrereplyseq;




/* Create Sequences */

CREATE SEQUENCE SEQ_compliment_complimentseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_compreply_compreplyseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_comrereply_comrereplyseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_notice_noticeseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_report_reportseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_request_requestseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_reservations_reserseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_suggestion_suggestionseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_suggreply_suggreplyseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_sugrereply_sugrereplyseq INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE blacklist
(
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 블랙리스트를 한 이유
	blacklist_contents varchar2(2000),
	-- 블랙리스트의 기간을 제한해서 기간이 지나가면 자동으로 화이트라인 시킨다.
	blacklist_deadline varchar2(40)
);


CREATE TABLE compliment
(
	-- 칭찬 시퀀스
	complimentseq number NOT NULL,
	-- 칭찬 제목
	compliment_title varchar2(200) NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 칭찬 내용
	compliment_contents varchar2(2000) NOT NULL,
	compliment_date varchar2(40) NOT NULL,
	PRIMARY KEY (complimentseq)
);


CREATE TABLE compreply
(
	-- 칭찬 시퀀스
	compreplyseq number NOT NULL,
	-- 칭찬 시퀀스
	complimentseq number NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 칭찬 댓글 내용
	compreply_contents varchar2(2000) NOT NULL,
	-- 칭찬 댓글 일시
	compreply_date varchar2(40) NOT NULL,
	PRIMARY KEY (compreplyseq)
);


CREATE TABLE comrereply
(
	-- 칭찬 대댓글 시퀀스
	comrereplyseq number NOT NULL,
	-- 칭찬 시퀀스
	compreplyseq number NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 칭찬 대댓글 내용
	comrereply_contents varchar2(2000) NOT NULL,
	-- 칭찬 대댓글 일시
	comrereply_date varchar2(40) NOT NULL,
	PRIMARY KEY (comrereplyseq)
);


CREATE TABLE notice
(
	-- 공지시퀀스
	noticeseq number NOT NULL,
	-- 공지 제목
	notice_title varchar2(200) NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 공지 내용
	notice_contents varchar2(2000) NOT NULL,
	-- 공지 일시
	notice_date varchar2(40) NOT NULL,
	PRIMARY KEY (noticeseq)
);


CREATE TABLE report
(
	-- 신고 시퀀스
	reportseq number NOT NULL,
	-- 신고 제목
	report_title varchar2(200) NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 신고 내용
	report_contents varchar2(2000) NOT NULL,
	-- 신고 일시
	report_date varchar2(40) NOT NULL,
	PRIMARY KEY (reportseq)
);


CREATE TABLE request
(
	-- 요청시퀀스
	requestseq number NOT NULL,
	-- 요청 내용
	request_contents varchar2(300) NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 지원자 아이디
	support_id varchar2(50),
	-- 요청자위치_X
	req_x varchar2(20),
	-- 요청자위치_Y
	req_y varchar2(20),
	-- 지원자위치_X
	supp_x varchar2(20),
	-- 지원자위치_Y
	supp_y varchar2(20),
	-- 요청 일시
	request_date varchar2(40),
	-- 완료 일시
	completion_date varchar2(40),
	-- 요청 상태
	request_flag varchar2(20) DEFAULT '0',
	PRIMARY KEY (requestseq)
);


CREATE TABLE reservations
(
	-- 예약 시퀀스
	reserseq number NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 지원자의 아이디
	support_id varchar2(50),
	-- 예약 일시
	reserseq_date varchar2(40) NOT NULL,
	-- 예약 장소
	reserseq_place varchar2(150) NOT NULL,
	-- 예약 내용
	reserseq_contents varchar2(2000) NOT NULL,
	PRIMARY KEY (reserseq)
);


CREATE TABLE suggestion
(
	-- 민원시퀀스
	suggestionseq number NOT NULL,
	-- 건의 제목
	suggestion_title varchar2(200) NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 건의원 내용
	suggestion_contents varchar2(2000) NOT NULL,
	-- 건의 결과
	suggestion_result varchar2(2000),
	-- 접수 일자
	reception_date varchar2(40) NOT NULL,
	-- 처리 일자
	completion_date varchar2(40),
	-- 진행 상태
	progress_flag varchar2(10),
	PRIMARY KEY (suggestionseq)
);


CREATE TABLE suggreply
(
	-- 건의 댓글 시퀀스
	suggreplyseq number NOT NULL,
	-- 민원시퀀스
	suggestionseq number NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 건의 댓글 내용
	suggreply_contents varchar2(2000) NOT NULL,
	-- 건의 댓글 일시
	suggreply_date varchar2(40) NOT NULL,
	PRIMARY KEY (suggreplyseq)
);


CREATE TABLE sugrereply
(
	-- 건의 대댓글 시퀀스
	sugrereplyseq number NOT NULL,
	-- 건의 댓글 시퀀스
	suggreplyseq number NOT NULL,
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 칭찬 댓글 내용
	sugreplyre_contents varchar2(2000) NOT NULL,
	-- 건의 대댓글 일시
	sugreplyre_date varchar2(40) NOT NULL,
	PRIMARY KEY (sugrereplyseq)
);


CREATE TABLE tasukete_user
(
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 회원의 비밀번호
	userpwd varchar2(100) NOT NULL,
	-- 회원의 이름
	username varchar2(50) NOT NULL,
	-- 회원의 생일
	userbirth varchar2(50) NOT NULL,
	-- 회원의 핸드폰번호
	userphone varchar2(50) NOT NULL,
	-- 장애인 여부
	disabled varchar2(10) NOT NULL,
	-- 회원위치_X
	user_x varchar2(20),
	-- 회원위치_Y
	user_y varchar2(20),
	-- 칭찬 횟수
	compliment_count number DEFAULT 0,
	-- 매칭에 대한 상태정보
	matching_flag varchar2(20) DEFAULT '0',
	-- 상태A
	statA varchar2(20),
	-- 상태B
	statB varchar2(20),
	-- 상태C
	statC varchar2(20),
	PRIMARY KEY (userid)
);


CREATE TABLE user_auth
(
	-- 회원의 아이디
	userid varchar2(50) NOT NULL,
	-- 회원의 권한
	auth varchar2(20)
);



/* Create Foreign Keys */

ALTER TABLE compreply
	ADD CONSTRAINT compreply_complimentseq_fk FOREIGN KEY (complimentseq)
	REFERENCES compliment (complimentseq)
	ON DELETE CASCADE
;


ALTER TABLE comrereply
	ADD CONSTRAINT comprereply_compreplyseq_fk FOREIGN KEY (compreplyseq)
	REFERENCES compreply (compreplyseq)
	ON DELETE CASCADE
;


ALTER TABLE suggreply
	ADD CONSTRAINT suggreply_suggestionseq_fk FOREIGN KEY (suggestionseq)
	REFERENCES suggestion (suggestionseq)
	ON DELETE CASCADE
;


ALTER TABLE sugrereply
	ADD CONSTRAINT sugrereply_suggreplyseq_fk FOREIGN KEY (suggreplyseq)
	REFERENCES suggreply (suggreplyseq)
	ON DELETE CASCADE
;


ALTER TABLE blacklist
	ADD CONSTRAINT blacklist_userid_fk FOREIGN KEY (userid)
	REFERENCES tasukete_user (userid)
	ON DELETE CASCADE
;


ALTER TABLE compliment
	ADD CONSTRAINT compliment_userid_fk FOREIGN KEY (userid)
	REFERENCES tasukete_user (userid)
	ON DELETE CASCADE
;


ALTER TABLE notice
	ADD CONSTRAINT notice_userid_fk FOREIGN KEY (userid)
	REFERENCES tasukete_user (userid)
	ON DELETE CASCADE
;


ALTER TABLE report
	ADD CONSTRAINT report_userid_fk FOREIGN KEY (userid)
	REFERENCES tasukete_user (userid)
	ON DELETE CASCADE
;


ALTER TABLE request
	ADD CONSTRAINT request_userid_fk FOREIGN KEY (userid)
	REFERENCES tasukete_user (userid)
	ON DELETE CASCADE
;


ALTER TABLE reservations
	ADD CONSTRAINT reservation_userid_fk FOREIGN KEY (userid)
	REFERENCES tasukete_user (userid)
	ON DELETE CASCADE
;


ALTER TABLE suggestion
	ADD CONSTRAINT suggestion_userid_fk FOREIGN KEY (userid)
	REFERENCES tasukete_user (userid)
	ON DELETE CASCADE
;


ALTER TABLE user_auth
	ADD CONSTRAINT userauth_userid_fk FOREIGN KEY (userid)
	REFERENCES tasukete_user (userid)
	ON DELETE CASCADE
;



