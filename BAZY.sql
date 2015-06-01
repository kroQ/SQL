--@"C:\Users\bazy_danych_2\Downloads\BAZY.sql"
--@"D:\KrokMateusz\BAZY.sql"
--@"C:\Users\mati\Desktop\BAZY.sql"
clear screen;

DELETE FROM WYPOZYCZENIA;
drop table WYPOZYCZENIA;

DELETE FROM PLATNOSC;
drop table PLATNOSC;

DELETE FROM FAKTURA;
drop table FAKTURA;

DELETE FROM POZYCJE_WYPOZYCZENIA;
drop table POZYCJE_WYPOZYCZENIA;

DELETE FROM REZERWACJA;
drop table REZERWACJA;

DELETE FROM KATEGORIE;
drop table KATEGORIE;

DELETE FROM KLIENCI;
drop table KLIENCI;

DELETE FROM FIRMA;
drop table FIRMA;

DELETE FROM PRACOWNICY;
drop table PRACOWNICY;

DELETE FROM ADRES;
drop table ADRES;

DELETE FROM SPRZET;
drop table SPRZET;


--W GWARANCJI MA BYC TYP DATE TYLKO CHWILOWO DALEM VARCHAR 

create table SPRZET ( 
SPRk_1_Id            	 number(4)           NOT NULL, 
SPR_Typ         		 varchar2(20)  		 NOT NULL, 
SPR_Marka        		 varchar2(20)  		 NOT NULL, 
SPR_Ilosc          		 number(3), 
SPR_Gwarancja   		 varchar2(20),
SPR_Cena        		 number(4),
SPR_Kaucja				 number(4)
); 

alter table SPRZET add constraint CSR_PK_SPRZET 
primary key (SPRk_1_Id);

create table ADRES (
ADRk_1_Id				number(4)			NOT NULL,
ADR_Miasto				varchar2(20)		NOT NULL,
ADR_Ulica				varchar2(20),
ADR_NrMieszkania		varchar2(7),
ADR_KodPocztowy			varchar2(7)
);

alter table ADRES add constraint CSR_PK_ADRES
primary key (ADRk_1_Id);

create table PRACOWNICY( 
PRAk_1_Id            	number(4)    		NOT NULL, 
PRA_Imie				varchar2(20) 		NOT NULL,
PRA_Nazwisko			varchar2(30) 		NOT NULL,
PRA_Stanowisko			varchar2(30),
PRA_Telefon				number(12),
ADR_Id				number(4) 				NOT NULL
);

alter table PRACOWNICY add constraint CSR_PK_PRACOWNICY
primary key (PRAk_1_Id); 

alter table PRACOWNICY add constraint CSR_FK_PRACOWNICY_ADR
foreign key (ADR_Id)
references ADRES (ADRk_1_Id);

create table FIRMA (
FIRk_1_Id				number(4)			NOT NULL,
FIR_Nazwa				varchar2(20)		NOT NULL,
FIR_Nip					varchar2(15)			NOT NULL,
FIR_Regon				number(10),
ADR_Id				number(4) 				NOT NULL 
);

alter table FIRMA add constraint CSR_PK_FIRMA
primary key (FIRk_1_Id); 

alter table FIRMA add constraint CSR_FK_FIRMA_ADR
foreign key (ADR_Id)
references ADRES (ADRk_1_Id);

create table KLIENCI (
KLIk_1_Id				number(4)			NOT NULL,
KLI_Imie				varchar2(20),
KLI_Nazwisko			varchar2(20),
KLI_DowodOsobisty		varchar2(10),
FIR_Id				number(4) 			NOT NULL
);

alter table KLIENCI add constraint CSR_PK_KLIENCI
primary key (KLIk_1_Id); 

alter table KLIENCI add constraint CSR_FK_KLIENCI_FIR
foreign key (FIR_Id)
references FIRMA (FIRk_1_Id);

create table KATEGORIE (
KATk_1_Id				number(4)				NOT NULL,
KAT_Rodzaj				varchar(20),
KAT_Opis				varchar(30),
SPR_Id					number(4) 				NOT NULL
);

alter table KATEGORIE add constraint CSR_PK_KATEGORIE
primary key (KATk_1_Id); 

alter table KATEGORIE add constraint CSR_FK_KATEGORIE_SPR
foreign key (SPR_Id)
references SPRZET (SPRk_1_Id);

-- REZ_DATA ma byc typu date ale poki co jest varchar2!!!!----------------------

create table REZERWACJA(
REZk_1_Id			number(4)			NOT NULL,
REZ_Data			varchar2(10),
REZ_Ile_Dni			number(4),
REZ_Ile_Sztuk		number(4),
KLI_Id				number(4) 	NOT NULL,
SPR_Id			number(4)		NOT NULL
);

