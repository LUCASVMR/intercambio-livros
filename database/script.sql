-- Seleciona o banco de dados criado pelo Docker
USE intercambio_livros;

-- Tabela de Usuários (Padrão do Professor)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabela de Livros (Padrão do Professor)
CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabela de Trocas (Padrão do Professor)
CREATE TABLE trocas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_oferecido_id INT,
    livro_recebido_id INT,
    FOREIGN KEY (livro_oferecido_id) REFERENCES livros(id),
    FOREIGN KEY (livro_recebido_id) REFERENCES livros(id)
);

-- Inserindo um usuário de teste para aparecer na sua index.jsp
INSERT INTO usuarios (nome, email) VALUES ('Bruno', 'bruno@teste.com');