USE intercambio_livros;

-- Tabela de Usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL -- Nova coluna adicionada!
);

-- Tabela de Livros 
CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabela de Trocas
CREATE TABLE trocas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_oferecido_id INT,
    livro_recebido_id INT,
    status VARCHAR(20) DEFAULT 'PENDENTE',
    FOREIGN KEY (livro_oferecido_id) REFERENCES livros(id),
    FOREIGN KEY (livro_recebido_id) REFERENCES livros(id)
);;

INSERT INTO usuarios (nome, email) VALUES ('Bruno', 'bruno@teste.com');