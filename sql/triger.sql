use `mydb`;

drop trigger if exists provera_vremena;
drop trigger if exists dodaj_sprava;
drop trigger if exists dodaj_karton;
drop trigger if exists dodaj_prvi_karton;

delimiter $

create trigger provera_vremena before insert on Rasporedjena
for each row
begin
    if(exists(select * from Rasporedjena r where r.vremeKraja > new.vremePocetka and r.vremePocetka < new.vremePocetka and r.brojSale = new.brojSale))
    then
        signal sqlstate '45000' set message_text = 'U tom vremenskom interavlu vec postoji terapija, molimo unesite druge termine.';
    end if;
end;
$
/*
create trigger dodaj_sprava before insert on Sadrzaj
for each row
begin
    if(exists(select * from Sadrzaj where brojSale = new.brojSale and sifraSprava = new.sifraSprava))
    then
        set new.kolicina = new.kolicina + (select kolicina from Sadrzaj where brojSale = new.brojSale and sifraSprava = new.sifraSprava); 
        delete from Sadrzaj where brojSale = new.brojSale and sifraSprava = new.sifraSprava;
    end if;    
end;
$
*/
create trigger dodaj_karton before insert on Karton
for each row
begin
    if(exists(select * from Karton k where new.jmbg = k.jmbg))
    then set new.rbrPosete = 1 + (select max(rbrPosete) from Karton k where k.jmbg = new.jmbg);
    end if;
end;
$

create trigger dodaj_prvi_karton before insert on Karton
for each row
begin
    if(not exists(select * from Karton k where new.jmbg = k.jmbg))
    then 
        set new.rbrPosete = 1;
        set new.brUradjenih = 0;
    end if;
end;

$

delimiter ;




















