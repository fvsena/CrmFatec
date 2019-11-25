DROP DATABASE IF EXISTS crm;
CREATE DATABASE crm DEFAULT CHARSET UTF8;
use crm;

CREATE TABLE Customer (
    IdCustomer INT AUTO_INCREMENT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    DocumentNumber VARCHAR(20) NOT NULL,
    BirthDate DATETIME NOT NULL,
    Gender SET('M','F','I') NOT NULL,
    CustomerDate DATETIME NOT NULL,
    CONSTRAINT pk_customer PRIMARY KEY(IdCustomer),
    CONSTRAINT CH_BirthDateCustomer CHECK (BirthDate < GETDATE()),
    CONSTRAINT UN_DocumentNumberCustomer UNIQUE (DocumentNumber)
);

CREATE TABLE Address (
    IdAddress INT AUTO_INCREMENT NOT NULL,
    IdCustomer INT NOT NULL,
    PostalCode VARCHAR(20),
    PublicPlace VARCHAR(200) NOT NULL,
    Number VARCHAR(20) NOT NULL,
    Neighborhood VARCHAR(100) NOT NULL,
    Complement VARCHAR(200),
    City VARCHAR(100) NOT NULL,
    FS CHAR(2) NOT NULL,
    AddressDate DATETIME NOT NULL,
    CONSTRAINT PK_Address PRIMARY KEY(IdAddress),
    CONSTRAINT FK_Address_Customer FOREIGN KEY(IdCustomer) REFERENCES Customer(IdCustomer)
);

CREATE TABLE Telephone	(
    IdTelephone INT AUTO_INCREMENT NOT NULL,
    IdCustomer INT NOT NULL,
    PhoneNumber VARCHAR(11) NOT NULL,
    Status BIT NOT NULL,
    CONSTRAINT PK_Telephone PRIMARY KEY(IdTelephone),
    CONSTRAINT FK_Telephone_Customer FOREIGN KEY(IdCustomer) REFERENCES Customer(IdCustomer)
);

CREATE TABLE SubjectGroup (
    IdSubjectGroup INT AUTO_INCREMENT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT PK_SubjectGroup PRIMARY KEY(IdSubjectGroup)
);

CREATE TABLE SubjectSubGroup (
    IdSubjectSubGroup INT NOT NULL,
    IdSubjectGroup INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT PK_SubjectSubGroup PRIMARY KEY (IdSubjectSubGroup, IdSubjectGroup),
    CONSTRAINT FK_SubjectSubGroup_SubjectGroup FOREIGN KEY(IdSubjectGroup) REFERENCES SubjectGroup(IdSubjectGroup)
);


CREATE TABLE SubjectDetail (
    IdSubjectDetail INT NOT NULL,
    IdSubjectSubGroup INT NOT NULL,
    IdSubjectGroup INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CONSTRAINT PK_SubjectDetail PRIMARY KEY(IdSubjectGroup, IdSubjectSubGroup, IdSubjectDetail),
    CONSTRAINT FK_SubjectDetail_SubjectSubGroup FOREIGN KEY(IdSubjectSubGroup, IdSubjectGroup) REFERENCES SubjectSubGroup(IdSubjectSubGroup, IdSubjectGroup)
);

CREATE TABLE Agent (
		IdAgent INT AUTO_INCREMENT NOT NULL,
		Name VARCHAR(100) NOT NULL,
		Login VARCHAR(30),
		Password VARCHAR(255),
		Status BIT NOT NULL,
        CONSTRAINT PK_Agent PRIMARY KEY(IdAgent)
	);

INSERT INTO Agent (Name,Login,Password,Status) VALUES ('admin','admin.crm','123', 1);


CREATE TABLE Contact (
		IdContact INT AUTO_INCREMENT NOT NULL,
		IdCustomer INT NOT NULL,
		IdAgent INT NOT NULL,
		ContactDate DATETIME NOT NULL,
		Detail TEXT NOT NULL,
        CONSTRAINT PK_Contact PRIMARY KEY(IdContact),
        CONSTRAINT FK_Contact_Customer FOREIGN KEY(IdCustomer) REFERENCES Customer(IdCustomer),
        CONSTRAINT FK_Contact_Agent FOREIGN KEY(IdAgent) REFERENCES Agent(IdAgent)
	);

CREATE TABLE OccurrenceStatus (
		IdOccurrenceStatus INT AUTO_INCREMENT NOT NULL,
		Name VARCHAR(50) NOT NULL,
        CONSTRAINT PK_OccurrenceStatus PRIMARY KEY(IdOccurrenceStatus)
	);

