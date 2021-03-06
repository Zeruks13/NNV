
USE master;
GO
CREATE DATABASE [Projekat]
ON  PRIMARY 
(NAME = N'Projekat_data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Projekat_data1.mdf', SIZE = 4096KB, MAXSIZE = 102400KB, FILEGROWTH = 10%)
LOG ON 
(NAME = N'Projekat_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Projekat_log1.ldf', SIZE = 2048KB, MAXSIZE = 71680KB, FILEGROWTH = 1024KB)
GO

USE Projekat
GO

CREATE TABLE dbo.Clanovi
(
	ClanID int IDENTITY (1, 1) NOT NULL,
	Ime nvarchar(50) NOT NULL,
	Prezime nvarchar(50) NOT NULL,
	Email nvarchar(50) NOT NULL,
	Status nvarchar(10) DEFAULT 'aktivan' NOT NULL,
	KorisnickoIme nvarchar(50) NOT NULL,
	Lozinka nvarchar(50) NOT NULL,
	Uloga nvarchar(50) NOT NULL,
	PRIMARY KEY (ClanID),
	CONSTRAINT UC_KorisnickiEmail UNIQUE(Email)
	
	
	
)
GO

CREATE TABLE dbo.Sednice
(
	
	SednicaID int NOT NULL,
	Datum date NOT NULL,
	Vrsta nvarchar(10) DEFAULT 'redovna' NOT NULL,
	Ucionica nvarchar(20) NULL,
	Zapisnik nvarchar(max) NULL,
	Poziv nvarchar(max) NULL,
	PRIMARY KEY (SednicaID)
)
GO


CREATE TABLE dbo.Prisustvo
(
	SednicaID int FOREIGN KEY REFERENCES Sednice(SednicaID),
	ClanID int FOREIGN KEY REFERENCES Clanovi(ClanID),
	Prisutan nvarchar(5) DEFAULT 'da' NOT NULL,
	Opravdano nvarchar(5) DEFAULT NULL NULL,
	CONSTRAINT PK_ClanIDiIDSEDNICE PRIMARY KEY CLUSTERED(SednicaID,ClanID)
	
)
GO




CREATE TABLE dbo.Prilozi
(
	SednicaID int FOREIGN KEY REFERENCES Sednice(SednicaID),
	RedniBrojPriloga int IDENTITY (1, 1) NOT NULL,
	NazivDokumenta nvarchar(50) NOT NULL,
	Poslato nvarchar(5) NULL,
	DatumSlanja date NULL,
	CONSTRAINT PK_SednicaPrilog PRIMARY KEY CLUSTERED(SednicaID,RedniBrojPriloga)
	
)
GO

CREATE TRIGGER TR_PopunjavanjePrisustva
ON dbo.Sednice
AFTER INSERT
AS
BEGIN
       SET NOCOUNT ON;
 
       DECLARE @SednicaID int
	SELECT @SednicaID = inserted.SednicaID  FROM inserted
	INSERT INTO dbo.Prisustvo(SednicaID, ClanID, Prisutan,Opravdano) SELECT @SednicaID, ClanID,'da', NULL FROM dbo.Clanovi Where Status = 'aktivan'
 
       
END
GO