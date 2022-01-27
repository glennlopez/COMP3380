USE [olympic]
GO

--DROP TABLE country
--DROP TABLE team_list
--DROP TABLE athlete
--DROP TABLE olympic_game
--DROP TABLE olympic_event
--DROP TABLE medal
--DROP TABLE attend
--DROP TABLE has
--DROP TABLE compete
--DROP TABLE win
--DROP TABLE athlete_age
--DROP TABLE athlete_participation


CREATE TABLE country (
	NOC char(3) not null,
	country char(200) null,
	PRIMARY KEY (NOC)
);

CREATE TABLE team_list (
	tID int not null, 
	NOC char(3) not null,
	team char(200) not null,
	PRIMARY KEY (tID),
	FOREIGN KEY (NOC) REFERENCES country(NOC)
);

CREATE TABLE athlete (
	aID int not null,
	aname char(200) null,
	asex char(1) null,
	aWeight char(200) null,       -- there is NA weight 
	aHeight char(200) null,       -- there is NA height
	tID int null,       
	PRIMARY KEY (aID),
	FOREIGN KEY (tID) REFERENCES team_list(tID)
);


CREATE TABLE olympic_game (
	gID int not null,
	gYear int null,
	season char(10) null,
	host_city char(200) null,
	PRIMARY KEY (gID)
);

CREATE TABLE olympic_event (
	eID int not null,
	sport char(200) null,
	eName char(200) null,
	PRIMARY KEY (eID)
);

CREATE TABLE medal (
	mID int not null,
	type char(10) null,
	PRIMARY KEY (mID)
);


CREATE TABLE athlete_participation (
	aID int not null,
	gID int not null,
	age char(200) null,                  -- there is NA age
	PRIMARY KEY (aID, gID),
	FOREIGN KEY (aID) REFERENCES athlete(aID),
	FOREIGN KEY (gID) REFERENCES olympic_game(gID)
);


CREATE TABLE attend (
	gID int not null,
	NOC char(3) not null,
	PRIMARY KEY (gID, NOC),
	FOREIGN KEY (gID) REFERENCES olympic_game(gID),
	FOREIGN KEY (NOC) REFERENCES country(NOC)
);

CREATE TABLE has (
	gID int not null,
	eID int not null,
	PRIMARY KEY (gID, eID),
	FOREIGN KEY (gID) REFERENCES olympic_game(gID),
	FOREIGN KEY (eID) REFERENCES olympic_event(eID)
);

CREATE TABLE compete (
	eID int not null,
	aID int not null,
	PRIMARY KEY (eID, aID),
	FOREIGN KEY (eID) REFERENCES olympic_event(eID),
	FOREIGN KEY (aID) REFERENCES athlete(aID)
);

CREATE TABLE win (
	eID int not null,
	gID int not null,
	aID int not null,
	mID int not null,
	PRIMARY KEY (eID, gID, aID),
	FOREIGN KEY (eID) REFERENCES olympic_event(eID),
	FOREIGN KEY (gID) REFERENCES olympic_game(gID),
	FOREIGN KEY (aID) REFERENCES athlete(aID),
	FOREIGN KEY (mID) REFERENCES medal(mID)
);