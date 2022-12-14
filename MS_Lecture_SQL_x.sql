create database lecture_db;

use lecture_db;

create table address(
id int not null primary key auto_increment, -- auto increment = sequencer
city varchar(255),
zip_code varchar(255) not null,
street varchar(255) -- default length 255
);
-- DROP TABLE :  remove the table
drop table address;  -- remove the table - to comment --

-- READ: retrives data from collection
select * from address;
select id , zip_code from address;
select id as AdressID, zip_code as AdressZipCode from address; -- alias name 

-- INSERT (insert rows with data into the table)
insert into address(CITY, ZIP_CODE) values('Växjö', '35264'); --  1
insert into address(CITY, ZIP_CODE) values('Växjö', '35252'); -- 2
insert into address(CITY, ZIP_CODE) values('test', '12345');  -- 3
insert into address(CITY, ZIP_CODE) values('Jönköping', '35246'); -- 4

-- UPDATE
update address set zip_code = '35252' where id = 3;

-- TRUNCATE ( remove all the table content - not the table)
truncate table address;

-- DELETE (remove one row)
delete from address where id = 3;

-- ALTER (change the structure of the table)
alter table address modify city varchar(40);
alter table address add street varchar (80) default 'Storgatan'; -- default = populate all the rows with that field value
alter table address drop street;

-- ONE TO ONE RELATIONSHIP -between tables (PERSON & ADDRESS)
create table person(
id int not null primary key auto_increment,
first_name varchar(255) not null,
last_name varchar(255) not null,
email varchar(255) not null unique,
birth_date date not null,
reg_date datetime default now(), -- now() - now datetime / current_timestamp -> in older versions of SQL
_active tinyint default false, -- tinyint = boolean // ctive is a reservoir and must modify the field name in the table
address_id int not null, 						-- a new field in order to link the tables person with the table address
foreign key(address_id) references address(id) 	-- declaring foreign key 
);

select*from person;
insert into person(first_name, last_name, email, birth_date, address_id) values("Mehrdad", "Javan", 'mehrdad.javan@lexicon.se','2020-01-01',1);
insert into person(first_name, last_name, email, birth_date, address_id) values('Simon', 'Elbrink', "simon.elbrink@lexicon.se",'2020-01-01',2);
insert into person(first_name, last_name, email, birth_date, address_id) values("Marcus", "Gudmunsen", 'marcus.gudmunsen@lexicon.se','2020-01-01',3);
insert into person(first_name, last_name, email, birth_date, address_id) values("test", "test", 'test.test@lexicon.se','2020-01-01',4);
drop table person;

-- ONE TO MANY RELATIONSHIP (PERSON & TASK) -> one person can have many tasks
create table task(
id int	not null	 primary key	auto_increment,
title varchar(255) not null,
_description varchar(255) not null, -- "description" is a reservoir
person_id int,
foreign key(person_id) references person(id)
);

select * from task;
insert into task (title, _description, person_id) values('workshop', 'sql', 1);
insert into task (title, _description) values('task2', 'test task'); -- assign to nobody (person_id) ->modified constructor
insert into task (title, _description, person_id) values('task 3', 'test task3', 1); -- assign again to person 1
insert into task (title, _description, person_id) values('task 4', 'test task4', 2);
insert into task (title, _description, person_id) values('task 5', 'test task 5', 4);

select * from task where id=10;			-- select 1 task
select * from task where id in (1,3);	-- select a list of tasks -> with "in"

select * from task where title ="workshop"; 	-- you have to write the exact word - title
select * from task where title like "t%"; 		-- all the task where title starts with t -> % = anything
select * from task where title like "%task%"; 	-- all the task where title contains "task"
select * from task where id = 1 and title = "workshop"; 	-- all the task where 2 conditions are met

select t.id, t.title, t._description from task t;

select * from task t inner join person p on t.person_id = p.id; 	-- joi the tables with a common key (person_id from task = id from person)
-- join / inner join -> combine to tables 
-- on -> condition
select t.id, t.title, p.email from task t inner join person p on t.person_id = p.id;  --  select only fields from description
-- task2 is not shown because it has no assigned person
select * from task t left join person p on t.person_id = p.id; -- task2 is shown now

-- MANY TO MANY RELATIONSHIP
-- we have to create an association table with 2 FK (one related to PersonID & one related to GroupID (for example))
-- in fact we have 2 relations one to many from association tabel with the two tabels

create table _group(
id int		not null		primary key		auto_increment,
group_name varchar(255) not null
);

 -- insert into _group(group_name) values("Java"); -> we can make the same using right click on tables name in SCHEMAS window (_group) and Select Rows
 -- then we can insert manually values
 


create table persons_groups(
id int	not null primary key	auto_increment,
person_id int not null,
group_id int not null,
foreign key (person_id) references person(id),
foreign key (group_id) references _group(id)
);

select * from persons_groups;


select * from _group;
select count(*) from person;
select sum(id) from person; -- for numbers
select avg(id) from person; -- for numbers