alter table REZERWACJA add constraint CSR_PK_REZERWACJA
primary key (REZk_1_Id); 

alter table REZERWACJA add constraint CSR_FK_REZERWACJA_KLI
foreign key (KLI_Id)
references KLIENCI (KLIk_1_Id);

alter table REZERWACJA add constraint CSR_FK_REZERWACJA_SPR
foreign key (SPR_Id)
references SPRZET (SPRk_1_Id);


create table POZYCJE_WYPOZYCZENIA(
POZk_1_Id			number(4)			NOT NULL,
POZ_Rabat			number(4),
POZ_Ilosc_Sztuk		number(4)			NOT NULL,
SPR_Id			number(4) 			NOT NULL
);

alter table POZYCJE_WYPOZYCZENIA add constraint CSR_PK_POZYCJE_WYPOZYCZENIA
primary key (POZk_1_Id); 

alter table POZYCJE_WYPOZYCZENIA add constraint CSR_FK_POZYCJE_SPR
foreign key (SPR_Id)
references SPRZET (SPRk_1_Id);

-- FAK_Data_Wystawienia ma byc typu date ale poki co jest varchar2!!!!----------------------

create table FAKTURA(
FAKk_1_Id				number(4)			NOT NULL,
FAK_Data_Wystawienia	varchar2(20)		NOT NULL,
FAK_Numer				number(4)			NOT NULL,
KLI_Id					number(4) 			NOT NULL,
POZ_Id					number(4)			NOT NULL
);

alter table FAKTURA add constraint CSR_PK_FAKTURA
primary key (FAKk_1_Id); 

alter table FAKTURA add constraint CSR_FK_FAKTURA_POZ
foreign key (POZ_Id)
references POZYCJE_WYPOZYCZENIA (POZk_1_Id);

alter table FAKTURA add constraint CSR_FK_FAKTURA_KLI
foreign key (KLI_Id)
references KLIENCI (KLIk_1_Id);

-- PLA_Data ma byc typu date ale poki co jest varchar2!!!!----------------------

create table PLATNOSC(
PLAk_1_Id				number(4)			NOT NULL,
PLA_Zaliczka			number(4),
PLA_Data				varchar2(15),
PRA_Id				number(4)			NOT NULL,
KLI_Id				number(4)			NOT NULL
);

alter table PLATNOSC add constraint CSR_PK_PLATNOSC
primary key (PLAk_1_Id); 

alter table PLATNOSC add constraint CSR_FK_PLATNOSC_KLI
foreign key (KLI_Id)
references KLIENCI (KLIk_1_Id);

alter table PLATNOSC add constraint CSR_FK_PLATNOSC_PRA
foreign key (PRA_Id)
references PRACOWNICY (PRAk_1_Id);

-- WYP_Data_Oddania ma byc typu date ale poki co jest varchar2!!!!----------------------

create table WYPOZYCZENIA( 
WYPk_1_Id 				number(4) NOT NULL,
WYP_Data_Oddania		varchar2(15),
WYP_Wartosc_Brutto		number(4) NOT NULL,
FAK_Id					number(4) NOT NULL,
PRA_Id 					number(4) NOT NULL
);

alter table WYPOZYCZENIA add constraint CSR_PK_WYPOZYCZENIA
primary key (WYPk_1_Id);

alter table WYPOZYCZENIA add constraint CSR_FK_WYPOZYCZENIA_FAK
foreign key (FAK_Id)
references FAKTURA (FAKk_1_Id);

alter table WYPOZYCZENIA add constraint CSR_FK_WYPOZYCZENIA_PRA
foreign key (PRA_Id)
references PRACOWNICY (PRAk_1_Id);



describe SPRZET;
describe ADRES;
describe FIRMA;
describe KLIENCI;
describe PRACOWNICY;
describe REZERWACJA;
describe KATEGORIE;
describe POZYCJE_WYPOZYCZENIA;
describe FAKTURA;
describe WYPOZYCZENIA;
describe PLATNOSC;


drop sequence SEQ_SPRZET;
--
create sequence SEQ_SPRZET increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_ADRES;
--
create sequence SEQ_ADRES increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_FIRMA;
--
create sequence SEQ_FIRMA increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_KLIENCI;
--
create sequence SEQ_KLIENCI increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_PRACOWNICY;
--
create sequence SEQ_PRACOWNICY increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_REZERWACJA;
--
create sequence SEQ_REZERWACJA increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_KATEGORIE;
--
create sequence SEQ_KATEGORIE increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_POZYCJE_WYPOZYCZENIA;
--
create sequence SEQ_POZYCJE_WYPOZYCZENIA increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_FAKTURA;
--
create sequence SEQ_FAKTURA increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_WYPOZYCZENIA;
--
create sequence SEQ_WYPOZYCZENIA increment by 1 start with 1
maxvalue 9999999999 minvalue 1;

