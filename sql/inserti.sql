use `mydb`;

insert into Zaposlen(id, ime, prezime)
values  (0, 'Milan', 'Peric'), 
        (1, 'Ivan', 'Jovic'),
        (2, 'Ana', 'Ristic'),
        (3, 'Iva', 'Misic'),
        (4, 'Nikola', 'Jokic'),
        (5, 'Sava', 'Sevic');
        
insert into Fizioterapeut(datumZaposlenja, idFizioterapeuta)
values  ('2015-07-12', 0),
        ('2013-01-14', 1),
        ('2010-08-01', 2);
        
insert into Asistent(stepen, idAsistenta)
values  (1, 3),
        (2, 4),
        (3, 5);
        
insert into Pacijent(jmbg, ime, prezime, datumRodjenja, adresa, telefon, email)
values  ('2206958718253', 'Tijana', 'Djuric', '1958-06-22', 'Knjeginje Ljubice 3', '0663569821', 'tina@gmail.com'),
        ('2207991718253', 'Mina', 'Jocic', '1991-07-22', 'Ljutice Bogdana 9a', '0613569821', 'mina@gmail.com'),
        ('1006977718253', 'Jovan', 'Lakic', '1977-06-10', 'Ljubljanska 5', '0603569821', 'joca@gmail.com'),
        ('2206988718253', 'Vojislav', 'Rakic', '1988-06-22', 'Ivana Milutinovica 88', '0659969821', 'voja@gmail.com');
        
insert into Nadredjen(idFizioterapeuta, jmbg)
values  (0, '2206958718253'),
        (1, '2207991718253'),
        (2, '1006977718253'),
        (0, '2206988718253');
        
insert into Karton(jmbg, rbrPosete, dijagnoza, brTerapija, brUradjenih)
values  ('2206958718253', 1, 'Kriva kicma, terapija ledja', 5, 0),
        ('2207991718253', 1, 'Iskakanje casice kolena, terapija kolena', 3, 3),
        ('2207991718253', 2, 'Istezanje podlaktice, terapija podlaktice', 4, 2),
/*        ('2207991718253', 5, 'Povreda ledja, terapija ledja', 4, 0),*/
        ('1006977718253', 1, 'Oporavak nakon slomljenog zgloba, terapija zgloba noge', 5, 5),
        ('2206988718253', 1, 'Povreda lakta, terapija lakta', 3, 0);
        
insert into Terapija(naziv, vremeTrajanja, idFizioterapeuta)
values  ('Terapija kolena', 2, 0),
        ('Terapija zgloba noge', 1, 0),
        ('Terapija stopala', 1, 0),
        ('Terapija lakta', 2, 1),
        ('Terapija nadlaktice', 1, 1),
        ('Terapija podlaktice', 1, 1),
        ('Terapija ledja', 3, 2);
        
insert into Sala(broj, idAsistenta)
values  (1, 3),
        (2, 3),
        (3, 3),
        (4, 4),
        (5, 4),
        (6, 5);
        
insert into Rasporedjena(vremePocetka, vremeKraja, nazivTerapije, brojSale)
values  ('8:00','11:00' , 'Terapija ledja', 1),
/*	('10:00','11:00' , 'Terapija ledja', 1),*/
        ('8:00', '10:00', 'Terapija kolena', 2),
        ('10:00', '11:00', 'Terapija zgloba noge', 2),
        ('11:00', '12:00', 'Terapija stopala', 3), 
        ('8:00', '10:00', 'Terapija lakta', 4), 
        ('10:00', '11:00', 'Terapija nadlaktice', 4), 
        ('11:00', '12:00', 'Terapija podlaktice', 4),
        ('9:00', '12:00', 'Terapija ledja', 6);

insert into Sprava(sifra, naziv)
values  (111, 'Teg 1kg'),
        (112, 'Teg 2kg'),
        (115, 'Teg 5kg'),
        (110, 'Gumena traka'),
        (113, 'Oklagija'),
        (114, 'Strunjaca'),
        (116, 'Sprava za ledja'),
        (117, 'Sprava za kolena');
        
insert into Sadrzaj(kolicina, brojSale, sifraSprava) 
values  (15, 1, 111),
        (10, 1, 112),
        (1, 1, 116),
        (1, 2, 117),
        (4, 2, 110),
        (4, 4, 113);
        
insert into Zamena(sifraSprave1, sifraSprave2)
values  (112, 111),
        (115, 111), 
        (113, 110);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
