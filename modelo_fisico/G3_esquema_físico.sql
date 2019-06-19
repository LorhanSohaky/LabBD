----------------------------
----------Reunião
----------------------------

CREATE TABLE Reuniao (
	id_reuniao 				NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
	documento_apresentacao	VARCHAR2(4000),
	orgao					CHAR(4), --caex ou coex
	data_inicio				DATE, -- geração do atributo derivado duração
	data_fim				DATE,
	
	CONSTRAINT PK_Reuniao PRIMARY KEY (id_reuniao)
	
);


CREATE TABLE ReuniaoAta (
	nro_ata     NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
	id_reuniao  NUMBER,
	ata 		VARCHAR2(4000),

	CONSTRAINT PK_ReuniaoAta PRIMARY KEY (nro_ata, id_reuniao),
    CONSTRAINT FK_ReuniaoAta 
        FOREIGN KEY (id_reuniao) REFERENCES Reuniao(id_reuniao)
	
);


CREATE TABLE ReuniaoAvalia (
	id_reuniao 			NUMBER,
	id_pessoa           NUMBER,
	codigo_edital 		NUMBER,
	veredito 			VARCHAR2(4000),
	recorrencia			VARCHAR2(4000),

	CONSTRAINT PK_ReuniaoAvalia 
		PRIMARY KEY (id_pessoa,id_reuniao,codigo_edital),
		
	CONSTRAINT FK_ReuniaoAvalia_Pessoa
		FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa),

	CONSTRAINT FK_ReuniaoAvalia_Reuniao
		FOREIGN KEY (id_reuniao) REFERENCES Reuniao(id_reuniao),

	CONSTRAINT FK_ReuniaoAvalia_Edital 
		FOREIGN KEY (codigo_edital) REFERENCES Edital(codigo)

);

CREATE TABLE ReuniaoParticipa (
	id_reuniao 					NUMBER,
	id_pessoa 					NUMBER,
	data_participacao 			DATE,
	presenca					NUMBER(1,0) CHECK (presenca=0 OR presenca=1),
	justificativa 				VARCHAR2(4000),
	recurso_justificativa 		VARCHAR2(4000),
	aprovacao_justificativa 	VARCHAR2(4000),

	CONSTRAINT PK_ReuniaoParticipa 
		PRIMARY KEY (id_pessoa,id_reuniao),

	CONSTRAINT FK_ReuniaoParticipa_Reuniao
		FOREIGN KEY (id_reuniao) REFERENCES Reuniao(id_reuniao),

	CONSTRAINT FK_ReuniaoParticipa_Pessoa
		FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

-------------------------------------
----------Tramitação e Avaliador
-------------------------------------

CREATE TABLE Tramitacao (
	id_pessoa NUMBER,
	id_departamento NUMBER,
	codigo_edital NUMBER,
	num_processo NUMBER,
	num_extensao NUMBER,
	tipo CHAR(1), --BOOL, considerando que tipo é o resultado da tramitação
	julgamento VARCHAR2(500),
	data DATE,

	constraint Tramitacao_pk primary key (id_pessoa, id_departamento, codigo_edital, num_processo, num_extensao),
	constraint Tramitacao_proposta_fk foreign key (num_processo, id_pessoa, id_departamento, codigo_edital) 
		references Proposta (num_processo, id_pessoa, id_departamento, codigo_edital),
	constraint Tramitacao_extensao_fk foreign key (num_extensao) references Extensao (num_extensao)
);

CREATE TABLE Avaliador (
	id_pessoa NUMBER,
	id_departamento NUMBER,
	representatividade VARCHAR2(20),
	mandatoInicio DATE,
	mandatoFim DATE,

	constraint Avaliador_pk primary key (id_pessoa, id_departamento),
	constraint Avaliador_servidor_fk foreign key (id_pessoa, id_departamento)
		references Servidor (id_pessoa, id_departamento)

);

-------------------------------------
----------Julga
-------------------------------------

CREATE TABLE julga (
	id_pessoa 		number,
	codigo_edital 	number,
	Id_reuniao		number,
	justificativa	varchar(4000),
	posicionamento	varchar(4000),
	
	CONSTRAINT PK_Julga PRIMARY KEY (id_pessoa, codigo_edital, Id_reuniao),
	CONSTRAINT FK_id_pessoa_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),
	CONSTRAINT FK_codigo_edital FOREIGNKEY (codigo_edital) REFERENCES Edital(codigo_edital),
	CONSTRAINT FK_id_reuniao FOREIGNKEY (id_reuniao) REFERENCES Edital(id_reuniao),
);

