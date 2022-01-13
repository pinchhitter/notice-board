CREATE TABLE users (
	UserName VARCHAR NOT NULL PRIMARY KEY, 
	Password VARCHAR NOT NULL, 
	name VARCHAR NOT NULL
);

CREATE TABLE center(
 centerCode VARCHAR PRIMARY KEY,
 centerName VARCHAR
);


CREATE TABLE notices(
	noticeId SERIAL PRIMARY KEY, 
	notice VARCHAR NOT NULL,
	start_date TIMESTAMP NOT NULL,
	end_date TIMESTAMP NOT NULL,
	center VARCHAR NOT NULL,
	creation_timestamp TIMESTAMP NOT NULL,
	created_by varchar NOT NULL,
	is_delete BOOLEAN NOT NULL DEFAULT FALSE,
	CONSTRAINT fk_center FOREIGN KEY(center) REFERENCES center( centerCode ),
	CONSTRAINT fk_created_by FOREIGN KEY(created_by) REFERENCES users( UserName )
);

CREATE TABLE birthday ( 
	emp_Id VARCHAR PRIMARY KEY, 
	employee_name VARCHAR, 
	email VARCHAR, 
	data_of_birth VARCHAR, 
	gender VARCHAR, 
	groupId VARCHAR
);
