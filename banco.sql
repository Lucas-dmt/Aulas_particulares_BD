CREATE DATABASE Aulas_particulares;
USE Aulas_particulares;
--- TABELAS ---
CREATE TABLE alunos(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(120) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    nome VARCHAR(120) NOT NULL,
    sobrenome VARCHAR(120) NOT NULL,
    nome_social VARCHAR(120),
    horario_matricula DATETIME NOT NULL,
    termos_concordados BOOLEAN NOT NULL DEFAULT FALSE ,
    termos_lgpd BOOLEAN DEFAULT FALSE , 
    data_lgpd DATETIME
    );
    
CREATE TABLE professores(
	id_professor INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(120) NOT NULL,
    senha VARCHAR(12) NOT NULL,
    nome VARCHAR(120) NOT NULL,
    sobrenome VARCHAR(120) NOT NULL , 
    termos_lgpd BOOLEAN DEFAULT FALSE , 
    data_lgpd DATETIME
    );
    
CREATE TABLE materias(
	id_materia INT PRIMARY KEY AUTO_INCREMENT,
    id_professor INT,
    nome_materia VARCHAR(120) NOT NULL,
    preco_materia DECIMAL(10,4) NOT NULL,
    FOREIGN KEY (id_professor) REFERENCES professores (id_professor));
    
CREATE TABLE horarios(
	id_horario INT PRIMARY KEY AUTO_INCREMENT,
    dia_horario DATETIME,
    `status` VARCHAR(20) DEFAULT 'LIVRE',
    id_materia INT,
    id_professor INT,
    id_aluno INT,
    FOREIGN KEY (id_aluno) REFERENCES alunos (id_aluno),
    FOREIGN KEY (id_professor) REFERENCES professores (id_professor),
    FOREIGN KEY (id_materia) REFERENCES materias (id_materia));
 
 CREATE TABLE pagamentos(
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_materia INT,
    id_aluno INT,
    metodo_pagamento VARCHAR(10),
    `status` BOOLEAN NOT NULL DEFAULT FALSE,
    data_expiracao DATETIME NOT NULL,
    FOREIGN KEY (id_materia) REFERENCES materias (id_materia),
    FOREIGN KEY (id_aluno) REFERENCES alunos (id_aluno));

CREATE TABLE funcionarios_servicos(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome_funcionario VARCHAR(120) NOT NULL,
    cargo VARCHAR(80),
    servico VARCHAR(120),
    salario DECIMAL(10,2)
);

CREATE TABLE logs(
    id_log INT PRIMARY KEY AUTO_INCREMENT , 
    tabela_afetada VARCHAR(50) ,
    operacao VARCHAR(20) ,
    descricao TEXT , 
    usuario_tipo VARCHAR(100) ,
    id_usuario INT , 
    data_hora DATETIME ,
    id_registro INT
);
--- INSERIR DADOS ---
INSERT INTO alunos (login, senha, nome, sobrenome, nome_social, horario_matricula, termos_concordados, termos_lgpd, data_lgpd) VALUES 
("joice123", "123456", "Joice","Ariane","", "2026-05-28 10:05:00",TRUE, TRUE, "2026-05-28 10:05:00"),
("Lucas1511", "151107", "Lucas", "Da mata","", "2026-05-30 09:44:00", TRUE, TRUE, "2026-05-30 09:44:00"),
("Victor3567", "3567", "Victor", "Marucci", "", "2026-05-30 18:00:00", TRUE, TRUE, "2026-05-30 18:00:00"),
("Eduardo2525", "2525", "Eduardo", "Monteiro", "", "2026-06-15 15:15:00", TRUE, TRUE, "2026-06-15 15:15:00");

INSERT INTO professores (login, senha, nome, sobrenome, termos_lgpd, data_lgpd) VALUES
("Alexandre453", "45316", "Alexandre", "Monteiro", TRUE, "2026-05-28 09:00:00"),
("Lucia1789", "1789", "Lúcia","Filomena", TRUE, "2026-05-28 09:10:00");

INSERT INTO materias (id_professor, nome_materia, preco_materia) VALUES
(1, "Algébra linear", 50.00),
(2, "Algoritmos de programação", 60.00);

INSERT INTO horarios(dia_horario, status, id_materia, id_professor, id_aluno) VALUES 
("2026-06-15", "OCUPADO", 1, 1, 1),
("2026-06-17", "OCUPADO", 2,2,2),
("2026-07-01", "OCUPADO", 2,2,3),
("2026-07-14", "OCUPADO", 1,1,4);

INSERT INTO funcionarios_servicos
(nome_funcionario, cargo, servico, salario)
VALUES
("Carlos Silva","Secretário","Atendimento",2500.00),
("Marina Souza","Financeiro","Controle de pagamentos",3200.00),
("João Lima","Suporte","Agendamento de aulas",2800.00);

INSERT INTO pagamentos(id_materia, id_aluno, metodo_pagamento, status, data_expiracao) VALUES
(1, 1, "PIX", TRUE, "2026-08-20"),
(2, 3, "Cartao", TRUE, "2026-08-18"),
(1, 2, "Cartao", TRUE, "2026-09-12"),
(2, 4, "PIX", TRUE, "2026-09-25");
INSERT INTO logs(tabela_afetada, operacao, descricao, usuario_tipo, data_hora, id_registro) VALUES
("alunos", "INSERT", "Cadastro de novo aluno", "aluno", "2026-05-28 10:00:00", 1), 
("alunos", "INSERT", "Cadastro de novo aluno", "aluno", "2026-05-28 10:50:00", 2), 
("professores", "INSERT", "Cadastro de novo professor", "professor", "2026-04-15 09:00:00", 1),
("pagamentos", "INSERT", "Pagamento realizado via PIX", "aluno", "2026-06-01 10:00:00", 1),
("horarios", "DELETE", "Aula cancelada pelo aluno", "aluno", "2026-06-02 15:00:00", 2),
("horarios", "INSERT", "Aula agendada pelo aluno", "aluno", "2026-06-01 14:00:00", 1);

--- VISUALIZAR DADOS ---
SELECT a.nome, a.sobrenome, h.dia_horario, h.status
FROM alunos a
JOIN horarios h ON a.id_aluno = h.id_aluno;

SELECT p.nome, p.sobrenome, m.nome_materia, m.preco_materia
FROM professores p
JOIN materias m ON p.id_professor = m.id_professor;

SELECT * FROM logs
ORDER BY data_hora DESC;

SELECT COUNT(*) AS total_pagamentos
FROM pagamentos
WHERE status = TRUE;

SELECT 
    a.nome,
    m.nome_materia,
    pg.metodo_pagamento,
    pg.status,
    pg.data_expiracao
FROM pagamentos pg
LEFT JOIN alunos a ON pg.id_aluno = a.id_aluno
LEFT JOIN materias m ON pg.id_materia = m.id_materia;

SELECT 
    h.dia_horario,
    a.nome AS aluno,
    p.nome AS professor,
    m.nome_materia,
    h.status
FROM horarios h
JOIN alunos a ON h.id_aluno = a.id_aluno
JOIN professores p ON h.id_professor = p.id_professor
JOIN materias m ON h.id_materia = m.id_materia;


SELECT nome, sobrenome, data_criacao
FROM alunos;

SELECT nome_funcionario, cargo, servico, salario
FROM funcionarios_servicos;

SELECT metodo_pagamento, COUNT(*) AS quantidade
FROM pagamentos
GROUP BY metodo_pagamento;











