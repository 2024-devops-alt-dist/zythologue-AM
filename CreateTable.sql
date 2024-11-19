create table Brewery (
	id serial primary key,
	name varchar(100) not null,
	description text not null,
	adress varchar(100) not null,
	country varchar(100) not null,
);

create table beer (
	id serial primary key,
	name varchar(100) not null,
	description text,
	abv decimal not null,
	price int not null,
	id_brewery int not null,
	constraint fk_brewery foreign key(id_brewery) references brewery(id)
	on delete cascade
);

create table category (
    id serial primary key,
    nam varchar(100) not null,
    flavor varchar(100) not null,
);

create table category_beer (
    id serial primary key,
    color varchar(100) not null,
    id_category int not null,
    id_beer int not null,
    constraint fk_category foreign key(id_category) references category(id)
    on delete cascade
    constraint fk_beer foreign key(id_beer) references beer(id)
    on delete cascade
);

create table ingrdient_beer (
    id serial primary key,
    pourcent decimal not null,
    id_ingredient int not null,
    id_beer int not null,
    constraint fk_ingredient foreign key(id_ingredient) references ingredient(id)
    on delete cascade
    constraint fk_beer foreign key(id_beer) references beer(id)
    on delete cascade
);


create table ingredient (
    id serial primary key,
    name varchar(100) not null,
    type varchar(100) not null,
);

create table user (
    id serial primary key,
    name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(300) not null,
    password varchar(100) not null,
    statut boolean
);

create table review (
	id serial primary key,
	rating int not null,
	comment text,
	date_created timestamp not null,
	id_user int not null,
    id_beer int not null,
	constraint fk_user foreign key(id_user) references user(id)
	on delete cascade,
    constraint fk_beer foreign key(id_beer) references beer(id)
	on delete cascade
);

create table favorite(
    id serial primary key,
    date_added timestamp not null,
    id_users int not null,
    id_beer int not null,
    constraint fk_users foreign key (id_users) references users(id)
    on delete cascade,
    constraint fk_beer foreign key(id_beer) references beer(id)
    on delete cascade
);

create table photos(
    id serial primary key,
    url varchar(1000) not null,
    date_uploaded timestamp not null,
    id_beer int not null,
    constraint fk_beer foreign key (id_beer) references beer(id)
    on delete cascade
);