INSERT INTO OccurrenceStatus (Name) VALUES ('Pendente');
INSERT INTO OccurrenceStatus (Name) VALUES ('Em andamento');
INSERT INTO OccurrenceStatus (Name) VALUES ('Encerrado');

CREATE TABLE Occurrence (
		IdOccurrence INT AUTO_INCREMENT NOT NULL,
		IdCustomer INT NOT NULL,
		IdAgent INT NOT NULL,
		OccurrenceDate DATETIME NOT NULL,
		IdSubjectGroup INT NOT NULL,
		IdSubjectSubGroup INT NOT NULL,
		IdSubjectDetail INT NOT NULL,
		IdOccurrenceStatus INT NOT NULL,
        CONSTRAINT PK_Occurrence PRIMARY KEY(IdOccurrence),
        CONSTRAINT FK_Occurrence_Customer FOREIGN KEY(IdCustomer) REFERENCES Customer(IdCustomer),
        CONSTRAINT FK_Occurrence_Agent FOREIGN KEY(IdAgent) REFERENCES Agent(IdAgent),
        CONSTRAINT FK_Occurrence_SubjectDetail FOREIGN KEY(IdSubjectGroup, IdSubjectSubGroup, IdSubjectDetail) REFERENCES SubjectDetail(IdSubjectGroup, IdSubjectSubGroup, IdSubjectDetail),
        CONSTRAINT FK_Occurrence_OccurrenceStatus FOREIGN KEY(IdOccurrenceStatus) REFERENCES OccurrenceStatus(IdOccurrenceStatus)
);

CREATE TABLE OccurrenceUpdateType (
    IdOccurrenceUpdateType INT AUTO_INCREMENT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT PK_OccurrenceUpdateType PRIMARY KEY(IdOccurrenceUpdateType)
);

INSERT INTO OccurrenceUpdateType (Name) VALUES ('Abertura');
INSERT INTO OccurrenceUpdateType (Name) VALUES ('Atualiza��o');
INSERT INTO OccurrenceUpdateType (Name) VALUES ('Finaliza��o');
CREATE TABLE OccurrenceUpdate (
		IdOccurrenceUpdate INT AUTO_INCREMENT NOT NULL,
		IdOccurrenceUpdateType INT NOT NULL,
		IdOccurrence INT NOT NULL,
		IdAgent INT NOT NULL,
		UpdateDate DATETIME NOT NULL,
		UpdateMessage TEXT,
        CONSTRAINT PK_OccurrenceUpdate PRIMARY KEY(IdOccurrenceUpdate),
        CONSTRAINT FK_OccurrenceUpdate_OccurrenceUpdateType FOREIGN KEY(IdOccurrenceUpdateType) REFERENCES OccurrenceUpdateType(IdOccurrenceUpdateType),
        CONSTRAINT FK_OccurrenceUpdate_Occurrence FOREIGN KEY(IdOccurrence) REFERENCES Occurrence(IdOccurrence),
        CONSTRAINT FK_OccurrenceUpdate_Agent FOREIGN KEY(IdAgent) REFERENCES Agent(IdAgent)
	);

CREATE TABLE SchedulingType	(
		IdSchedulingType INT AUTO_INCREMENT NOT NULL,
		Name VARCHAR(50) NOT NULL,
        CONSTRAINT PK_SchedulingType PRIMARY KEY(IdSchedulingType)
	);

CREATE TABLE Scheduling (
    IdScheduling INT AUTO_INCREMENT NOT NULL,
    IdSchedulingType INT NOT NULL,
    IdOccurrence INT NOT NULL,
    IdAgent INT NOT NULL,
    SchedulingDate DATETIME NOT NULL,
    SchedulingDateScheduled DATETIME NOT NULL,
    SchedulingDateRealized DATETIME,
    Status BIT NOT NULL,
    CONSTRAINT PK_Scheduling PRIMARY KEY(IdScheduling),
    CONSTRAINT FK_Scheduling_SchedulingType FOREIGN KEY(IdSchedulingType) REFERENCES SchedulingType(IdSchedulingType),
    CONSTRAINT FK_Scheduling_Occurrence FOREIGN KEY(IdOccurrence) REFERENCES Occurrence(IdOccurrence),
    CONSTRAINT FK_Scheduling_Agent FOREIGN KEY(IdAgent) REFERENCES Agent(IdAgent)
);


-- Procedures

