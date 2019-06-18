DROP TABLE Tramitacao;
DROP TABLE Anotacoes;
DROP TABLE LinhaProgramatica;
DROP TABLE PalavrasChave;
DROP TABLE Parcerias;
DROP TABLE SetoresParticipantes;
DROP TABLE Tramita;
DROP TABLE Proposta;
DROP TABLE Submete;
DROP TABLE Demandante;
DROP TABLE Extensao;
DROP TABLE PessoaServidor;
DROP TABLE Departamento;
DROP TABLE Edital;

-- Tabela incompleta, cadastrando somente a chave primária
CREATE TABLE PessoaServidor(
    id_pessoa NUMBER NOT NULL,
    CONSTRAINT PK_PessoaServidor PRIMARY KEY (id_pessoa)
);

-- Tabela incompleta, cadastrando somente a chave primária
CREATE TABLE Departamento(
    id_departamento NUMBER NOT NULL,
    CONSTRAINT PK_Departamento PRIMARY KEY (id_departamento)
);

-- Tabela incompleta, cadastrando somente a chave primária
CREATE TABLE Edital(
    codigo NUMBER NOT NULL,
    CONSTRAINT PK_Edital PRIMARY KEY (codigo)
);

-- Tabela incompleta, cadastrando somente a chave primária
CREATE TABLE Extensao(
    N_da_extensao NUMBER NOT NULL,
    CONSTRAINT PK_Extensao PRIMARY KEY (N_da_extensao)
);



CREATE TABLE Demandante(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	nro_ufscar NUMBER NOT NULL,
	data_contratacao DATE,
	
	CONSTRAINT PK_Demandante PRIMARY KEY (id_pessoa,id_departamento),
	
	CONSTRAINT FK_PessoaServidor_id_pessoa FOREIGN KEY (id_pessoa) REFERENCES PessoaServidor(id_pessoa),
	CONSTRAINT FK_Departamento_id_departamento FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

CREATE TABLE Submete(
	codigo NUMBER NOT NULL,
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	
	CONSTRAINT PK_Submete PRIMARY KEY (codigo, id_pessoa, id_departamento),
	
	CONSTRAINT FK_Edital_codigo FOREIGN KEY (codigo) REFERENCES Edital(codigo),
	CONSTRAINT FK_Demandante_ids FOREIGN KEY (id_pessoa,id_departamento) REFERENCES Demandante(id_pessoa,id_departamento)
);

CREATE TABLE Proposta(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	codigo NUMBER NOT NULL,
	nro_processo NUMBER NOT NULL,
	tipo VARCHAR2(20),
	status VARCHAR2(20),
	areatematica_grandearea VARCHAR2(50),
	areatematica_areasecundaria VARCHAR2(50),
	areatematica_areaprincipal VARCHAR2(50),
	resumo VARCHAR2(50),
	comunidade_atingida VARCHAR2(50),
	publico_alvo VARCHAR2(50),
	DataFim date,
	DataInicio date NOT NULL,
	descricao VARCHAR(50),
	setor_responsavel VARCHAR2(50),
	abrangencia VARCHAR2(50),
	
	CONSTRAINT PK_Proposta PRIMARY KEY (id_pessoa, id_departamento, nro_processo),
	
	CONSTRAINT FK_Submete_ids FOREIGN KEY (codigo, id_pessoa, id_departamento) REFERENCES Submete(codigo, id_pessoa, id_departamento)
);

CREATE TABLE SetoresParticipantes(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	nro_processo NUMBER	NOT NULL,
	setores VARCHAR2(50),
	
	CONSTRAINT PK_SetoresParticipantes PRIMARY KEY (id_pessoa, id_departamento, nro_processo),
	
	CONSTRAINT FK_Proposta_ids1 FOREIGN KEY (id_pessoa, id_departamento, nro_processo) REFERENCES Proposta(id_pessoa, id_departamento, nro_processo)
);

CREATE TABLE Parcerias(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	nro_processo NUMBER	NOT NULL,
	setores VARCHAR2(50),
	
	CONSTRAINT PK_Parcerias PRIMARY KEY (id_pessoa, id_departamento, nro_processo),
	
	CONSTRAINT FK_Proposta_ids2 FOREIGN KEY (id_pessoa, id_departamento, nro_processo) REFERENCES Proposta(id_pessoa, id_departamento, nro_processo)
);

CREATE TABLE PalavrasChave(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	nro_processo NUMBER	NOT NULL,
	palavras VARCHAR2(50),
	
	CONSTRAINT PK_PalavrasChave PRIMARY KEY (id_pessoa, id_departamento, nro_processo),
	
	CONSTRAINT FK_Proposta_ids3 FOREIGN KEY (id_pessoa, id_departamento, nro_processo) REFERENCES Proposta(id_pessoa, id_departamento, nro_processo)
);

CREATE TABLE LinhaProgramatica(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	nro_processo NUMBER	NOT NULL,
	data1 DATE,
	horario TIMESTAMP,
	atividade VARCHAR2(50),
	
	CONSTRAINT PK_LinhaProgramatica PRIMARY KEY (id_pessoa, id_departamento, nro_processo),
	
	CONSTRAINT FK_Proposta_ids4 FOREIGN KEY (id_pessoa, id_departamento, nro_processo) REFERENCES Proposta(id_pessoa, id_departamento, nro_processo)
);

CREATE TABLE Anotacoes(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	nro_processo NUMBER	NOT NULL,
	anotacoes VARCHAR2(200),
	
	CONSTRAINT PK_Anotacoes PRIMARY KEY (id_pessoa, id_departamento, nro_processo),
	
	CONSTRAINT FK_Proposta_ids5 FOREIGN KEY (id_pessoa, id_departamento, nro_processo) REFERENCES Proposta(id_pessoa, id_departamento, nro_processo)
);

CREATE TABLE Tramita(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	nro_processo NUMBER	NOT NULL,
	N_da_extensao NUMBER NOT NULL,
	
	CONSTRAINT PK_Tramita PRIMARY KEY (id_pessoa, id_departamento, nro_processo, N_da_extensao),
	
	CONSTRAINT FK_Proposta_ids6 FOREIGN KEY (id_pessoa, id_departamento, nro_processo) REFERENCES Proposta(id_pessoa, id_departamento, nro_processo),
	CONSTRAINT FK_Extensao FOREIGN KEY (N_da_extensao) REFERENCES Extensao(N_da_extensao)
);

CREATE TABLE Tramitacao(
	id_pessoa NUMBER NOT NULL,
	id_departamento NUMBER NOT NULL,
	nro_processo NUMBER	NOT NULL,
	N_da_extensao NUMBER NOT NULL,
	julgamento VARCHAR2(50),
	tipo VARCHAR2(20),
	data1 date,
	
	CONSTRAINT PK_Tramitacao PRIMARY KEY (id_pessoa, id_departamento, nro_processo, N_da_extensao),
	
	CONSTRAINT FK_Tramita_ids1 FOREIGN KEY (id_pessoa, id_departamento, nro_processo, N_da_extensao) REFERENCES Tramita(id_pessoa, id_departamento, nro_processo, N_da_extensao)
);