drop sequence SEQ_PLATNOSC;
--
create sequence SEQ_PLATNOSC increment by 1 start with 1
maxvalue 9999999999 minvalue 1;



create or replace trigger T_BI_SPRZET
before insert on SPRZET
for each row
begin
if :new.SPRk_1_Id is NULL then
SELECT SEQ_SPRZET.nextval INTO :new.SPRk_1_Id FROM dual;
end if;
end;
/


create or replace trigger T_BI_ADRES
before insert on ADRES
for each row
begin
if :new.ADRk_1_Id is NULL then
SELECT SEQ_ADRES.nextval INTO :new.ADRk_1_Id FROM dual;
end if;
end;
/

create or replace trigger T_BI_FIRMA
before insert on FIRMA
for each row
begin
if :new.FIRk_1_Id is NULL then
SELECT SEQ_FIRMA.nextval INTO :new.FIRk_1_Id FROM dual;
end if;
end;
/

create or replace trigger T_BI_KLIENCI
before insert on KLIENCI
for each row
begin
if :new.KLIk_1_Id is NULL then
SELECT SEQ_KLIENCI.nextval INTO :new.KLIk_1_Id FROM dual;
end if;
end;
/

create or replace trigger T_BI_PRACOWNICY
before insert on PRACOWNICY
for each row
begin
if :new.PRAk_1_Id is NULL then
SELECT SEQ_PRACOWNICY.nextval INTO :new.PRAk_1_Id FROM dual;
end if;
end;
/

create or replace trigger T_BI_REZERWACJA
before insert on REZERWACJA
for each row
begin
if :new.REZk_1_Id is NULL then
SELECT SEQ_REZERWACJA.nextval INTO :new.REZk_1_Id FROM dual;
end if;
end;
/


create or replace trigger T_BI_KATEGORIE
before insert on KATEGORIE
for each row
begin
if :new.KATk_1_Id is NULL then
SELECT SEQ_KATEGORIE.nextval INTO :new.KATk_1_Id FROM dual;
end if;
end;
/


create or replace trigger T_BI_POZYCJE_WYPOZYCZENIA
before insert on POZYCJE_WYPOZYCZENIA
for each row
begin
if :new.POZk_1_Id is NULL then
SELECT SEQ_POZYCJE_WYPOZYCZENIA.nextval INTO :new.POZk_1_Id FROM dual;
end if;
end;
/


create or replace trigger T_BI_FAKTURA
before insert on FAKTURA
for each row
begin
if :new.FAKk_1_Id is NULL then
SELECT SEQ_FAKTURA.nextval INTO :new.FAKk_1_Id FROM dual;
end if;
end;
/


create or replace trigger T_BI_WYPOZYCZENIA
before insert on WYPOZYCZENIA
for each row
begin
if :new.WYPk_1_Id is NULL then
SELECT SEQ_WYPOZYCZENIA.nextval INTO :new.WYPk_1_Id FROM dual;
end if;
end;
/


create or replace trigger T_BI_PLATNOSC
before insert on PLATNOSC
for each row
begin
if :new.PLAk_1_Id is NULL then
SELECT SEQ_PLATNOSC.nextval INTO :new.PLAk_1_Id FROM dual;
end if;
end;
/

-- TABELA SPRZET:

-- FORMATOWANIE:
column SPRk_1_Id	heading 'ID' format 99;
column SPR_Typ		heading 'Typ' format a6;
column SPR_Marka 	heading 'Marka' format a9;
column SPR_Ilosc 	heading	'Ilosc' format 99;
column SPR_Gwarancja heading 'Gwarancja' format a11;
column SPR_Cena		heading	'Cena (zl)' format 9999;
column SPR_Kaucja	heading	'Kaucja' format 9999;



-- INSERTY:
create or replace procedure spr_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into SPRZET
			(SPR_Typ,SPR_Marka,SPR_Ilosc,SPR_Gwarancja,SPR_Cena,SPR_Kaucja)
			values ('Typ'||licznik,'Marka'||licznik,(licznik*10)-2,'Gwarancja'||licznik,licznik*24,licznik*7);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	spr_wstaw(10);
end;
/	


-- UPDATE'Y:

update SPRZET set SPR_Typ			 = 'Pila' 	where SPRk_1_Id = 2;
update SPRZET set SPR_Marka 		 = 'Bosh' 	where SPRk_1_Id = 4;
update SPRZET set SPR_Ilosc 		 = '3' 		where SPRk_1_Id = 6;
update SPRZET set SPR_Gwarancja 	 = '5 lat' 	where SPRk_1_Id = 5;
update SPRZET set SPR_Cena 	 		 = '9999'	where SPRk_1_Id = 7;
update SPRZET set SPR_Kaucja 		 = '2000' 	where SPRk_1_Id = 8;