DELIMITER $$
CREATE PROCEDURE saveCustomer(
        _name VARCHAR(100),
        _gender CHAR(1),
        _document VARCHAR(20),
        _birthDate DATE,
        _id INT
    )
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
    START TRANSACTION;
    IF _id  IS NULL THEN
        INSERT INTO Customer
            ( Name, Gender, DocumentNumber, BirthDate, CustomerDate)
            VALUES
            (_name,_gender,_document,_birthDate,now());
    ELSE
        UPDATE Customer SET Name = _name, Gender = _gender, DocumentNumber = _document, 
        BirthDate = _birthDate, CustomerDate = now() where IdCustomer = _id;
    END IF;
    COMMIT;
END$$

CREATE PROCEDURE saveAddress (
    _idCustomer INT,
    _postalCode VARCHAR(20),
    _publicPlace VARCHAR(255),
    _number VARCHAR(20),
    _neighborhood VARCHAR(20),
    _complement VARCHAR(200),
    _city VARCHAR(100),
    _state CHAR(2)
)
BEGIN
    DECLARE total INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
    START TRANSACTION;
    SELECT COUNT(IdAddress) INTO total FROM Address WHERE IdCustomer = _idCustomer;
    IF total > 0 THEN
        UPDATE Address SET
            postalCode = _postalCode,
            publicPlace = _publicPlace,
            number = _number,
            neighborhood = _neighborhood,
            complement = _complement,
            city = _city,
            FS = _state,
            AddressDate = Now()
        WHERE idCustomer = _idCustomer;
    ELSE
        INSERT INTO Address (
                    idCustomer,
                    postalCode,
                    publicPlace,
                    number,
                    neighborhood,
                    complement,
                    city,
                    FS,
                    AddressDate) 
                VALUES (
                    _idCustomer,
                    _postalCode,
                    _publicPlace,
                    _number,
                    _neighborhood,
                    _complement,
                    _city,
                    _state,
                    NOW()
                );
    END IF;
    COMMIT;
END$$

CREATE PROCEDURE validateLogin (
    _login varchar(20),
    _password VARCHAR(20)
)
BEGIN
    SELECT IdAgent, Name FROM Agent WHERE login = _login AND password = _password;
END$$

CREATE PROCEDURE getCustomers()
BEGIN
	SELECT
		IdCustomer Codigo,
		Name Nome,
		Gender Genero,
		DocumentNumber Documento,
		BirthDate DataNascimento
	FROM
		Customer;
END$$

CREATE PROCEDURE saveContact
	(
		_IdCliente INT,
		_IdAgente INT,
		_Detalhe TEXT
	)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
    START TRANSACTION;
    INSERT INTO Contact
        (IdCustomer, IdAgent, ContactDate, Detail)
    VALUES
        (_IdCliente, _IdAgente, NOW(), _Detalhe);
    COMMIT;
END$$


CREATE PROCEDURE getContacts
	(
		_IdCliente INT
	)
BEGIN
	SELECT
		IdContact,
		IdCustomer,
		Agent.IdAgent,
		Agent.Name,
		ContactDate,
		Detail
	FROM
		Contact
	INNER JOIN Agent ON Contact.IdAgent = Agent.IdAgent
	WHERE
		IdCustomer = _IdCliente;
END$$

CREATE PROCEDURE getTelephones
	(
		_IdCliente INT
	)
BEGIN
	SELECT
		PhoneNumber AS Telefone
	FROM
		Telephone
	WHERE
		IdCustomer = _IdCliente;
END$$

CREATE PROCEDURE getAddress
	(
		_IdCliente INT
	)
BEGIN
	SELECT
		PostalCode,
		PublicPlace,
		Number,
		Neighborhood,
		Complement,
		City,
		FS
	FROM
		Address
	WHERE
		IdCustomer = _IdCliente;
END$$

CREATE PROCEDURE getGroupOccurrences()
BEGIN
	SELECT
		Name AS Grupo,
		IdSubjectGroup AS IdGrupo
	FROM
		SubjectGroup;
END$$


CREATE PROCEDURE getSubGroupOccurrences
 	(
 		_IdGrupo INT
 	)
 BEGIN
 	SELECT
 		Name SubGrupo,
 		IdSubjectSubGroup IdSubGrupo
 	FROM
 		SubjectSubGroup
 	WHERE
 		IdSubjectGroup = _IdGrupo;
 END$$

 CREATE PROCEDURE getOccurrenceDetails
 	(
 		_IdGrupo INT,
 		_IdSubGrupo INT
 	)
 BEGIN
 	SELECT
 		Name Detalhe,
 		IdSubjectDetail IdDetalhe
 	FROM
 		SubjectDetail
 	WHERE
 		IdSubjectGroup = _IdGrupo
 		AND IdSubjectSubGroup = _IdSubGrupo;
 END$$

