create database SCHEMA_AKADEMIK;

use SCHEMA_AKADEMIK;

create table FAKULTAS(
	ID_FAKULTAS smallint not null,
	FAKULTAS VARCHAR(45) not null,
	primary KEY(ID_FAKULTAS)
);

create table JURUSAN (
	ID_JURUSAN smallint not null,
	ID_FAKULTAS smallint not null,
	JURUSAN VARCHAR(45) not null,
	primary KEY(ID_JURUSAN),
	foreign KEY(ID_FAKULTAS) references FAKULTAS(ID_FAKULTAS)
);

create table STRATA (
	ID_STRATA smallint not null,
	SINGKAT VARCHAR(10) not null,
	STRATA VARCHAR(45) not null,
	primary KEY(ID_STRATA)
);

create table PROGRAM_STUDI (
	ID_PROGRAM_STUDI smallint not null,
	ID_STRATA smallint not null,
	ID_JURUSAN smallint not null,
	PROGRAM_STUDI VARCHAR(60),
	primary KEY(ID_PROGRAM_STUDI),
	foreign key(ID_STRATA) references STRATA(ID_STRATA),
	foreign KEY(ID_JURUSAN) references JURUSAN(ID_JURUSAN)
);

create table SELEKSI_MASUK (
	ID_SELEKSI_MASUK smallint not null,
	SINGKAT VARCHAR(12) not null,
	SELEKSI_MASUK VARCHAR(45) not null,
	primary KEY(ID_SELEKSI_MASUK)
);

create table MAHASISWA (
	NIM VARCHAR(15) not null,
	ID_SELEKSI_MASUK smallint not null,
	ID_PROGRAM_STUDI smallint not null,
	NAMA VARCHAR(45) not null,
	ANGKATAN smallint not null,
	TGL_LAHIR DATE not null,
	KOTA_LAHIR VARCHAR(60),
	JENIS_KELAMIN CHAR(1),
	constraint chk_JENIS_KELAMIN check (JENIS_KELAMIN in ('P','L')),
	primary KEY(NIM),
	foreign KEY(ID_SELEKSI_MASUK) references SELEKSI_MASUK(ID_SELEKSI_MASUK),
	foreign KEY(ID_PROGRAM_STUDI) references PROGRAM_STUDI(ID_PROGRAM_STUDI)
);

select * from FAKULTAS;

insert into FAKULTAS (ID_FAKULTAS,FAKULTAS)
values (1,'Ekonomi & Bisnis');

insert into FAKULTAS (ID_FAKULTAS,FAKULTAS)
values (2,'Ilmu Komputer');

select * from JURUSAN;

insert into JURUSAN (ID_JURUSAN,ID_FAKULTAS,JURUSAN)
values (21,2,'Informatika'),
(22,2,'Sistem Informasi'),
(23,2,'Teknik Komputer');

select * from STRATA;

insert into STRATA (ID_STRATA,SINGKAT,STRATA)
values (1,'D1','Diploma'),
(2,'S1','Sarjana'),
(3,'S2','Magister');

select * from PROGRAM_STUDI;

insert into PROGRAM_STUDI (ID_PROGRAM_STUDI,ID_STRATA,ID_JURUSAN,PROGRAM_STUDI)
values (211,2,21,'Teknik Informatika'),
(212,2,21,'Teknik Komputer'),
(219,3,21,'Magister Ilmu Komputer');

ALTER TABLE SELEKSI_MASUK MODIFY SELEKSI_MASUK VARCHAR(60);

SHOW COLUMNS FROM SELEKSI_MASUK;

select * from SELEKSI_MASUK;

insert into SELEKSI_MASUK (ID_SELEKSI_MASUK,SINGKAT,SELEKSI_MASUK)
values (1,'SNMPTN','SELEKSI NASIONAL MAHASISWA PERGURUAN TINGGI NEGERI'),
(2,'SBMPTN','SELEKSI BERSAMA MAHASISWA PERGURUAN TINGGI NEGERI');

select * from MAHASISWA;

insert into MAHASISWA (NIM,ID_SELEKSI_MASUK,ID_PROGRAM_STUDI,NAMA,ANGKATAN,TGL_LAHIR,KOTA_LAHIR,JENIS_KELAMIN)
values ('155150400',1,211,'JONI',2015,'1997-1-1','Malang','W'),
('155150401',2,212,'JONO',2015,'1997-10-2','Situbondo','P');

-- Menginputkan/Menginsert data seperti pada Perintah 4.12, tapi saya rubah data nya untuk jenis kelamin yang awalnya M/male saya ganti menjadi P karena kolom jenis kelamin saya ada method cheknya yang dimana hanya boleh menginputkan P/W.
insert into MAHASISWA (NIM,ID_SELEKSI_MASUK,ID_PROGRAM_STUDI,NAMA,ANGKATAN,TGL_LAHIR,KOTA_LAHIR,JENIS_KELAMIN)
values ('155150402', 2 ,211,'JOKO',2015,'1998-2-10','SURABAYA','P'),
('155150403', 2 ,211,'JUJUN',2015,'1997-9-27','BANYUWANGI','P');