CREATE TABLE julga_1 (
	id_pessoa 		number,
	N_Do_Processo	number,
	Id_reuniao		number,
	veredito		varchar(4000),
	recorrencia		varchar(4000),
	
	CONSTRAINT PK_Julga PRIMARY KEY (id_pessoa,N_Do_Processo, Id_reuniao),
	CONSTRAINT FK_id_pessoa_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),
	CONSTRAINT FK_ N_Do_Processo FOREIGN KEY (N_Do_Processo) REFERENCES Proposta(N_Do_Processo),
	CONSTRAINT FK_id_reuniao FOREIGNKEY (id_reuniao) REFERENCES Reunião(id_reuniao),
);

CREATE TABLE julga_2 (
	id_pessoa 		number,
	N_Do_Processo	number,
	Id_reuniao		number,
	justificativa	varchar(4000),
	recorrencia		varchar(4000),
	
	CONSTRAINT PK_Julga PRIMARY KEY (id_pessoa,N_Do_Processo, Id_reuniao),
	CONSTRAINT FK_id_pessoa_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),
	CONSTRAINT FK_ N_Do_Processo FOREIGN KEY (N_Do_Processo) REFERENCES Proposta(N_Do_Processo),
	CONSTRAINT FK_id_reuniao FOREIGNKEY (id_reuniao) REFERENCES Reunião(id_reuniao),
);


-------------------------------------
----------Parecer
-------------------------------------

CREATE TABLE Parecer (
	id_pessoa NUMBER,
	id_departamento NUMBER,
	codigo_edital NUMBER,
	num_processo NUMBER,
	num_extensao NUMBER,
	num_parecer NUMBER,
	descrição VARCHAR2(500),

	constraint Parecer_pk primary key (id_pessoa, id_departamento, codigo_edital, num_processo, num_extensao, num_parecer),
	constraint Parecer_tramitacao_fk foreign key (num_processo, id_pessoa, id_departamento, codigo_edital, num_extensao) 
		references Tramitacao (num_processo, id_pessoa, id_departamento, codigo_edital, num_extensao)
);

-------------------------------------
----------Aprovador e Alteração
-------------------------------------

CREATE TABLE Aprovador (
	Numero_UFSCar	NUMBER,
	CONSTRAINT PK_Aprovador PRIMARY KEY (Numero_UFSCar),
	CONSTRAINT FK_Aprovador FOREIGN KEY (Numero_UFSCar) REFERENCES Servidor (Numero_UFSCar)
);

CREATE TABLE AlteracaoVerba (
	Numero_UFSCar_Apr		NUMBER,
	Numero_UFSCar_Sol		NUMBER,
	Data 					DATE,
	Estado_da_aprovacao		VARCHAR2(1000),
	Valor					NUMBER,
	Destino					VARCHAR2(1000),
	Origem					VARCHAR2(1000),
	CONSTRAINT PK_AlteracaoVerba PRIMARY KEY (Numero_UFSCar, Data),
	CONSTRAINT FK_AlteracaoVerba_Sol FOREIGN KEY (Numero_UFSCar_Sol) REFERENCES Coordenador (Numero_UFSCar),
	CONSTRAINT FK_AlteracaoVerba_Apr FOREIGN KEY (Numero_UFSCar_Apr) REFERENCES Servidor (Numero_UFSCar)
);

CREATE TABLE AlteracaoConteudo (
	Numero_UFSCar_Apr		NUMBER,
	Numero_UFSCar_Sol		NUMBER,
	Data 					DATE,
	Estado_da_aprovacao		VARCHAR2(1000),
	Conteudo_substituido	VARCHAR2(4000),
	CONSTRAINT PK_AlteracaoVerba PRIMARY KEY (Numero_UFSCar, Data),
	CONSTRAINT FK_AlteracaoVerba_Sol FOREIGN KEY (Numero_UFSCar_Sol) REFERENCES Coordenador (Numero_UFSCar),
	CONSTRAINT FK_AlteracaoVerba_Apr FOREIGN KEY (Numero_UFSCar_Apr) REFERENCES Servidor (Numero_UFSCar)
);

CREATE TABLE AlteracaoIntegrante (
	Numero_UFSCar_Apr		NUMBER,
	Numero_UFSCar_Sol		NUMBER,
	Data 					DATE,
	Estado_da_aprovacao		VARCHAR2(1000),
	Status					VARCHAR2(1000),
	CONSTRAINT PK_AlteracaoVerba PRIMARY KEY (Numero_UFSCar, Data),
	CONSTRAINT FK_AlteracaoVerba_Sol FOREIGN KEY (Numero_UFSCar_Sol) REFERENCES Coordenador (Numero_UFSCar),
	CONSTRAINT FK_AlteracaoVerba_Apr FOREIGN KEY (Numero_UFSCar_Apr) REFERENCES Servidor (Numero_UFSCar)
);

