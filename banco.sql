CREATE DATABASE Aulas_particulares;
USE Aulas_particulares;
--- TABELAS ---
CREATE TABLE alunos(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(120) NOT NULL,
    senha VARCHAR(12) NOT NULL,
    nome VARCHAR(120) NOT NULL,
    sobrenome VARCHAR(120) NOT NULL,
    nome_social VARCHAR(120) NOT NULL,
    horario_matricula DATETIME NOT NULL,
    termos_concordados BOOLEAN NOT NULL DEFAULT FALSE);
    
CREATE TABLE professores(
	id_professor INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(120) NOT NULL,
    senha VARCHAR(12) NOT NULL,
    nome VARCHAR(120) NOT NULL,
    sobrenome VARCHAR(120) NOT NULL);
    
CREATE TABLE matérias(
	id_materia INT PRIMARY KEY AUTO_INCREMENT,
    id_professor INT,
    nome_materia VARCHAR(120) NOT NULL,
    preco_materia DECIMAL(10.4) NOT NULL,
    FOREIGN KEY (id_professor) REFERENCES professores (id_professor));
    
CREATE TABLE horários(
	id_horario INT PRIMARY KEY AUTO_INCREMENT,
    dia_horario DATETIME,
    `status` VARCHAR(10) DEFAULT 'LIVRE',
    id_materia INT,
    id_professor INT,
    id_aluno INT,
    FOREIGN KEY (id_aluno) REFERENCES alunos (id_aluno),
    FOREIGN KEY (id_professor) REFERENCES professores (id_professor),
    FOREIGN KEY (id_materia) REFERENCES matérias (id_materia));
 
 CREATE TABLE pagamentos(
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_materia INT,
    id_aluno INT,
    `status` BOOLEAN NOT NULL DEFAULT FALSE,
    data_expiracao DATETIME NOT NULL,
    FOREIGN KEY (id_materia) REFERENCES materias (id_materia),
    FOREIGN KEY (id_aluno) REFERENCES alunos (id_aluno));
    
CREATE TABLE logs;

