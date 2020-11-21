create table basic_fare
(
    id SERIAL NOT NULL,
    destination varchar(20) UNIQUE NOT NULL,
    amount int NOT NULL,
    PRIMARY KEY (id)
)
;

create table basic_super_express_surcharge
(
    id SERIAL NOT NULL,
    train_type varchar(20) NOT NULL,
    seat_type varchar(20) NOT NULL,
    destination varchar(20) NOT NULL,
    amount int NOT NULL,
    PRIMARY KEY (id)
)
;

create table business_kilometer
(
    id SERIAL NOT NULL,
    destination varchar(20) UNIQUE NOT NULL,
    distance int NOT NULL,
    PRIMARY KEY (id)
)
;