select * from SPRZET;




-- TABELA ADRES:

-- FORMATOWANIE:
column ADRk_1_Id			heading 'ID' format 99;
column ADR_Miasto			heading 'Miasto' format a11;
column ADR_Ulica 			heading 'Ulica' format a15;
column ADR_NrMieszkania 	heading	'Nr Mieszkania' format a7;
column ADR_KodPocztowy		heading 'Kod' format a6;



-- INSERTY:
create or replace procedure adr_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into ADRES
			(ADR_Miasto,ADR_Ulica,ADR_NrMieszkania,ADR_KodPocztowy)
			values ('Wies'||licznik, 'JanaPawla'||licznik, (licznik*10)-2, (licznik-1)||'3-00'||(licznik-1));
			licznik := licznik + 1;
	end loop;
end;
/

begin
	adr_wstaw(10);
end;
/


-- UPDATE'Y:

update ADRES set ADR_Miasto			 = 'Krakow' 		where ADRk_1_Id = 2;
update ADRES set ADR_Ulica 		 	 = 'Skarzynskiego' 	where ADRk_1_Id = 4;
update ADRES set ADR_NrMieszkania 	 = '997' 			where ADRk_1_Id = 6;
update ADRES set ADR_KodPocztowy 	 = '31-998' 		where ADRk_1_Id = 5;

select * from ADRES;


-- TABELA PRACOWNICY:

-- FORMATOWANIE:
column PRAk_1_Id			heading 'ID' 		format 99;
column PRA_Imie				heading 'Imie' 		format a11;
column PRA_Nazwisko 		heading 'Nazwisko' 	format a15;
column PRA_Stanowisko 		heading	'Stanowisko' format a10;
column PRA_Telefon			heading 'telefon' 	format 999999999;
column ADR_Id				heading 'Adr ID' 	format 99;



