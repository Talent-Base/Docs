CREATE TYPE papel_enum AS ENUM ('candidato', 'gestor', 'admin');


CREATE TABLE usuario (
    id SERIAL NOT NULL,
    nome VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    senha VARCHAR NOT NULL,
    papel papel_enum NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,

    CONSTRAINT usuario_PK PRIMARY KEY (id),
    CONSTRAINT usuario_email_UK UNIQUE (email)
);

CREATE INDEX usuario_nome_IDX ON usuario (nome);
CREATE INDEX usuario_email_IDX ON usuario (email);


CREATE TABLE empresa (
    id_empresa SERIAL NOT NULL,
    nome_empresa VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(3) NOT NULL,
    email_contato VARCHAR(100),
    descricao VARCHAR(2000),

    CONSTRAINT empresa_PK PRIMARY KEY (id_empresa),
    CONSTRAINT empresa_nome_empresa_UK UNIQUE (nome_empresa),
    CONSTRAINT empresa_cnpj_UK UNIQUE (cnpj)
);


CREATE TABLE candidato (
    id_candidato INTEGER NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    titulo_profissional VARCHAR(100),
    estado VARCHAR(3),
    cidade VARCHAR(50),
    resumo VARCHAR(1500),
    situacao_empregaticia VARCHAR(20),

    CONSTRAINT candidato_PK PRIMARY KEY (id_candidato),
    CONSTRAINT candidato_email_UK UNIQUE (email),
    CONSTRAINT candidato_usuario_FK FOREIGN KEY (id_candidato)
        REFERENCES usuario (id) ON DELETE CASCADE
);

CREATE INDEX candidato_nome_IDX ON candidato (nome);
CREATE INDEX candidato_email_IDX ON candidato (email);


CREATE TABLE gestor (
    id_gestor INTEGER NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    id_empresa INTEGER,

    CONSTRAINT gestor_PK PRIMARY KEY (id_gestor),
    CONSTRAINT gestor_email_UK UNIQUE (email),
    CONSTRAINT gestor_usuario_FK FOREIGN KEY (id_gestor)
        REFERENCES usuario (id) ON DELETE CASCADE,
    CONSTRAINT gestor_empresa_FK FOREIGN KEY (id_empresa)
        REFERENCES empresa (id_empresa)
);

CREATE INDEX gestor_email_IDX ON gestor (email);


CREATE TABLE experiencia (
    id_experiencia SERIAL NOT NULL,
    id_candidato INTEGER NOT NULL,
    nome_instituicao VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    periodo_experiencia VARCHAR(20) NOT NULL,
    descricao VARCHAR(500),
    nome_curso VARCHAR(100),
    grau_obtido VARCHAR(50),

    CONSTRAINT experiencia_PK PRIMARY KEY (id_experiencia),
    CONSTRAINT experiencia_candidato_FK FOREIGN KEY (id_candidato)
        REFERENCES candidato (id_candidato) ON DELETE CASCADE
);

CREATE INDEX experiencia_candidato_IDX ON experiencia (id_candidato);


CREATE TABLE vagaDeEmprego (
    id_vaga_de_emprego SERIAL NOT NULL,
    id_empresa INTEGER NOT NULL,
    nome_vaga_de_emprego VARCHAR(100) NOT NULL,
    data DATE NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(3) NOT NULL,
    salario VARCHAR(20) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    tipo_contrato VARCHAR(50) NOT NULL,
    modalidade VARCHAR(50) NOT NULL,
    descricao VARCHAR(2000) NOT NULL,

    CONSTRAINT vagaDeEmprego_PK PRIMARY KEY (id_vaga_de_emprego),
    CONSTRAINT vagaDeEmprego_empresa_FK FOREIGN KEY (id_empresa)
        REFERENCES empresa (id_empresa) ON DELETE CASCADE
);

CREATE INDEX vaga_empresa_IDX ON vagaDeEmprego (id_empresa);


CREATE TABLE candidatura (
    id_candidatura SERIAL NOT NULL,
    id_candidato INTEGER NOT NULL,
    id_vaga_de_emprego INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL,
    data TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP,

    CONSTRAINT candidatura_PK PRIMARY KEY (id_candidatura),
    CONSTRAINT candidatura_candidato_FK FOREIGN KEY (id_candidato)
        REFERENCES candidato (id_candidato) ON DELETE CASCADE,
    CONSTRAINT candidatura_vagaDeEmprego_FK FOREIGN KEY (id_vaga_de_emprego)
        REFERENCES vagaDeEmprego (id_vaga_de_emprego) ON DELETE CASCADE
);

CREATE INDEX candidatura_candidato_IDX ON candidatura (id_candidato);
CREATE INDEX candidatura_vaga_IDX ON candidatura (id_vaga_de_emprego);