-- membuat View Latihan 1
create view LATIHAN_1 as
select
    CONCAT(NIM, ID_SELEKSI_MASUK, ID_PROGRAM_STUDI) as NIM_GABUNGAN,
    NAMA,
    YEAR(CURDATE()) - YEAR(TGL_LAHIR) AS UMUR
from MAHASISWA;

select * from LATIHAN_1;

-- membuat View Latihan_2
create view LATIHAN_2 as
select 
    ID_PROGRAM_STUDI,
    ANGKATAN,
    count(*) as JUMLAH_MAHASISWA
from MAHASISWA
group by ID_PROGRAM_STUDI, ANGKATAN;

select * from LATIHAN_2;

-- JOIN SOAL 1
select M.NIM, M.NAMA, M.ANGKATAN, PS.PROGRAM_STUDI, SM.SELEKSI_MASUK 
from MAHASISWA M
inner join PROGRAM_STUDI PS ON M.ID_PROGRAM_STUDI = PS.ID_PROGRAM_STUDI
inner join SELEKSI_MASUK SM ON M.ID_SELEKSI_MASUK = SM.ID_SELEKSI_MASUK;

-- JOIN SOAL 2
select PS.PROGRAM_STUDI, J.JURUSAN
from PROGRAM_STUDI PS
right join JURUSAN J on PS.ID_JURUSAN = J.ID_JURUSAN;

ALTER TABLE MAHASISWA DROP CONSTRAINT chk_JENIS_KELAMIN;

ALTER TABLE MAHASISWA ADD CONSTRAINT chk_JENIS_KELAMIN CHECK (JENIS_KELAMIN IN ('W', 'P'));


-- Modul 6 

-- Memasukan Perintah Insert 6.7

insert into schema_akademik.mahasiswa 
values ('155150404', 1, 212,'JESSY',2016,'1999-2-10','BANDUNG','W'),
('155150405', 2 ,219,'BAMBANG',2014,'1996-9-27','MAKASSAR','P');

select * from mahasiswa;


-- Perintah 6.8

create table schema_akademik.MAHASISWA_PINDAHAN(
	NIM VARCHAR(15) not null primary key,
	ID_SELEKSI_MASUK smallint,
	foreign key (ID_SELEKSI_MASUK) references schema_akademik.SELEKSI_MASUK(ID_SELEKSI_MASUK),
	ID_PROGRAM_STUDI smallint,
	foreign key (ID_PROGRAM_STUDI) references schema_akademik.PROGRAM_STUDI(ID_PROGRAM_STUDI),
	NAMA VARCHAR(45),
	ANGKATAN smallint,
	TGL_LAHIR date,
	KOTA_LAHIR VARCHAR(60),
	JENIS_KELAMIN CHAR(1) check (JENIS_KELAMIN in ('M','F'))
);


-- Perintah 6.9
insert into schema_akademik.MAHASISWA_PINDAHAN
values ('155150500', 1 ,211,'BUDI', 2015,'1997-3-3','BANYUWANGI','M'),
('155150501', 2,212,'ANDI',2015,'1997-2-21','JAKARTA','M'),
('155150502', 2 ,211,'DIMAS', 2015,'1998-4-11','SURABAYA','M'),
('155150503', 2 ,211,'DIDIN',2015,'1997-2-26','BANDUNG','M');

select * from mahasiswa_pindahan;

-- Latihan Modul 6

-- Nomer 1
select NIM,NAMA,JENIS_KELAMIN,KOTA_LAHIR,ANGKATAN from mahasiswa
where KOTA_LAHIR like 'B%' and NAMA like 'D%'

union

select NIM,NAMA,JENIS_KELAMIN,KOTA_LAHIR,ANGKATAN from mahasiswa_pindahan 
where KOTA_LAHIR like 'B%' and NAMA like 'D%'

order by NIM

-- Nomer 2

select NIM,NAMA,JENIS_KELAMIN,KOTA_LAHIR,ANGKATAN from mahasiswa
where ANGKATAN = 2015 and KOTA_LAHIR not like 'M%' 

union

select NIM,NAMA,JENIS_KELAMIN,KOTA_LAHIR,ANGKATAN from mahasiswa_pindahan 
where ANGKATAN = 2015 and KOTA_LAHIR not like 'M%' 

order by NIM


-- MODUL 7

-- BUDI BANYUWANGI

-- Subquery untuk Soal 1
select NIM, Nama, Angkatan
from Mahasiswa
where KOTA_LAHIR = (
    select KOTA_LAHIR
    from Mahasiswa_Pindahan
    where NAMA = 'BUDI'
);

-- Subquery Untuk Soal 2
select * from mahasiswa;
select * from mahasiswa_pindahan;

select NIM, Nama, Angkatan
from Mahasiswa
where KOTA_LAHIR in (
    select KOTA_LAHIR
    from Mahasiswa_Pindahan
);