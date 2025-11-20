const mysql = require('mysql2');
require('dotenv').config();
const connection = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 5, // Limite baixo pois bancos grátis aceitam poucas conexões simultâneas
    queueLimit: 0,
    enableKeepAlive: true, // Ajuda a não deixar a conexão morrer
    keepAliveInitialDelay: 0
});
connection.connect((err) => {
 if (err) {
 console.error('Erro ao conectar ao MySQL:', err.message);
 } else {
 console.log('Conectado ao MySQL com sucesso!');
 }
});
module.exports = connection;