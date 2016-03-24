drop database erhuo;
create database erhuo character set utf8;
use erhuo;

create table users(
	id int primary key auto_increment,
	identity varchar(20) unique not null,
	pwd varchar(50) not null,
	photo varchar(200),
	name varchar(20),
	sex int,
	jifen int,
	invcode varchar(120) unique
);

create table types(
	id int primary key auto_increment,
	name varchar(20),
	url varchar(200)
);

create table markets(
	id int primary key auto_increment,
	name varchar(20) not null,
	usercount int,
	goodscount int,
	url varchar(200),
	brief varchar(500)
);



create table goods(
	id int primary key auto_increment,
	userid int ,
	name varchar(20),
	imformation varchar(500),
	typeid int ,
	soldprice double,
	buyprice double,
	marketid int ,
	longitude double,
	latitude double,
	pubtime date,
	state int,
	foreign key(userid) references users(id) on delete cascade,
	foreign key(typeid) references types(id) on delete set null,
	foreign key(marketid) references markets(id) on delete set null	
);

create table orders(
	id int primary key auto_increment,
	goodid int unique,
	userid int ,
	ordernum varchar(50) unique not null,
	createtime datetime not null,
	paytime datetime,
	sendtime datetime,
	completetime datetime,
	status int not null,
	logisticscom varchar(20),
	logisticsnum varchar(100),
	foreign key(goodid) references goods(id) on delete cascade,
	foreign key(userid) references users(id) on delete cascade
);

create table helps(
	id int primary key auto_increment,
	userid int ,
	title varchar(50),
	detail varchar(500),
	pubtime datetime,
	state int 
);

create table donates(
	id int primary key auto_increment,
	helpid int ,
	userid int,
	dontime datetime,
	logisticscom varchar(20),
	logisticsnum varchar(100),
	foreign key(helpid) references helps(id) on delete cascade,
	foreign key(userid) references users(id) on delete cascade
);



create table goodsreports(
	id int primary key auto_increment,
	goodid int,
	brief varchar(500),
	reptime datetime,
	state int,
	foreign key(goodid) references goods(id) on delete cascade
);

create table helpsreports(
	id int primary key auto_increment,
	helpid int,
	brief varchar(500),
	reptime datetime,
	state int,
	foreign key(helpid) references helps(id) on delete cascade
);

create table messages(
	id int primary key auto_increment,
	goodid int ,
	sendid int ,
	receiveid int ,
	words varchar(200),
	sendtime datetime,
	foreign key(goodid) references goods(id) on delete cascade,
	foreign key(sendid) references users(id) on delete cascade,
	foreign key(receiveid) references users(id) on delete cascade
);

create table prizegoods(
	id int primary key auto_increment,
	name varchar(50) not null,
	detail varchar(200),
	price int not null,
	count int
);

create table goodsimages(
	id int primary key auto_increment,
	goodid int ,
	url varchar(200) unique not null,
	foreign key(goodid) references goods(id) on delete cascade
);
create table helpsimages(
	id int primary key auto_increment,
	helpid int ,
	url varchar(200) unique not null,
	foreign key(helpid) references helps(id) on delete cascade
);
create table pgoodsimages(
	id int primary key auto_increment,
	pgoodid int ,
	url varchar(200) unique not null,
	foreign key(pgoodid) references prizegoods(id) on delete cascade
);

create table address(
	id int primary key auto_increment,
	userid int ,
	name varchar(20) not null,
	phone varchar(20) not null,
	address varchar(200) not null,
	isdefault varchar(8) ,
	foreign key(pgoodid) references prizegoods(id) on delete cascade
);

create table collections(
	userid int ,
	goodid int ,
	coltime datetime,
	primary key(userid,goodid),
	foreign key(userid) references users(id) on delete cascade,
	foreign key(goodid) references goods(id) on delete cascade
);

create table usermarket(
	userid int ,
	marketid int ,
	foctime datetime,
	primary key(userid,marketid),
	foreign key(userid) references users(id) on delete cascade,
	foreign key(marketid) references markets(id) on delete cascade
);
