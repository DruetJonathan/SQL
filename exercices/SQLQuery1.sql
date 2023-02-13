--1.1
CREATE TABLE T_office(
	office_id INTEGER,
	office_adresse VARCHAR(30),
	CONSTRAINT PK_office PRIMARY KEY (office_id)
);

CREATE TABLE T_course(
	crs_code INTEGER PRIMARY KEY,
	crs_name VARCHAR(30),
	CONSTRAINT UK_crs UNIQUE (crs_name)
);

CREATE TABLE T_professor(
	prf_id INTEGER NOT NULL,
	prf_name VARCHAR(30),
	prf_course INTEGER,
	CONSTRAINT PK_profId PRIMARY KEY (prf_id),
	office_id INTEGER CONSTRAINT FK_Toffice_Tprofessor FOREIGN KEY REFERENCES T_office(office_id) ON DELETE SET NULL,
	CONSTRAINT UK_prfName UNIQUE (prf_name)

);
--1.2
CREATE TABLE T_MAITENANCE_MTN(
	maint_id INTEGER IDENTITY(1,1),
	maint_jour CHAR(3) CHECK (maint_jour IN('Lun','Mar','Mer','Jeu','Ven','Sam','Dim')),
	maint_machine VARCHAR(30),
	maint_numero INT NOT NULL,
	maint_vitesse SMALLINT CHECK(maint_vitesse <= 20 and maint_vitesse > 0),
	maint_temperature SMALLINT check(maint_temperature between 0 and 100),
	maint_heure DATETIME check(datepart(hour,maint_heure) between 6 and 22),
	maint_evenement varchar(100),
	CONSTRAINT PK_maintId PRIMARY KEY (maint_id),
	CONSTRAINT UK_maintNumero UNIQUE (maint_numero),
);

--Exercice 1.3 – Créer une table pour y stocker les produits à vendre, avec les rubriques
--suivantes : identifiant, référence magasin, référence fabricant, code EAN13, prix de vente.
--Cette table fera en outre référence aux tables T_TAUX_TVA, T_RAYON_RYN,
--T_FABRICANT_FBQ.
--Mettez en place toutes les contraintes nécessaires. La table produit contiendra au
--minimum les colonnes proposées, mais peut en contenir d’autres au besoin


CREATE TABLE T_TAUX_TVA(
	tauxTva_id int,
	tauxTva_taux int,
	CONSTRAINT PK_tauxTva_id PRIMARY KEY (tauxTva_id)

);
CREATE TABLE T_RAYON_RYN(
	rayon_id int,
	rayon_numero int,
	CONSTRAINT PK_rayon_id PRIMARY KEY (rayon_id)

);
CREATE TABLE T_FABRIQUANT_FBQ(
	fabri_id int IDENTITY(1,1),
	fabri_nom varchar(30),
	fabri_numeroFabriquant int,
	fabri_rue varchar,
	fabri_numeroMaison int,
	fabri_localite varchar,
	CONSTRAINT PK_fabri_id PRIMARY KEY (fabri_id)
);

CREATE TABLE T_PRODUITS(
	prod_id INTEGER,
	prod_referenceMagasin int,
	prod_referenceFabriquant int,
	prod_EAN13 varchar(13),
	prod_prix money,
	FK_TAUX_TVA int REFERENCES T_TAUX_TVA (tauxTva_id),
	FK_RAYON_RYN int REFERENCES T_RAYON_RYN (rayon_id),
	FK_FABRIQUANT_FBQ int REFERENCES T_FABRIQUANT_FBQ (fabri_id),
	CONSTRAINT PK_Prod_id PRIMARY KEY (prod_id)

);


 