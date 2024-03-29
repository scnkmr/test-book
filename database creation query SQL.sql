/* Creating DAtabase and tables */
create DATABASE tb
use tb
CREATE TABLE Users (
    Userid int NOT NULL AUTO_INCREMENT,
    Email varchar(255) NOT NULL,
    Password varchar(255) NOT NULL,
    Verefied enum('Yes','No'),
    LastName varchar(255),
    FirstName varchar(255),
    PRIMARY KEY (Userid)
)
alter table users
ADD time_stamp timestamp

CREATE TABLE tests (
Testid int unsigned NOT NULL AUTO_INCREMENT,
  Title varchar(600),
  StartAt varchar(50),
  Duration varchar(50),
  Userid int,
  PRIMARY KEY(Testid),
  FOREIGN KEY(Userid) REFERENCES users(Userid)
)
alter table tests
ADD time_stamp timestamp

CREATE TABLE questions(
  Questionid int UNSIGNED NOT NULL AUTO_INCREMENT,
  Question varchar(600) NOT NULL,
  Type enum('short','mcq') NOT NULL,
  Marks int(50),
  Testid int unsigned,
  PRIMARY KEY(Questionid),
  FOREIGN KEY(Testid) REFERENCES tests(Testid)
)

CREATE TABLE options(
  Optionid int UNSIGNED NOT NULL AUTO_INCREMENT,
  Optiontext varchar(255) NOT NULL,
  Questionid int unsigned,
  PRIMARY KEY(Optionid),
  FOREIGN KEY(Questionid) REFERENCES questions(Questionid)
)

CREATE TABLE Rightoption(
  Rightoptionid int UNSIGNED NOT NULL AUTO_INCREMENT,
  Optionid int unsigned,
  Questionid int unsigned,
  PRIMARY KEY(Rightoptionid),
  FOREIGN KEY(Optionid) REFERENCES options(Optionid),
  FOREIGN KEY(Questionid) REFERENCES questions(Questionid)
)

CREATE TABLE Rightanswer(
  Rightanswerid int UNSIGNED NOT NULL AUTO_INCREMENT,
  Answer varchar(255),
  Questionid int unsigned,
  PRIMARY KEY(Rightanswerid),
  FOREIGN KEY(Questionid) REFERENCES questions(Questionid)
)

CREATE TABLE responses(
  Responseid int UNSIGNED NOT NULL AUTO_INCREMENT,
  MarksObtained int(50),
  Questionid int unsigned,
  Optionid int unsigned,
  Testid int unsigned,
  ShortAnswer char(255),
  Time_stamp timestamp,
  PRIMARY KEY(Responseid),
  FOREIGN KEY(Questionid) REFERENCES questions(Questionid),
  FOREIGN KEY(Optionid) REFERENCES options(Optionid),
  FOREIGN KEY(Testid) REFERENCES tests(Testid)
)

/* Query Design */
SELECT Title,StartAt,Duration from tests WHERE Testid = 1