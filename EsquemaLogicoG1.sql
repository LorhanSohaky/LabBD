Pessoa(PK(id_pessoa), nome, senha, uf, cidade, bairro, rua, numero);

Pessoa_Telefone(PK(FK_Pessoa(id_pessoa), fixo, ddd, ddi));

Pessoa_Email(PK(FK_Pessoa(id_pessoa), email));

PessoaBrasileira(PK(cpf), FK_Pessoa(id_pessoa));

PessoaEstrangeira(PK(passaporte), FK_Pessoa(id_pessoa));

PessoaGraduacao(PK(FK_Pessoa(id_pessoa)), nro_ufscar);

PessoaPosgraduacao(PK(FK_Pessoa(id_pessoa)), nro_ufscar);

PessoaServidor(PK(FK_Pessoa(id_pessoa), FK_Departamento(id_departamento)), nro_ufscar, data_contratacao);

PessoaServidorDocente(PK(FK_PessoaServidor(id_pessoa)), titulo, cargo, setor, tipo, dia, mes, ano);

PessoaServidorTecnico(PK(FK_PessoaServidor(id_pessoa)));

Departamento(PK(id_departamento), nome);

Curso(PK(id_curso, FK_Departamento(id_departamento));

Financiador(PK(id_financiador), agencia, tipo_controle);

Extensao(PK(nro_extensao), nro_extensao_anterior);

ProgramaDeExtensao(PK(FK_Extensao(nro_extensao)), palavras_chave, titulo, resumo, comunidade_atingida, anotacoes_ProEx, inicio);

Area(PK(id_area), nome_area);

Area_tem_subareas(PK(FK_Area(id_area), id_subarea), nome_area);

AtividadeDeExtensao(PK(FK_Extensao(nro_extensao), FK_ProgramaDeExtensao(nro_extensao), FK_Financiador(id_financiador), FK1_Area(id_area)), FK2_Area(id_area),publico_alvo, palavras_chave, resumo, inicio_real, fim_real, inicio_previsto, fim_previsto, data_aprovacao, tipo_atividade, titulo, status);

Aciepe(PK(FK_AtividadeDeExtensao(nro_extensao)), horario_aulas, ementa, carga_horaria_prevista);

Aciepe_Encontros(PK(FK_Aciepe(nro_extensao), data, horario, local, campus));

Participante(PK(FK_Pessoa(id_pessoa), FK_AtividadeDeExtensao(nro_extensao)), frequencia, avaliacao);

Selecao(PK(id_selecao), nro_inscritos, vagas_interno, vagas_externo);

Participante_participa_Selecao(PK(FK_Participante(id_pessoa, nro_extensao), FK_Selecao(id_selecao)), declaracao_presenca, selecionado);