-- INSERTY:
create or replace procedure pra_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into PRACOWNICY
			(PRA_Imie,PRA_Nazwisko,PRA_Stanowisko,PRA_Telefon,ADR_Id)
			values ('Jan'||licznik, 'Kowalski'||licznik, 'Kasjer'||licznik, '98765432'||(licznik-1),licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	pra_wstaw(10);
end;
/


-- UPDATE'Y:

update PRACOWNICY set PRA_Imie			= 'Mateusz' 	where PRAk_1_Id = 2;
update PRACOWNICY set PRA_Nazwisko 		= 'Krok' 		where PRAk_1_Id = 4;
update PRACOWNICY set PRA_Stanowisko 	= 'Szef' 		where PRAk_1_Id = 6;
update PRACOWNICY set PRA_Telefon 	 	= '123456789' 	where PRAk_1_Id = 5;
update PRACOWNICY set ADR_Id 	 		= '10' 			where PRAk_1_Id = 5;

select * from PRACOWNICY;



-- TABELA FIRMA:

-- FORMATOWANIE:
column FIRk_1_Id		heading 'ID' 		format 99;
column FIR_Nazwa		heading 'Nazwa' 	format a11;
column FIR_Nip 			heading 'NIP' 		format a15;
column FIR_Regon 		heading	'Regon' 	format 999999999;
column ADR_Id			heading 'Adr ID' 	format 99;



-- INSERTY:
create or replace procedure fir_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into FIRMA
			(FIR_Nazwa,FIR_Nip,FIR_Regon,ADR_Id)
			values ('Firma'||licznik, '10'||(licznik-1)||'-111-22-'||((licznik*10)-2), '12345678'||(licznik-1),licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	fir_wstaw(10);
end;
/


-- UPDATE'Y:

update FIRMA set FIR_Nazwa		= 'Oracle' 			where FIRk_1_Id = 2;
update FIRMA set FIR_Nip 		= '125-168-71-76' 	where FIRk_1_Id = 4;
update FIRMA set FIR_Regon 		= '987654321' 		where FIRk_1_Id = 6;
update FIRMA set ADR_Id 	 	= '10' 				where FIRk_1_Id = 5;

select * from FIRMA;


-- TABELA KLIENCI:

-- FORMATOWANIE:
column KLIk_1_Id			heading 'ID' 		format 99;
column KLI_Imie				heading 'Imie' 		format a11;
column KLI_Nazwisko 		heading 'Nazwisko' 	format a15;
column KLI_DowodOsobisty 	heading 'Dowod' 	format a10;
column FIR_Id 				heading	'Fir ID' 	format 99;



-- INSERTY:
create or replace procedure kli_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into KLIENCI
			(KLI_Imie,KLI_Nazwisko,KLI_DowodOsobisty,FIR_Id)
			values ('Mateusz'||licznik, 'Krok'||(licznik-1),'ATV1234'||(licznik-1),licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	kli_wstaw(10);
end;
/


-- UPDATE'Y:

update KLIENCI set KLI_Imie				= 'Krzysztof' 	where KLIk_1_Id = 2;
update KLIENCI set KLI_Nazwisko 		= 'Zajac' 		where KLIk_1_Id = 4;
update KLIENCI set KLI_DowodOsobisty 	= 'ZZZ111111' 	where KLIk_1_Id = 5;
update KLIENCI set FIR_Id 				= '10' 			where KLIk_1_Id = 6;


select * from KLIENCI;


-- TABELA KATEGORIE:

-- FORMATOWANIE:
column KATk_1_Id	heading 'ID' 		format 99;
column KAT_Rodzaj	heading 'Rodzaj' 	format a16;
column KAT_Opis 	heading 'Opis' 		format a15;
column SPR_Id 		heading 'Spr ID' 	format 99;




-- INSERTY:
create or replace procedure kat_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into KATEGORIE
			(KAT_Rodzaj,KAT_Opis,SPR_Id)
			values ('Mlotowiertarka'||licznik, licznik||' kg, udarowa',licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	kat_wstaw(10);
end;
/



-- UPDATE'Y:

update KATEGORIE set KAT_Rodzaj	= 'Szlifierka' 	where KATk_1_Id = 2;
update KATEGORIE set KAT_Opis 	= 'Katowa' 		where KATk_1_Id = 4;
update KATEGORIE set SPR_Id 	= '10' 			where KATk_1_Id = 5;

select * from KATEGORIE;

-- TABELA REZERWACJA:

-- FORMATOWANIE:
column REZk_1_Id		heading 'ID' 		format 99;
column REZ_Data			heading 'Data' 		format a16;
column REZ_Ile_Dni 		heading 'Ile Dni' 	format 999;
column REZ_Ile_Sztuk 	heading 'Sztuki' 	format 99;
column KLI_Id 			heading 'Kli ID' 	format 99;
column SPR_Id 			heading 'Spr ID' 	format 99;


-- INSERTY:
create or replace procedure rez_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into REZERWACJA
			(REZ_Data,REZ_Ile_Dni,REZ_Ile_Sztuk,KLI_Id,SPR_Id)
			values (licznik||'.03.2015', (licznik*2), (licznik+1),licznik,licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	rez_wstaw(10);
end;
/


-- UPDATE'Y:

update REZERWACJA set REZ_Data	= '31.12.2000' 	where REZk_1_Id = 2;
update REZERWACJA set REZ_Ile_Dni 	= '100' 	where REZk_1_Id = 4;
update REZERWACJA set REZ_Ile_Sztuk 	= '99' 	where REZk_1_Id = 7;
update REZERWACJA set KLI_Id 	= '10' 			where REZk_1_Id = 5;
update REZERWACJA set SPR_Id 	= '10' 			where REZk_1_Id = 8;

select * from REZERWACJA;


-- TABELA POZYCJE_WYPOZYCZENIA:

-- FORMATOWANIE:
column POZk_1_Id		heading 'ID' 		format 99;
column POZ_Rabat		heading 'Rabat' 	format 99;
column POZ_Ilosc_Sztuk 	heading 'Sztuki' 	format 99;
column SPR_Id 			heading 'Spr ID' 	format 99;




-- INSERTY:
create or replace procedure poz_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into POZYCJE_WYPOZYCZENIA
			(POZ_Rabat,POZ_Ilosc_Sztuk,SPR_Id)
			values ((licznik*0.5), (licznik+3),licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	poz_wstaw(10);
end;
/


-- UPDATE'Y:

update POZYCJE_WYPOZYCZENIA set POZ_Rabat		= '10' 	where POZk_1_Id = 2;
update POZYCJE_WYPOZYCZENIA set POZ_Ilosc_Sztuk = '1' 	where POZk_1_Id = 4;
update POZYCJE_WYPOZYCZENIA set SPR_Id 			= '10' 	where POZk_1_Id = 5;

select * from POZYCJE_WYPOZYCZENIA;


-- TABELA FAKTURA:

-- FORMATOWANIE:
column FAKk_1_Id				heading 'ID' 		format 99;
column FAK_Data_Wystawienia		heading 'Data' 		format a16;
column FAK_Numer 				heading 'Nr' 		format 999;
column KLI_Id 					heading 'Kli ID' 	format 99;
column POZ_Id 					heading 'Spr ID' 	format 99;


-- INSERTY:
create or replace procedure fak_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into FAKTURA
			(FAK_Data_Wystawienia,FAK_Numer,KLI_Id,POZ_Id)
			values (licznik||'.05.2015', (licznik*3), licznik,licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	fak_wstaw(10);
end;
/


-- UPDATE'Y:

update FAKTURA set FAK_Data_Wystawienia	= '31.12.1999' 	where FAKk_1_Id = 2;
update FAKTURA set FAK_Numer 	= '100' 				where FAKk_1_Id = 4;
update FAKTURA set KLI_Id 	= '10' 						where FAKk_1_Id = 5;
update FAKTURA set POZ_Id 	= '10' 						where FAKk_1_Id = 8;

select * from FAKTURA;


-- TABELA PLATNOSC:

-- FORMATOWANIE:
column PLAk_1_Id		heading 'ID' 		format 99;
column PLA_Zaliczka		heading 'Zaliczka' 	format 999;
column PLA_Data 		heading 'Data' 		format a11;
column PRA_Id 			heading 'Pra ID' 	format 99;
column KLI_Id 			heading 'Kli ID' 	format 99;



-- INSERTY:
create or replace procedure pla_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into PLATNOSC
			(PLA_Zaliczka,PLA_Data,PRA_Id,KLI_Id)
			values ((licznik*3),licznik||'.05.2015', licznik,licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	pla_wstaw(10);
end;
/


-- UPDATE'Y:

update PLATNOSC set PLA_Zaliczka	= '100' 		where PLAk_1_Id = 2;
update PLATNOSC set PLA_Data 		= '31.12.1999' 	where PLAk_1_Id = 4;
update PLATNOSC set PRA_Id 			= '10' 			where PLAk_1_Id = 8;
update PLATNOSC set KLI_Id 			= '10' 			where PLAk_1_Id = 5;


select * from PLATNOSC;

-- TABELA WYPOZYCZENIA:

-- FORMATOWANIE:
column WYPk_1_Id			heading 'ID' 			format 99;
column WYP_Data_Oddania		heading 'Data Oddania' 	format 999;
column WYP_Wartosc_Brutto 	heading 'Brutto' format 9999;
column FAK_Id 				heading 'Fak ID' 		format 99;
column PRA_Id 				heading 'Pra ID' 		format 99;


-- INSERTY:
create or replace procedure wyp_wstaw(ile in number)
is
	licznik number(2);
begin
	licznik := 1;
	while licznik < ile + 1
	loop
		insert into WYPOZYCZENIA
			(WYP_Data_Oddania,WYP_Wartosc_Brutto,FAK_Id,PRA_Id)
			values (licznik||'.05.2015',(licznik*5), licznik,licznik);
			licznik := licznik + 1;
	end loop;
end;
/

begin
	wyp_wstaw(10);
end;
/


-- UPDATE'Y:

update WYPOZYCZENIA set WYP_Data_Oddania	= '31.12.1999' 	where WYPk_1_Id = 2;
update WYPOZYCZENIA set WYP_Wartosc_Brutto 	= '999' 		where WYPk_1_Id = 4;
update WYPOZYCZENIA set FAK_Id 				= '10' 			where WYPk_1_Id = 5;
update WYPOZYCZENIA set PRA_Id 				= '10' 			where WYPk_1_Id = 8;

select * from WYPOZYCZENIA;

SELECT SPR_Typ,SPR_Marka,SPR_Cena FROM SPRZET
WHERE SPRk_1_Id = 2 OR SPRk_1_Id = 4;

SELECT SPR_Typ,SPR_Marka,SPR_Cena FROM SPRZET
WHERE SPRk_1_Id IN(2,6);
	
SELECT SPR_Typ,SPR_Marka,SPR_Cena FROM SPRZET
WHERE SPRk_1_Id NOT IN(2,4);

SELECT SPR_Typ,SPR_Marka,SPR_Cena FROM SPRZET
WHERE SPRk_1_Id BETWEEN 2 AND 6;



---------------
-------------------
-----------------------
create index IDX_SPR_Typ on SPRZET (SPR_Typ)
STORAGE (INITIAL 150k NEXT 150k)
tablespace SPRZET_INDEX;

create index IDX_PRE on FIRMA (FIR_Nazwa,FIR_Nip,FIR_Regon,ADR_Id)
STORAGE (INITIAL 150k NEXT 150k)
tablespace STUDENT_INDEX;
-----------------------
-------------------
---------------



set serveroutput on;
DECLARE
-- deklaracja zmiennej
mc VARCHAR(20);
BEGIN
mc := to_char(sysdate, 'Day');
--wywołanie funkcji z predefiniowanego pakietu
DBMS_OUTPUT.PUT_LINE('Dzis mamy '|| mc);
END;
/

CREATE or REPLACE PROCEDURE PLSQL_uTime
IS
-- deklaracja zmiennej
mctt VARCHAR(40);
BEGIN
mctt := to_char(sysdate, 'Day HH24:MI:SS');
--
DBMS_OUTPUT.PUT_LINE('Wlasnie mamy: '|| mctt);
END;
/
BEGIN
PLSQL_uTime();
END;
/

CREATE or REPLACE FUNCTION f_mc_tt
(dformat IN varchar2, gformat IN varchar2)
RETURN VARCHAR2
IS
BEGIN
RETURN 'Wlasnie mamy: '|| to_char(sysdate, dformat) ||
'Godzina: '|| to_char(sysdate, gformat);
END;
/
BEGIN
DBMS_OUTPUT.PUT_LINE(f_mc_tt('Day','HH24:MI:SS'));
END;
/
BEGIN
DBMS_OUTPUT.PUT_LINE(f_mc_tt('YYYY','HH24:MI:SS'));
END;
/

----------------------------------------------------------------

set serveroutput on;
--Jawny

create or replace procedure cur_marka_1
is
	SPR_Typ  SPRZET.SPR_Typ%TYPE;
	SPR_Marka  SPRZET.SPR_Marka %TYPE;	
--
CURSOR cur_marka 
IS
select SPR_Typ, SPR_Marka from SPRZET where SPRk_1_Id  BETWEEN 4 AND 5;
begin
	open cur_marka;
	loop
		fetch cur_marka into SPR_Typ, SPR_Marka;
		exit when cur_marka%NOTFOUND
			OR cur_marka%ROWCOUNT < 1;
				dbms_output.put_line('Typ sprzetu to: '||SPR_Typ||' marki: '||SPR_Marka);
	END LOOP;
	CLOSE cur_marka;
end;
/
begin
cur_marka_1();
end;
/
--Niejawny 

create or replace procedure cur_pracownicy(id PRACOWNICY.PRAk_1_Id%TYPE, imie PRACOWNICY.PRA_Imie%TYPE,
nazwisko PRACOWNICY.PRA_Nazwisko%TYPE, stanowisko PRACOWNICY.PRA_Stanowisko%TYPE,
telefon PRACOWNICY.PRA_Telefon%TYPE)
IS
BEGIN
UPDATE PRACOWNICY SET PRA_Telefon = telefon where PRAk_1_Id=id;
UPDATE PRACOWNICY SET PRA_Imie = imie where PRAk_1_Id=id;
UPDATE PRACOWNICY SET PRA_Nazwisko = nazwisko where PRAk_1_Id=id;
UPDATE PRACOWNICY SET PRA_Stanowisko = stanowisko where PRAk_1_Id=id;



if SQL%NOTFOUND THEN
INSERT INTO PRACOWNICY (PRA_Imie,PRA_Nazwisko,PRA_Stanowisko,PRA_Telefon) 
values (imie,nazwisko,stanowisko,telefon);
end if;
END;
/
begin
cur_pracownicy(3,'CurImie','CurNazwisko','CurStanow',111222333);
end;
/
select * from PRACOWNICY;


--REKORDY



Create or replace procedure TEST_rekordy_1
IS
	--Rekord_spr_1 SPRZET%ROWTYPE;
	
	TYPE Rekord_spr_1 IS RECORD ( 
	SPR_Typ         		 varchar2(20), 
	SPR_Marka        		 varchar2(20), 
	SPR_Ilosc          		 number(3)
	);
	
	Rekord1 Rekord_spr_1;
	Rekord2 Rekord_spr_1;
begin
	Rekord1.SPR_Typ := 'RekTyp';
	Rekord1.SPR_Marka := 'RekMar';
	Rekord1.SPR_Ilosc := 55;

	Rekord2.SPR_Typ := 'RekTyp2';
	Rekord2.SPR_Marka := 'RekMar2';
	Rekord2.SPR_Ilosc := 88;
	
	DBMS_OUTPUT.PUT_LINE('Dla rekordu pierwszego:');
	DBMS_OUTPUT.PUT_LINE(' ');
	DBMS_OUTPUT.PUT_LINE('Typ:'||Rekord1.SPR_Typ||' Marka: '||Rekord1.SPR_Marka||' Ilosc: '||Rekord1.SPR_Ilosc);
	DBMS_OUTPUT.PUT_LINE(' ');
	DBMS_OUTPUT.PUT_LINE('Dla rekordu drugiego:');
	DBMS_OUTPUT.PUT_LINE(' ');
	DBMS_OUTPUT.PUT_LINE('Typ:'||Rekord2.SPR_Typ||' Marka: '||Rekord2.SPR_Marka||' Ilosc: '||Rekord2.SPR_Ilosc);
	
	insert into SPRZET values ('',Rekord1.SPR_Typ,Rekord1.SPR_Marka,Rekord1.SPR_Ilosc,'RekGwar',111,110);
	
end;
/

begin
	TEST_rekordy_1();
end;
/

select * from SPRZET;
-------------rekord - kursor

-- Create or replace procedure TEST_rekordy_2
-- is


-- (
	-- id PRACOWNICY.PRAk_1_Id%TYPE,
	-- imie PRACOWNICY.PRA_Imie%TYPE,
	-- nazwisko PRACOWNICY.PRA_Nazwisko%TYPE,
	-- stanowisko PRACOWNICY.PRA_Stanowisko%TYPE,
	-- telefon PRACOWNICY.PRA_Telefon%TYPE
-- );
	-- --Rekord_pra_2 PRACOWNICY%ROWTYPE;

	-- Rekord3 Rekord_pra_2;
	-- Rekord4 Rekord_pra_2;
-- begin
	-- -- Rekord3.PRAk_1_Id := 11;
	-- -- Rekord3.PRA_Imie := 'RekT33';
	-- -- Rekord3.PRA_Nazwisko := 'RekM33';
	-- -- Rekord3.PRA_Stanowisko := 33;
	-- -- Rekord3.PRA_Telefon := 1122353;

	-- DBMS_OUTPUT.PUT_LINE('Dla rekordu pierwszego:');
	-- DBMS_OUTPUT.PUT_LINE(' ');
	-- DBMS_OUTPUT.PUT_LINE('Imie:'||Rekord3.PRA_Imie||' nazwisko: '||PRA_Nazwisko.SPR_Marka||' Stanowisko: '||Rekord3.PRA_Stanowisko||' tel'||Rekord3.PRA_Telefon);
-- end;
-- /

-- begin
	-- TEST_rekordy_2(12,'qwqq','eeee','kassjeee',44455566);
-- end;
-- /

----
-----

	-- PRAk_1_Id            	number(4)    		NOT NULL, 
-- PRA_Imie				varchar2(20) 		NOT NULL,
-- PRA_Nazwisko			varchar2(30) 		NOT NULL,
-- PRA_Stanowisko			varchar2(30),
-- PRA_Telefon				number(12),
-- ADR_Id				number(4) 				NOT NULL

create or replace procedure TEST_rekordy_2
( 
	imie PRACOWNICY.PRA_Imie%TYPE,
	nazwisko PRACOWNICY.PRA_Nazwisko%TYPE,
	stanowisko PRACOWNICY.PRA_Stanowisko%TYPE,
	telefon PRACOWNICY.PRA_Telefon%TYPE
 )
is
	imie2 PRACOWNICY.PRA_Imie%TYPE;
	nazwisko2 PRACOWNICY.PRA_Nazwisko%TYPE;
	stanowisko2 PRACOWNICY.PRA_Stanowisko%TYPE;
	telefon2 PRACOWNICY.PRA_Telefon%TYPE;

  
  type Rekord_pra_2 is record
  (
	r_imie			VARCHAR2(20)	NOT NULL default 'Imie',
	r_nazwisko		VARCHAR2(30)	NOT NULL default 'Nazwisko',
	r_stanowisko 	varchar2(30),
	r_telefon		number(12)
  );
    rekord3 Rekord_pra_2;	
	
  cursor rek_kursor
  is select PRA_Imie,PRA_Nazwisko,PRA_Stanowisko,PRA_Telefon
  from PRACOWNICY where PRAk_1_Id IS not null;
	
		begin 
			rekord3.r_imie			:= imie;
			rekord3.r_nazwisko 		:= nazwisko;
			rekord3.r_stanowisko 	:= stanowisko;
			rekord3.r_telefon 		:= telefon;
			
			insert into PRACOWNICY VALUES ('',rekord3.r_imie,rekord3.r_nazwisko,rekord3.r_stanowisko,rekord3.r_telefon,9);
			open rek_kursor;
			loop
				fetch rek_kursor into
				imie2,nazwisko2,stanowisko2,telefon2;
				exit when rek_kursor%NOTFOUND or rek_kursor%ROWCOUNT < 1;
				DBMS_OUTPUT.PUT_LINE('Pracownik '||imie2||' '||nazwisko2||' '||stanowisko2||' '||telefon2);
			end loop;
		end;
/

begin
TEST_rekordy_2('Radoslaw', 'Rekordowy', 'Robotnik', 555666555);
end;
/

begin
TEST_rekordy_2('Tadeusz', 'Tadzikowski', 'Tokarz', 666555666);
end;
/
-----
----













PROMPT END of SCRIPT;
commit;



--@"C:\Users\bazy_danych_2\Downloads\BAZY.sql"
--@"D:\KrokMateusz\BAZY.sql"
--@"C:\Users\mati\Desktop\BAZY.sql"