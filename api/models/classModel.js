const db = require("../db");

// Função corrigida para retornar a Promise corretamente
async function createClass(name, teachercode, studentcode, schoolcode) {
    try {
        const query = "INSERT INTO class (name, teachercode, studentcode, schoolcode) VALUES (?,?,?,?)";
        // Usamos .promise() para poder usar await e pegar o resultado real
        const [result] = await db.promise().query(query, [name, teachercode, studentcode, schoolcode]);
        return result.affectedRows > 0;
    } catch (error) {
        console.error("Erro no createClass:", error);
        return false;
    }
}

async function enterClass(name, code, userId) {
    try {
        // 1. Achar a turma pelo nome
        const query1 = "SELECT * FROM class WHERE name = ?";
        const [classes] = await db.promise().query(query1, [name]);

        if (classes.length === 0) return false; // Turma não existe
        
        const selectedClass = classes[0];
        const classId = selectedClass.id;

        // 2. Verificar código e inserir
        const queryTeacher = "INSERT INTO teacherclass (teacher_id, class_id) VALUES (?,?)"; // Nomes das colunas corrigidos conforme seu SQL anterior (teacher_id, class_id)
        const queryStudent = "INSERT INTO studentclass (student_id, class_id) VALUES (?,?)"; // (student_id, class_id)

        if (code == selectedClass.teachercode) {
            const [result] = await db.promise().query(queryTeacher, [userId, classId]);
            return result.affectedRows > 0;
        } 
        else if (code == selectedClass.studentcode) {
            const [result] = await db.promise().query(queryStudent, [userId, classId]);
            return result.affectedRows > 0;
        } 
        else {
            return false; // Código errado
        }
    } catch (error) {
        console.error("Erro no enterClass:", error);
        return false;
    }
}

async function getSchoolClass(userId, userType) {
    try {
        let queryIds = "";
        let idColumn = "";
        let table = "";

        // Define qual tabela buscar baseado no tipo
        if (userType === "student") {
            table = "studentclass";
            idColumn = "student_id"; // Corrigido para bater com seu SQL
        } else if (userType === "teacher") {
            table = "teacherclass";
            idColumn = "teacher_id"; // Corrigido para bater com seu SQL
        } else if (userType === "school") {
            // Lógica específica para escola
            const query = "SELECT * FROM class WHERE schoolcode = ?"; // Assumindo que schoolcode guarda o ID ou código da escola
            // Nota: Se schoolcode na tabela class for String e userId for Int, verifique a lógica aqui.
            // Abaixo segue a lógica para buscar direto da tabela class
            const [results] = await db.promise().query(query, [userId]); // Se userId for o schoolcode
            return results;
        } else {
            return [];
        }

        // Busca os IDs das turmas que o aluno/professor participa
        const queryRel = `SELECT class_id FROM ${table} WHERE ${idColumn} = ?`;
        const [relations] = await db.promise().query(queryRel, [userId]);

        if (relations.length === 0) return [];

        // Extrai apenas os IDs (ex: [1, 2, 5])
        const classIds = relations.map(rel => rel.class_id);

        // Busca os dados dessas turmas
        // "IN (?)" funciona automaticamente com arrays no mysql2
        const queryClasses = "SELECT * FROM class WHERE id IN (?)";
        const [classes] = await db.promise().query(queryClasses, [classIds]);

        return classes;

    } catch (error) {
        console.error("Erro no getSchoolClass:", error);
        return null;
    }
}

module.exports = {
    createClass,
    enterClass,
    getSchoolClass
}