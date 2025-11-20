const mysql = require('mysql2');
require('dotenv').config();

// Configuração do Pool
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 5,
    queueLimit: 0,
    enableKeepAlive: true,
    keepAliveInitialDelay: 0
});

// --- CORREÇÃO AQUI EMBAIXO ---
// NÃO existe pool.connect(). O jeito certo de testar é assim:

pool.getConnection((err, connection) => {
    if (err) {
        console.error('Erro ao conectar no Pool do MySQL:', err.message);
    } else {
        console.log('Conectado ao Pool do MySQL com sucesso!');
        connection.release(); // IMPORTANTE: Devolve a conexão para o pool
    }
});

// Exporta o pool para ser usado nos models
module.exports = pool;