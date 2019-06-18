CREATE TABLE edital(
	codigo NUMBER NOT NULL PRIMARY KEY,
	data_abertura DATE NOT NULL,
	data_encerramento DATE NULL,
	justificativa VARCHAR2(2000) NOT NULL,
	tipo VARCHAR2(30) NOT NULL, -- pode ser de Projetos, Cursos, Eventos, Consultorias, Publicações, Produtos, eventos ou palestras
	titulo VARCHAR2(130) NOT NULL,
	reoferta NUMBER(1,0) CHECK (reoferta=0 OR reoferta=1)-- utilizando como atributo booleano
);

CREATE SEQUENCE edital_seq START WITH 1;

CREATE OR REPLACE TRIGGER edital_insert 
BEFORE INSERT ON edital
FOR EACH ROW

BEGIN
	SELECT edital_seq.NEXTVAL
	INTO   :new.codigo
	FROM   dual;
END;

CREATE TABLE bolsa(
	codigo_edital NUMBER NOT NULL,
	bolsa VARCHAR2(100),
	
	PRIMARY KEY (codigo_edital,bolsa),
	CONSTRAINT bolsa_fk_edital FOREIGN KEY (codigo_edital) REFERENCES edital(codigo)
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

/*Pessoa(PK(id_pessoa), nome, senha, uf, cidade, bairro, rua, numero);*/
CREATE TABLE Pessoa
(
	id_pessoa INT CONSTRAINT pk_pessoa PRIMARY KEY,
	nome VARCHAR(30) CONSTRAINT pessoa_nome_nnu NOT NULL,
	senha VARCHAR(30) CONSTRAINT pessoa_senha_nnu NOT NULL,
	uf VARCHAR(2),
	cidade VARCHAR(30),
	bairro VARCHAR(30),
	rua VARCHAR(30),
	numero INT
);

/*Pessoa_Telefone(PK(FK_Pessoa(id_pessoa), fixo, ddd, ddi));*/
CREATE TABLE Pessoa_Telefone
(
	id_pessoa INT NOT NULL,
	fixo VARCHAR2(9) NOT NULL,
	ddd CHAR(2) NOT NULL,
	ddi VARCHAR2(4),
	
	CONSTRAINT pk_pessoa_telefone PRIMARY KEY (id_pessoa, fixo, ddd, ddi),
	CONSTRAINT fk_pessoa_telefone_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*Pessoa_Email(PK(FK_Pessoa(id_pessoa), email));*/
CREATE TABLE Pessoa_Email
(
	id_pessoa INT NOT NULL,
	email VARCHAR2(30) NOT NULL,
	
	CONSTRAINT pk_pessoa_email PRIMARY KEY (id_pessoa, email),
	CONSTRAINT fk_pessoa_email_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*PessoaBrasileira(PK(cpf), FK_Pessoa(id_pessoa));*/
CREATE TABLE PessoaBrasileira
(
	cpf CHAR(11) NOT NULL,
	id_pessoa INT NOT NULL,
	
	CONSTRAINT pk_pessoaBrasileira PRIMARY KEY (id_pessoa, cpf),
	CONSTRAINT fk_pessoaBrasileira_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*PessoaEstrangeira(PK(passaporte), FK_Pessoa(id_pessoa));*/
CREATE TABLE PessoaEstrangeira
(
	passaporte CHAR(8) NOT NULL,
	id_pessoa INT NOT NULL,
	
	CONSTRAINT pk_pessoaEstrangeira PRIMARY KEY (id_pessoa, passaporte),
	CONSTRAINT fk_pessoaEstrangeira_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*Departamento(PK(id_departamento), nome);*/
CREATE TABLE Departamento
(
	id_departamento INT CONSTRAINT pk_departamento PRIMARY KEY,
	nome VARCHAR(30)
);

/*PessoaGraduacao(PK(FK_Pessoa(id_pessoa)), nro_ufscar);*/
CREATE TABLE PessoaGraduacao
(
	id_pessoa INT NOT NULL,
	nro_ufscar INT NOT NULL,
	
	CONSTRAINT pk_pessoaGraduacao PRIMARY KEY (id_pessoa),
	CONSTRAINT fk_pessoaGraduacao_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

/*PessoaPosgraduacao(PK(FK_Pessoa(id_pessoa)), nro_ufscar);*/
CREATE TABLE PessoaPosgraduacao
(
	id_pessoa INT NOT NULL,
	nro_ufscar INT NOT NULL,
	
	CONSTRAINT pk_pessoaposgraduacao PRIMARY KEY (id_pessoa),
	CONSTRAINT fk_pessoaposgraduacao_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);


/*PessoaServidor(PK(FK_Pessoa(id_pessoa), FK_Departamento(id_departamento)), nro_ufscar, data_contratacao);*/
CREATE TABLE PessoaServidor
(
	id_pessoa INT,
	id_departamento INT CONSTRAINT fk_pessoaServidor_departamento REFERENCES Departamento(id_departamento),
	nro_ufscar INT,
	data_contratacao DATE,
	CONSTRAINT pk_pessoaServidor PRIMARY KEY (id_pessoa, id_departamento)	
);

/*PessoaServidorDocente(PK(FK_PessoaServidor(id_pessoa, id_departamento)), titulo, cargo, setor, tipo, data_ingresso);*/

CREATE TABLE PessoaServidorDocente
(
	id_pessoa INT NOT NULL,
	id_departamento INT NOT NULL,
	titulo VARCHAR2(30) NOT NULL,
	cargo VARCHAR2(30) NOT NULL,
	setor VARCHAR2(30) NOT NULL,
	tipo VARCHAR2(30) NOT NULL,
	data_ingresso DATE,
	CONSTRAINT pk_pessoaservidordocente PRIMARY KEY (id_pessoa, id_departamento),
	CONSTRAINT fk_pessoaservidordocente_pessoaservidor FOREIGN KEY (id_pessoa, id_departamento) REFERENCES PessoaServidor(id_pessoa, id_departamento)
);

/*PessoaServidorTecnico(PK(FK_PessoaServidor(id_pessoa, id_departamento)));*/

CREATE TABLE PessoaServidorTecnico
(
	id_pessoa INT NOT NULL,
	id_departamento INT NOT NULL,
	CONSTRAINT fk_pessoaservidortecnico_pessoaservidor FOREIGN KEY (id_pessoa, id_departamento) REFERENCES PessoaServidor(id_pessoa, id_departamento),
	CONSTRAINT pk_pessoaservidortecnico PRIMARY KEY (id_pessoa, id_departamento)
);

/*Curso(PK(id_curso), FK_Departamento(id_departamento));*/

CREATE TABLE Curso
(
	id_curso INT NOT NULL,
	id_departamento INT NOT NULL,
	CONSTRAINT fk_curso_departamento FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento),
	CONSTRAINT pk_curso PRIMARY KEY (id_curso)
);

/*Financiador(PK(id_financiador), agencia, tipo_controle);*/

CREATE TABLE Financiador
(
	id_financiador INT NOT NULL,
	agencia VARCHAR2(10),
	tipo_controle VARCHAR2(10),
	CONSTRAINT pk_financiador PRIMARY KEY (id_financiador)
);

/*Extensao(PK(nro_extensao), nro_extensao_anterior);*/

CREATE TABLE Extensao
(
	nro_extensao INT NOT NULL,
	nro_extensao_anterior INT,
	CONSTRAINT pk_extensao PRIMARY KEY (nro_extensao)
);

/*ProgramaDeExtensao(PK(FK_Extensao(nro_extensao)), palavras_chave, titulo, resumo, comunidade_atingida, anotacoes_ProEx, inicio);*/
CREATE TABLE ProgramaDeExtensao
(
	nro_extensao INT NOT NULL,
	palavras_chave VARCHAR(50),
	titulo VARCHAR(30) NOT NULL, 
	resumo CLOB, 
	comunidade_atingida VARCHAR(50), 
	anotacoes_ProEx CLOB, 
	inicio DATE,
	
	CONSTRAINT pk_programaDeExtensao PRIMARY KEY (nro_extensao),
	CONSTRAINT fk_programaDeExtensao_extensao FOREIGN KEY (nro_extensao) REFERENCES Extensao(nro_extensao)
);

/*Area(PK(id_area), nome_area);*/
CREATE TABLE Area
(
	id_area INT NOT NULL,
	nome_area VARCHAR(50) NOT NULL,
	CONSTRAINT pk_area PRIMARY KEY (id_area)
);

/*Area_tem_subareas(PK(FK_Area(id_area), id_subarea), nome_area);*/
CREATE TABLE Area_tem_subareas
(
	id_area INT NOT NULL,
	id_subarea INT NOT NULL,
	nome_area VARCHAR(50) NOT NULL,
	CONSTRAINT pk_area_tem_subareas PRIMARY KEY (id_area, id_subarea),
	CONSTRAINT fk_area_tem_subareas_area FOREIGN KEY (id_area) REFERENCES Area(id_area)
);

/*AtividadeDeExtensao(PK(FK_Extensao(nro_extensao)), FK_ProgramaDeExtensao(nro_extensao_pr), FK_Financiador(id_financiador), FK1_Area(id_area_pr), FK2_Area(id_area_se), publico_alvo, palavras_chave, resumo, inicio_real, fim_real, inicio_previsto, fim_previsto, data_aprovacao, tipo_atividade, titulo, status);*/
CREATE TABLE AtividadeDeExtensao
(
	nro_extensao INT NOT NULL,
	nro_extensao_programa INT NOT NULL,
	id_financiador INT NOT NULL,
	id_area_pr INT NOT NULL, 
	id_area_se INT NOT NULL,
	publico_alvo VARCHAR(50), 
	palavras_chave VARCHAR(50), 
	resumo CLOB, 
	inicio_real DATE, 
	fim_real DATE, 
	inicio_previsto DATE, 
	fim_previsto DATE, 
	data_aprovacao DATE, 
	tipo_atividade VARCHAR(20), 
	titulo VARCHAR(30), 
	status VARCHAR(20),
	
	CONSTRAINT pk_atividadeDeExtensao PRIMARY KEY (nro_extensao),
	CONSTRAINT fk_atividadeDeExtensao_extensao FOREIGN KEY (nro_extensao) REFERENCES Extensao(nro_extensao),
	CONSTRAINT fk_atividadeDeExtensao_programaDeExtensao FOREIGN KEY (nro_extensao_programa) REFERENCES ProgramaDeExtensao(nro_extensao),
	CONSTRAINT fk_atividadeDeExtensao_financiador FOREIGN KEY (id_financiador) REFERENCES Financiador(id_financiador),
	CONSTRAINT fk_atividadeDeExtensao_area1 FOREIGN KEY (id_area_pr) REFERENCES Area(id_area),
	CONSTRAINT fk_atividadeDeExtensao_area2 FOREIGN KEY (id_area_se) REFERENCES Area(id_area)
);

/*Aciepe(PK(FK_AtividadeDeExtensao(nro_extensao)), horario_aulas, ementa, carga_horaria_prevista);*/
CREATE TABLE Aciepe
(
	nro_extensao INT NOT NULL,
	horario_aulas VARCHAR(30),
	ementa CLOB,
	carga_horaria_prevista INT,
	CONSTRAINT pk_Aciepe PRIMARY KEY (nro_extensao),
	CONSTRAINT pk_Aciepe_AtividadeDeExtensao FOREIGN KEY (nro_extensao) REFERENCES AtividadeDeExtensao(nro_extensao)
);

/*Aciepe_Encontros(PK(FK_Aciepe(nro_extensao), data, horario, local, campus));*/
CREATE TABLE Aciepe_Encontros
(
	nro_extensao INT NOT NULL,
	data DATE, 
	horario VARCHAR(20), 
	local VARCHAR(30), 
	campus VARCHAR(15),
	
	CONSTRAINT pk_Aciepe_Encontros PRIMARY KEY (nro_extensao),
	CONSTRAINT fk_Aciepe_Encontros_Aciepe FOREIGN KEY (nro_extensao) REFERENCES Aciepe(nro_extensao)
);

/*Participante(PK(FK_Pessoa(id_pessoa), FK_AtividadeDeExtensao(nro_extensao)), frequencia, avaliacao);*/
CREATE TABLE Participante
(
	id_pessoa INT NOT NULL,
	nro_extensao INT NOT NULL,
	frequencia INT,
	avaliacao FLOAT,
	
	CONSTRAINT pk_Participante PRIMARY KEY (id_pessoa, nro_extensao),
	CONSTRAINT fk_Participante_Pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa),
	CONSTRAINT fk_Participante_AtividadeDeExtensao FOREIGN KEY (nro_extensao) REFERENCES AtividadeDeExtensao(nro_extensao)
);

/*Selecao(PK(id_selecao), nro_inscritos, vagas_interno, vagas_externo);*/
CREATE TABLE Selecao
(	
	id_selecao INT NOT NULL, 
	nro_inscritos INT, 
	vagas_interno INT, 
	vagas_externo INT,
	CONSTRAINT pk_Selecao PRIMARY KEY (id_selecao)
);

/*Participante_participa_Selecao(PK(FK_Participante(id_pessoa, nro_extensao), FK_Selecao(id_selecao)), declaracao_presenca, selecionado);*/
CREATE TABLE Participante_participa_Selecao
(
	id_pessoa INT NOT NULL,
	nro_extensao INT NOT NULL,
	id_selecao INT NOT NULL,
	declaracao_presenca VARCHAR(10),
	selecionado NUMBER(1,0) CHECK (selecionado=0 OR selecionado=1),
	CONSTRAINT pk_Participante_participa_Selecao PRIMARY KEY (id_pessoa, nro_extensao, id_selecao),
	CONSTRAINT fk_Participante_participa_Selecao_Participante FOREIGN KEY (id_pessoa, nro_extensao) REFERENCES Participante(id_pessoa, nro_extensao),
	CONSTRAINT fk_Participante_participa_Selecao_Selecao FOREIGN KEY (id_selecao) REFERENCES Selecao(id_selecao)
);


