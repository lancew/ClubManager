CREATE TABLE Events
(
EventID INTEGER PRIMARY KEY,
ClubID INTEGER not null,
Type INTEGER default 1,
Name varchar(50) not null,
EventDate date,
Description varchar(50) not null,
Status INTEGER default 1,
Active Boolean default 1
);
