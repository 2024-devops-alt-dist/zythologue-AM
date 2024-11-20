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
    name varchar(100) not null,
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

INSERT INTO Brewery (name, description, adress, country)
VALUES
    ('Hoppy Haven', 'A modern craft brewery specializing in hoppy IPAs and experimental ales.', '123 Brew Street, Portland', 'USA'),
    ('Golden Grain Brewery', 'Traditional brewery known for its premium lagers and wheat beers.', '45 Brewer Lane, Munich', 'Germany'),
    ('Mountain Malt Makers', 'Family-owned brewery crafting beers with locally sourced ingredients.', '78 Alpine Road, Interlaken', 'Switzerland'),
    ('Sakura Suds', 'Innovative brewery blending Japanese brewing traditions with modern techniques.', '9 Cherry Blossom Avenue, Kyoto', 'Japan'),
    ('Celtic Craft Brews', 'Rustic brewery focused on Irish ales and stouts with a twist.', '21 Shamrock Drive, Dublin', 'Ireland');

    INSERT INTO beer (name, description, abv, price, id_brewery)
VALUES
    ('Hoppy IPA', 'A bold and citrusy IPA with strong hoppy notes.', 6.5, 5, 1),
    ('Golden Lager', 'A smooth and crisp lager with a golden hue.', 4.8, 4, 2),
    ('Alpine Ale', 'A refreshing ale brewed with mountain herbs.', 5.3, 6, 3),
    ('Sakura Saison', 'A light saison with hints of cherry blossoms.', 5.5, 7, 4),
    ('Celtic Stout', 'A rich and creamy stout with chocolate undertones.', 6.0, 6, 5);

INSERT INTO category (name, flavor)
VALUES
    ('IPA', 'Hoppy and bitter'),
    ('Lager', 'Crisp and clean'),
    ('Stout', 'Rich and creamy'),
    ('Saison', 'Fruity and spicy'),
    ('Wheat Beer', 'Smooth and citrusy');

    INSERT INTO category_beer (color, id_category, id_beer)
VALUES
    ('Golden', 1, 1), -- IPA associée à "Hoppy IPA"
    ('Pale Yellow', 2, 2), -- Lager associée à "Golden Lager"
    ('Dark Brown', 3, 5), -- Stout associée à "Celtic Stout"
    ('Light Amber', 4, 4), -- Saison associée à "Sakura Saison"
    ('Hazy Yellow', 5, 3); -- Wheat Beer associée à "Alpine Ale"

    INSERT INTO ingredient (name, type)
VALUES
    ('Cascade Hops', 'Hop'),
    ('Pilsner Malt', 'Malt'),
    ('Wheat', 'Grain'),
    ('Yeast S-04', 'Yeast'),
    ('Coriander', 'Spice');

    INSERT INTO ingrdient_beer (pourcent, id_ingredient, id_beer)
VALUES
    (60.0, 2, 1),
    (35.0, 1, 1), 
    (5.0, 4, 1),
    (70.0, 2, 2), 
    (30.0, 4, 2);

INSERT INTO user (name, last_name, email, password, statut)
VALUES
    ('Alice', 'Smith', 'alice.smith@example.com', 'password123', true),
    ('Bob', 'Johnson', 'bob.johnson@example.com', 'securepass456', true),
    ('Charlie', 'Brown', 'charlie.brown@example.com', 'mypassword789', false),
    ('Diana', 'Prince', 'diana.prince@example.com', 'wonderwoman321', true),
    ('Eve', 'Taylor', 'eve.taylor@example.com', 'supersecret999', false);

    INSERT INTO review (rating, comment, date_created, id_user, id_beer)
VALUES
    (5, 'Excellent IPA with a perfect balance of hops and flavor!', '2024-11-20 10:30:00', 1, 1),
    (4, 'A very refreshing lager, ideal for summer evenings.', '2024-11-19 18:45:00', 2, 2),
    (3, 'Decent stout, but could use a bit more creaminess.', '2024-11-18 14:20:00', 3, 5),
    (5, 'Amazing saison with subtle hints of cherry blossom.', '2024-11-17 12:10:00', 4, 4),
    (4, 'Solid wheat beer, smooth with a nice citrus finish.', '2024-11-16 09:15:00', 5, 3);

    INSERT INTO favorite (date_added, id_users, id_beer)
VALUES
    ('2024-11-20 12:00:00', 1, 1), -- Alice a ajouté "Hoppy IPA" à ses favoris.
    ('2024-11-19 15:30:00', 2, 2), -- Bob a ajouté "Golden Lager" à ses favoris.
    ('2024-11-18 10:45:00', 3, 5), -- Charlie a ajouté "Celtic Stout" à ses favoris.
    ('2024-11-17 11:20:00', 4, 4), -- Diana a ajouté "Sakura Saison" à ses favoris.
    ('2024-11-16 09:50:00', 5, 3); -- Eve a ajouté "Alpine Ale" à ses favoris.

    INSERT INTO photos (url, date_uploaded, id_beer)
VALUES
    ('https://example.com/photos/hoppy_ipa.jpg', '2024-11-20 13:00:00', 1), -- Photo de "Hoppy IPA"
    ('https://example.com/photos/golden_lager.jpg', '2024-11-19 16:30:00', 2), -- Photo de "Golden Lager"
    ('https://example.com/photos/celtic_stout.jpg', '2024-11-18 12:00:00', 5), -- Photo de "Celtic Stout"
    ('https://example.com/photos/sakura_saison.jpg', '2024-11-17 10:30:00', 4), -- Photo de "Sakura Saison"
    ('https://example.com/photos/alpine_ale.jpg', '2024-11-16 14:00:00', 3); -- Photo de "Alpine Ale"





