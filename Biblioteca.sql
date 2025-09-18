
CREATE DATABASE sistema_biblioteca;
USE sistema_biblioteca;

-- Tabela de livros
CREATE TABLE livros(
    id_livros BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL, 
    autor VARCHAR(255) NOT NULL,
    editora VARCHAR(255) NOT NULL,
    genero VARCHAR(255) NOT NULL,
    quantidade_estoque INT,
    data_publicacao DATE
);

-- Tabela de usuários
CREATE TABLE usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    contato VARCHAR(50) NOT NULL,
    tipoUsuario ENUM('Aluno', 'Professor', 'Funcionario') NOT NULL
);

-- Subtipos de usuários
CREATE TABLE alunos (
    idAluno BIGINT PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL,
    FOREIGN KEY (idAluno) REFERENCES usuarios(id)
);

CREATE TABLE professores (
    idProfessor BIGINT PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL,
    FOREIGN KEY (idProfessor) REFERENCES usuarios(id)
);

CREATE TABLE funcionarios (
    idFuncionario BIGINT PRIMARY KEY,
    funcao VARCHAR(50) NOT NULL,
    setor VARCHAR(50),
    FOREIGN KEY (idFuncionario) REFERENCES usuarios(id)
);

-- Empréstimos
CREATE TABLE emprestimos (
    idEmprestimo BIGINT AUTO_INCREMENT PRIMARY KEY,
    idUsuario BIGINT NOT NULL,
    idLivro BIGINT NOT NULL,
    dataEmprestimo DATE NOT NULL,
    dataDevolucaoPrevista DATE NOT NULL,
    dataDevolucao DATE,
    status VARCHAR(20) DEFAULT 'Ativo',
    FOREIGN KEY (idUsuario) REFERENCES usuarios(id),
    FOREIGN KEY (idLivro) REFERENCES livros(id_livros)
);

-- ===========================================
-- 📚 INSERÇÃO DE DADOS
-- ===========================================

-- Livros
INSERT INTO livros (titulo, autor, editora, genero, quantidade_estoque, data_publicacao) VALUES
('Dom Casmurro', 'Machado de Assis', 'Editora Globo', 'Romance', 5, '1899-01-01'),
('1984', 'George Orwell', 'Companhia das Letras', 'Ficção Científica', 8, '1949-06-08'),
('O Hobbit', 'J.R.R. Tolkien', 'HarperCollins', 'Fantasia', 10, '1937-09-21'),
('A Culpa é das Estrelas', 'John Green', 'Intrínseca', 'Romance', 7, '2012-01-10'),
('Clean Code', 'Robert C. Martin', 'Pearson', 'Programação', 4, '2008-08-01');

-- Usuários
INSERT INTO usuarios (nome, contato, tipoUsuario) VALUES
('Ana Souza', 'ana@email.com', 'Aluno'),
('Carlos Lima', 'carlos@email.com', 'Professor'),
('Fernanda Alves', 'fernanda@email.com', 'Funcionario'),
('João Mendes', 'joao@email.com', 'Aluno'),
('Mariana Rocha', 'mariana@email.com', 'Professor');

-- Alunos
INSERT INTO alunos (idAluno, matricula) VALUES
(1, 'A2023001'),
(4, 'A2023002');

-- Professores
INSERT INTO professores (idProfessor, matricula) VALUES
(2, 'P2023101'),
(5, 'P2023102');

-- Funcionários
INSERT INTO funcionarios (idFuncionario, funcao, setor) VALUES
(3, 'Bibliotecária', 'Atendimento');

-- Empréstimos
INSERT INTO emprestimos (idUsuario, idLivro, dataEmprestimo, dataDevolucaoPrevista, dataDevolucao, status) VALUES
(1, 1, '2023-05-01', '2023-05-08', '2023-05-07', 'Devolvido'),
(2, 2, '2023-05-02', '2023-05-17', '2023-05-20', 'Atrasado'),
(4, 3, '2023-05-10', '2023-05-17', NULL, 'Ativo'),
(5, 5, '2023-05-12', '2023-05-27', '2023-05-25', 'Devolvido');

-- ===========================================
-- CONSULTAS
-- ===========================================

-- 1️ Lista de todos os livros
SELECT * FROM livros;

-- 2️ Empréstimos por usuário específico (ex: usuário ID = 1)
SELECT 
    e.idEmprestimo,    
    u.nome,           
    l.titulo,         
    e.dataEmprestimo, 
    e.dataDevolucao   
FROM emprestimos e
JOIN usuarios u ON e.idUsuario = u.id
JOIN livros l ON e.idLivro = l.id_livros
WHERE u.id = 2;

-- 3️ Livros mais emprestados
SELECT 
    l.titulo, 
    COUNT(e.idEmprestimo) AS totalEmprestimos
FROM livros l
JOIN emprestimos e ON l.id_livros = e.idLivro
GROUP BY l.id_livros, l.titulo
ORDER BY totalEmprestimos DESC;

-- 4️ Usuários com mais atrasos
SELECT 
    u.nome, 
    COUNT(*) AS totalAtrasos
FROM usuarios u
JOIN emprestimos e ON u.id = e.idUsuario
WHERE e.dataDevolucao > e.dataDevolucaoPrevista
GROUP BY u.id, u.nome
ORDER BY totalAtrasos DESC;
