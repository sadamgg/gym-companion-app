BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS workout;
DROP TABLE IF EXISTS goal;
DROP TABLE IF EXISTS exercise;


--users - Contains users' info

CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	name varchar(50),
	email VARCHAR(100),
	photo VARCHAR(500),
	weight DECIMAL(5,2),
	height DECIMAL(5,2),
	sex VARCHAR(1), -- (M)ale, (F)emale, (O)ther
	bmi DECIMAL(5,2),
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

--sessions - Contains users' gym check in and duration

CREATE TABLE sessions (
session_id SERIAL,
user_id INT,
duration BIGINT,
date BIGINT, -- potentially a DATETIME?
CONSTRAINT PK_session PRIMARY KEY (session_id)
);

--exercise table containing list of exercises

CREATE TABLE exercise (
exercise_id SERIAL,
name VARCHAR(50),
photo VARCHAR(500),
description VARCHAR(1000),
gif VARCHAR(500),
CONSTRAINT PK_exercise PRIMARY KEY (exercise_id)
);

--workout - Contains users' specific workouts within a session


CREATE TABLE workout (
workout_id SERIAL,
session_id INT,
user_id INT,
exercise_id INT,
duration BIGINT,
weight DECIMAL(5,2),
sets INT,
reps INT,
CONSTRAINT PK_workout PRIMARY KEY (workout_id),
CONSTRAINT FK_session_workout FOREIGN KEY (session_id) REFERENCES sessions,
CONSTRAINT FK_user_workout FOREIGN KEY (user_id) REFERENCES users,
CONSTRAINT FK_workout_exercise FOREIGN KEY (exercise_id) REFERENCES exercise
);

--goal - Contains users' goals

CREATE TABLE goal (
 goal_id SERIAL,
 user_id INT,
 description VARCHAR(300),
 CONSTRAINT PK_goal PRIMARY KEY (goal_id),
 CONSTRAINT FK_user_goal FOREIGN KEY (user_id) REFERENCES users
);


COMMIT TRANSACTION;