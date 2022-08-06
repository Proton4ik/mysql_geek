use vk;
show tables;

desc users;
select * from users limit 10;
update users set updated_at = now() where updated_at < created_at;

desc profiles;
select * from profiles limit 10;
update profiles set updated_at = now() where updated_at < created_at;
update profiles set last_login = now() where last_login < updated_at;
create temporary table mf (sex varchar(1));
insert into mf values ('m'), ('f');
update profiles set gender = (select sex from mf order by rand() limit 1);
alter table profiles modify column gender enum('m', 'f');


desc messages;
select * from messages limit 10;

update messages set
	from_user_id = floor(1 + rand() * 100),
	to_user_id = floor(1 + rand() * 100);

desc media;
select * from media limit 10;

update media set
	user_id = floor(1 + rand() * 100);
update media set updated_at = now() where updated_at < created_at;
create temporary table extensions (name varchar(10));
insert into extensions values ('jpeg'), ('mp3'), ('mp4'), ('avi');

update media set filename =concat (
	'http://www.dropbox.net/vk',
	filename, 
	'.',
	(select name from extensions order by rand() limit 1));

update media set size = floor(10000 + rand() * 1000000) where size < 10000;

update media set metadata = concat (
	'{"owner":"',
	(select concat(first_name, ' ', last_name) from users where id = user_id),
	'"}');

truncate media_types;
insert into media_types (name) values
	('photo'),
	('audio'),
	('video');
select * from media_types;
update media set media_type_id = floor(1 + rand() * 3);
alter table media modify column metadata JSON;

desc friendship;
alter table friendship drop column requested_at;
select * from friendship limit 10;
update friendship set updated_at = now() where updated_at < created_at;
update friendship set confirmed_at = now() where confirmed_at < created_at;

update friendship set
	user_id = floor(1 + rand() * 100),
	friend_id = floor(1 + rand() * 100);


truncate friendship_statuses;
insert into friendship_statuses (name) values
	('Requested'),
	('Confirmed'),
	('Rejected');

update friendship set friendship_status_id = floor(1 + rand() * 3);

desc communities;
select * from communities;
update communities set updated_at = now() where updated_at < created_at;
delete from communities where id > 30;


select * from communities_users;
update communities_users set
	user_id = floor(1 + rand() * 100),
	community_id = floor(1 + rand() * 30);