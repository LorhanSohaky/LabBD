CREATE TABLE edital(
	codigo NUMBER NOT NULL PRIMARY KEY,
	data_abertura DATE NOT NULL,
	data_encerramento DATE NULL,
	justificativa VARCHAR2(100) NOT NULL,
	tipo VARCHAR2(30) NOT NULL,
	titulo VARCHAR2(30) NOT NULL,
	reoferta VARCHAR2(3)
);

CREATE TABLE proponente(
	codigo_edital NUMBER NOT NULL,
	proponente VARCHAR2(30),
	
	PRIMARY KEY (codigo_edital,proponente),
	CONSTRAINT proponente_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE objetivo(
	codigo_edital NUMBER NOT NULL,
	objetivo VARCHAR2(50),
	
	PRIMARY KEY (codigo_edital,objetivo),
	CONSTRAINT objetivo_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE cronograma(
	codigo_edital NUMBER NOT NULL,
	atividade VARCHAR2(50),
	data DATE,
	
	PRIMARY KEY (codigo_edital,atividade,data),
	CONSTRAINT cronograma_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE disposicoes_gerais(
	codigo_edital NUMBER NOT NULL,
	disposicao VARCHAR2(150),
	
	PRIMARY KEY (codigo_edital,disposicao),
	CONSTRAINT disposicoes_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE edital_atividade(
	codigo_edital NUMBER NOT NULL PRIMARY KEY,

	CONSTRAINT edital_atividade_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);

CREATE TABLE edital_programa(
	codigo_edital NUMBER NOT NULL PRIMARY KEY,

	CONSTRAINT edital_programa_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
);