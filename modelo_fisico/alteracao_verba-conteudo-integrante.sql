CREATE TABLE alteracao_verba(
		data_verba DATE NOT NULL PRIMARY KEY,
  	nro_extensao_verba NUMBER NOT NULL PRIMARY KEY,
  	id_pessoa_verba NUMBER NOT NULL PRIMARY KEY,
  	valor FLOAT NOT NULL,
  	destino VARCHAR(30),
  	origem  VARCHAR(30),

		CONSTRAINT alteracao_verba_fk_alteracao FOREIGN KEY (data_verba) REFERENCES alteracao(data)
  	CONSTRAINT alteracao_verba_fk_extensao FOREIGN KEY (nro_extensao_verba) REFERENCES extensao(nro_extensao)
  	CONSTRAINT alteracao_verba_fk_coordenador FOREIGN KEY (id_pessoa_verba) REFERENCES extensao(id_pessoa)
);

CREATE TABLE alteracao_conteudo(
		data_conteudo DATE NOT NULL PRIMARY KEY,
  	nro_extensao_conteudo NUMBER NOT NULL PRIMARY KEY,
  	id_pessoa_conteudo NUMBER NOT NULL PRIMARY KEY,
  	conteudo_substituido VARCHAR(30),

		CONSTRAINT alteracao_conteudo_fk_alteracao FOREIGN KEY (data_conteudo) REFERENCES alteracao(data)
  	CONSTRAINT alteracao_conteudo_fk_extensao FOREIGN KEY (nro_extensao_conteudo) REFERENCES extensao(nro_extensao)
  	CONSTRAINT alteracao_conteudo_fk_coordenador FOREIGN KEY (id_pessoa_conteudo) REFERENCES extensao(id_pessoa)
);

CREATE TABLE alteracao_integrante(
		data_integrante DATE NOT NULL PRIMARY KEY,
  	nro_extensao_integrante NUMBER NOT NULL PRIMARY KEY,
  	id_pessoa_integrante NUMBER NOT NULL PRIMARY KEY,
  	status VARCHAR(30),

		CONSTRAINT alteracao_integrante_fk_alteracao FOREIGN KEY (data_integrante) REFERENCES alteracao(data)
  	CONSTRAINT alteracao_integrante_fk_extensao FOREIGN KEY (nro_extensao_integrante) REFERENCES extensao(nro_extensao)
  	CONSTRAINT alteracao_integrante_fk_coordenador FOREIGN KEY (id_pessoa_integrante) REFERENCES extensao(id_pessoa)
);
