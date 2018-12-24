use mydb;

drop trigger if exists provera_vrem;
drop trigger if exists dodaj_sprava;
drop trigger if exists dodaj_karton;

delimiter $

create trigger provera_vrem before insert into Rasporedjena
for each row
begin
    if(exists(select * from Rasporedjena r where r.vremeKraja > new.vremePocetka))
    then
        signal sqlstate '45000' set message_text = 'U tom vremenskom interavlu vec postoji terapija, molimo unesite druge termine.';
    end if;
end$

create trigger dodaj_sprava before insert into Sadrzaj
for each row
begin
    if(exists(select * from Sadrzaj s where s.brojSale = new.brojSale and s.sifraSprava = new.sifraSprava))
    then update Sadrzaj set kolicina = old.kolicina + new.kolicina;
    end if;
end$

create trigger dodaj_karton before insert into Karton
for each row
begin
    if(new.jmbg = (select jmbg from Karton))
    then set new.rbrPosete = old.rbrPosete+1;    /*da li moze ovako*/
    end if;
end$