CREATE PROCEDURE saveGroupOccurence
	(
		_Group VARCHAR(50)
	)
BEGIN
	DECLARE _COUNT INT;
	SELECT COUNT(Name) INTO _COUNT FROM SubjectGroup  WHERE Name = _Group;

	IF _COUNT <= 0 THEN
	    INSERT INTO SubjectGroup (Name)	VALUES (_Group);
    END IF;

END$$

CREATE PROCEDURE saveSubGroupOccurrence
	(
		_Grupo INT,
		_SubGrupo VARCHAR(50)
	)
BEGIN
	DECLARE _CONT INT;
    DECLARE _CodigoSubGrupo INT;
	SELECT _CONT = COUNT(Name) FROM SubjectSubGroup WHERE IdSubjectGroup = _Grupo AND Name = _SubGrupo;

	IF _CONT <= 0 THEN
        SELECT COALESCE(MAX(IdSubjectSubGroup),0)+1 INTO _CodigoSubGrupo FROM SubjectSubGroup WHERE IdSubjectGroup = _Grupo;

        INSERT INTO SubjectSubGroup
            (IdSubjectSubGroup, IdSubjectGroup, Name)
        VALUES
            (_CodigoSubGrupo,_Grupo,_SubGrupo);
    END IF;
END$$

CREATE PROCEDURE saveOccurenceDetails
	(
		_Grupo INT,
		_SubGrupo INT,
		_Detalhe VARCHAR(100)
	)
BEGIN
	DECLARE _CONT INT;
	DECLARE _CodigoDetalhe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
    START TRANSACTION;
	SELECT COUNT(Name) INTO _CONT FROM SubjectDetail WHERE IdSubjectGroup = _Grupo AND IdSubjectSubGroup = _SubGrupo AND Name = _Detalhe;

	IF _CONT <= 0 THEN
        SELECT COALESCE(MAX(IdSubjectDetail),0)+1 INTO _CodigoDetalhe FROM SubjectDetail WHERE IdSubjectGroup = _Grupo AND IdSubjectSubGroup = _SubGrupo;
        
        INSERT INTO SubjectDetail
            (IdSubjectGroup, IdSubjectSubGroup, IdSubjectDetail, Name)
        VALUES
            ( _Grupo, _SubGrupo, _CodigoDetalhe, _Detalhe );
	END IF;
    COMMIT;
END$$

CREATE PROCEDURE saveOccurence
	(
		_IdCliente INT,
		_IdAgente INT,
		_CodigoGrupo INT,
		_CodigoSubGrupo INT,
		_CodigoDetalhe INT,
		_Mensagem VARCHAR(255)
	)
        BEGIN
			DECLARE _IdOcorrencia INT;

			INSERT INTO Occurrence
				(
					IdCustomer,
					IdAgent,
					OccurrenceDate,
					IdSubjectGroup,
					IdSubjectSubGroup,
					IdSubjectDetail,
					IdOccurrenceStatus
				)
			VALUES
				(_IdCliente, _IdAgente, GETDATE(), _CodigoGrupo, _CodigoSubGrupo, _CodigoDetalhe, 1);

			SET _IdOcorrencia = LAST_INSERT_ID();

			INSERT INTO OccurrenceUpdate
				(IdOccurrenceUpdateType, IdOccurrence, IdAgent, UpdateDate, UpdateMessage)
			VALUES
				(1, _IdOcorrencia, _IdAgente,GETDATE(),_Mensagem);	
END$$

CREATE PROCEDURE getOccurrences
	(
		_Quantidade INT
	)
