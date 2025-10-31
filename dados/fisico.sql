CREATE DATABASE sistema_emprego;
\c sistema_emprego;


CREATE TABLE empresa (
    id_empresa SERIAL NOT NULL,
    nome_empresa VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    descricao VARCHAR(500),
    CONSTRAINT empresa_PK PRIMARY KEY (id_empresa)
);


CREATE TABLE gestor (
    id_gestor SERIAL NOT NULL,
    nome_gestor VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    id_empresa INTEGER NOT NULL,
    CONSTRAINT gestor_PK PRIMARY KEY (id_gestor),
    CONSTRAINT gestor_empresa_FK FOREIGN KEY (id_empresa)
        REFERENCES empresa (id_empresa)
);


CREATE TABLE candidato (
    id_usuario SERIAL NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    data_nasc DATE,
    cidade VARCHAR(50),
    resumo VARCHAR(150),
    situacao_empregatica VARCHAR(20),
    CONSTRAINT candidato_PK PRIMARY KEY (id_usuario)
);


CREATE TABLE experiencia (
    id_experiencia SERIAL NOT NULL,
    id_usuario INTEGER NOT NULL,
    nome_instituicao VARCHAR(100),
    cargo VARCHAR(100),
    periodo_experiencia INTEGER,
    descricao_cargo VARCHAR(500),
    nome_curso VARCHAR(100),
    grau_educacional VARCHAR(50),
    CONSTRAINT experiencia_PK PRIMARY KEY (id_experiencia),
    CONSTRAINT experiencia_candidato_FK FOREIGN KEY (id_usuario)
        REFERENCES candidato (id_usuario)
);


CREATE TABLE vagaDeEmprego (
    id_vaga_de_emprego SERIAL NOT NULL,
    id_empresa INTEGER NOT NULL,
    nome_vaga_de_emprego VARCHAR(100) NOT NULL,
    data DATE,
    cidade VARCHAR(50),
    estado VARCHAR(50),
    salario NUMERIC,
    cargo VARCHAR(50),
    nivel VARCHAR(50),
    tipo_contrato VARCHAR(50),
    modalidade VARCHAR(50),
    descricao VARCHAR(200),
    CONSTRAINT vagaDeEmprego_PK PRIMARY KEY (id_vaga_de_emprego),
    CONSTRAINT vagaDeEmprego_empresa_FK FOREIGN KEY (id_empresa)
        REFERENCES empresa (id_empresa)
);


CREATE TABLE candidatura (
    id_candidatura SERIAL NOT NULL,
    id_candidato INTEGER NOT NULL,
    id_vaga_de_emprego INTEGER NOT NULL,
    status_candidatura VARCHAR(50),
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT candidatura_PK PRIMARY KEY (id_candidatura),
    CONSTRAINT candidatura_candidato_FK FOREIGN KEY (id_candidato)
        REFERENCES candidato (id_usuario),
    CONSTRAINT candidatura_vagaDeEmprego_FK FOREIGN KEY (id_vaga_de_emprego)
        REFERENCES vagaDeEmprego (id_vaga_de_emprego)
);


CREATE TABLE notificacao (
    id_notificacao SERIAL NOT NULL,
    id_candidatura INTEGER NOT NULL,
    id_vaga_de_emprego INTEGER NOT NULL,
    titulo VARCHAR(50),
    mensagem VARCHAR(50),
    visualizado BOOLEAN DEFAULT FALSE,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT notificacao_PK PRIMARY KEY (id_notificacao),
    CONSTRAINT notificacao_candidatura_FK FOREIGN KEY (id_candidatura)
        REFERENCES candidatura (id_candidatura),
    CONSTRAINT notificacao_vagaDeEmprego_FK FOREIGN KEY (id_vaga_de_emprego)
        REFERENCES vagaDeEmprego (id_vaga_de_emprego)
);


CREATE TABLE users (
    id SERIAL NOT NULL,
    name VARCHAR(100),
    email VARCHAR(150),
    CONSTRAINT users_PK PRIMARY KEY (id)
);
