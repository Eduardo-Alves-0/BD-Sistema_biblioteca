Sistema de Biblioteca - SQL
Descrição do Projeto
 - Este projeto é um banco de dados MySQL que simula um sistema de biblioteca.

Permitir gerar:
 - Livros
 - Usuários (Alunos, Professores, Funcionários)(Alunos, Professores, Funcionários)
 - Emprésimos

O projeto é público para estudos de SQL: criação de tabelas, relacionamentos (FK), inserção de dados e consultas avançadas com JOIN, GROUP BY e ORDER BY.

🗂 Estrutura do Banco de Dados
Tabelas e Atributos
Mesa Campos principais
livros id_livros, título, autor, editora, genero, quantidade_estoque, data_publicacao
usuarios id, nome, contato, tipoUsuario (Aluno/Professor/Funcionário)
alunos idAluno (FK → usuarios.id), matricula
professores idProfessor (FK → usuarios.id), matricula
funcionários idFuncionario (FK → usuarios.id), funcao, setor
impressões idEmprestimo, idUsuario (FK), idLivro (FK), dataEmprestimo, dataDevolucaoPrevista, dataDevolucao, status

💾 População de Dados
Exemplos de servidores no banco:
 - Livros:
   "Dom Casmurro"
   "1984"
   "Ó Hobbit"
   "A Culpa é das Estrelas"
   "Código Limpo"

Usuários:
 - Ana Souza (Aluno)
 - Carlos Lima (Professor)
 - Fernanda Alves (Funcionária)
 - João Mendes (Aluno)
 - Mariana Rocha (Professora)

Estimantes:
Alguns já devolvidos, outros ativos ou atrasados

🔎 Consultas de Exemplo
1️⃣ Listar todos os livros
SELEÇÃO * DE livros;

2️⃣ Estimativos de um uso específico
SELETIVO 
 e.idEmprestimo,    
 u.nome,           
 l.titulo,         
 e.dataEmprestimo, 
 e.dataDevolucao   
DE empresas e
JUNTE-SE a usuarios u ON e.idUsuario = u.id
JUNTE-SE a livros l ON e.idLivro = l.id_livros
ONDE u.id = 2;

3️⃣ Livros mais empregados
SELETIVO 
 l.titulo, 
 COUNT(e.idEmprestimo) COMO totalEmprestimos
DE livros l
JUNTE-SE a empregados e ON l.id_livros = e.idLivro
GRUPO POR l.id_livros, l.titulo
ORDEM POR totalEmprestimos DESC;

4️⃣ Usuários com mais atrasos
SELETIVO 
 u.nome, 
 COUNT(*) COMO totalAtrasos
DE usuários u
JUNTE-SE a empregados e ON u.id = e.idUsuario
ONDE e.dataDevolucao > e.dataDevolucaoPrevista
AGRUPAR POR u.id, u.nome
ORDEM POR totalAtrasos DESC;

⚡ Como Executar

Clone o repositório:
 - clone git https://github.com/seu-usuario/sistema-biblioteca-sql.git

Abra no MySQL Workbench ou outro cliente MySQL.
Executar o script SQL:

 - sistema_biblioteca.sql

Teste como consultas de exemplo para visualizar os dados.

🛠 Tecnologias
MySQL

SQL padrão (DDL, DML e consultas)

📚 Objetivos de Aprendizado
 - Criar e organizar tabelas relacionais
 - Definir chaves primárias e estrelas
 - Inserir dados com INSERIR
 - Fazer consultas avançadas com JOIN, GROUP BY e ORDER BY
 - Criar relatórios e filtros com ONDE