BEGIN
    IF _Quantidade IS NULL THEN
        SET _Quantidade = 10;
    END IF;
	SELECT _Quantidade,
		Occurrence.IdOccurrence AS `IdOcorrencia`,
		Occurrence.IdCustomer AS `IdCliente`,
		Occurrence.OccurrenceDate AS `DataAbertura`,
		Customer.Name AS `Cliente`,
		Agent.Name AS `Agente`,
		SubjectGroup.Name AS `Grupo`,
		SubjectSubGroup.Name AS `SubGrupo`,
		SubjectDetail.Name AS `Detalhe`,
		OccurrenceUpdate.UpdateMessage AS `UltimaAtualizaca`
	FROM
		Occurrence
	INNER JOIN Agent ON Occurrence.IdAgent = Agent.IdAgent
	INNER JOIN Customer ON Occurrence.IdCustomer = Customer.IdCustomer
	INNER JOIN SubjectGroup ON Occurrence.IdSubjectGroup = SubjectGroup.IdSubjectGroup
	INNER JOIN SubjectSubGroup ON Occurrence.IdSubjectGroup = SubjectSubGroup.IdSubjectGroup AND Occurrence.IdSubjectSubGroup = SubjectSubGroup.IdSubjectSubGroup
	INNER JOIN SubjectDetail ON Occurrence.IdSubjectGroup = SubjectDetail.IdSubjectGroup AND Occurrence.IdSubjectSubGroup = SubjectDetail.IdSubjectSubGroup AND Occurrence.IdSubjectDetail = SubjectDetail.IdSubjectDetail
	INNER JOIN
		(
			SELECT
				MAX(IdOccurrenceUpdate) IdOccurrenceUpdate,
				OccurrenceUpdate.IdOccurrence IdOccurrence
			FROM
				OccurrenceUpdate
			GROUP BY
				OccurrenceUpdate.IdOccurrence
		) UPDATES ON UPDATES.IdOccurrence = Occurrence.IdOccurrence
	INNER JOIN OccurrenceUpdate ON UPDATES.IdOccurrenceUpdate = OccurrenceUpdate.IdOccurrenceUpdate
	ORDER BY
		Occurrence.OccurrenceDate DESC LIMIT _Quantidade;
END$$

CREATE PROCEDURE findOccurences
	(
		_Codigo INT
	)
BEGIN
	SELECT
		Occurrence.IdOccurrence AS `IdOcorrencia`,
		Occurrence.IdCustomer AS `IdCliente`,
		Occurrence.OccurrenceDate AS `DataAbertura`,
		Customer.Name AS `Cliente`,
		Agent.Name AS `Agente`,
		SubjectGroup.Name AS `Grupo`,
		SubjectSubGroup.Name AS `SubGrupo`,
		SubjectDetail.Name AS `Detalhe`
	FROM
		Occurrence
	INNER JOIN Agent ON Occurrence.IdAgent = Agent.IdAgent
	INNER JOIN Customer ON Occurrence.IdCustomer = Customer.IdCustomer
	INNER JOIN SubjectGroup ON Occurrence.IdSubjectGroup = SubjectGroup.IdSubjectGroup
	INNER JOIN SubjectSubGroup ON Occurrence.IdSubjectGroup = SubjectSubGroup.IdSubjectGroup AND Occurrence.IdSubjectSubGroup = SubjectSubGroup.IdSubjectSubGroup
	INNER JOIN SubjectDetail ON Occurrence.IdSubjectGroup = SubjectDetail.IdSubjectGroup AND Occurrence.IdSubjectSubGroup = SubjectDetail.IdSubjectSubGroup AND Occurrence.IdSubjectDetail = SubjectDetail.IdSubjectDetail
	WHERE
		Occurrence.IdOccurrence = _Codigo;

	SELECT
		OccurrenceUpdate.IdOccurrenceUpdate AS `IdAtualizacao`,
		OccurrenceUpdate.UpdateDate AS `DataAtualizacao`,
		OccurrenceUpdate.IdAgent AS `IdAgente`,
		Agent.Name AS `Agente`,
		OccurrenceUpdateType.Name AS `TipoAtualizacao`,
		OccurrenceUpdate.UpdateMessage AS `Mensagem`
	FROM
		OccurrenceUpdate
	INNER JOIN Agent ON OccurrenceUpdate.IdAgent = Agent.IdAgent
	INNER JOIN OccurrenceUpdateType ON OccurrenceUpdate.IdOccurrenceUpdateType = OccurrenceUpdateType.IdOccurrenceUpdateType
	WHERE
		OccurrenceUpdate.IdOccurrence = _Codigo;
END$$

CREATE PROCEDURE saveUpdates
	(
		_IdOcorrencia INT,
		_IdAgente INT,
		_IdTipoAtualizacao INT,
		_Mensagem VARCHAR(255)
	)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
    START TRANSACTION;
        INSERT INTO OccurrenceUpdate
            ( IdOccurrenceUpdateType, IdOccurrence, IdAgent, UpdateDate, UpdateMessage)
        VALUES
            (1, _IdOcorrencia, _IdAgente, NOW(), _Mensagem);
    COMMIT;	
END$$

CREATE PROCEDURE savePhone
	(
		_IdCliente INT,
		_Telefone VARCHAR(11)
	)
BEGIN
	DECLARE _CONT INT;
	SELECT COUNT(*) INTO _CONT FROM Telephone WHERE IdCustomer = _IdCliente AND PhoneNumber = _Telefone;

	IF _CONT <= 0 THEN
        INSERT INTO Telephone
            (IdCustomer,PhoneNumber,Status)
        VALUES
            (_IdCliente,_Telefone,1);
    END IF;
END$$

DELIMITER ;