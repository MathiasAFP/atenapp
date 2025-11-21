const classModel = require("../models/classModel");
require('dotenv').config();

async function createClass(req, res) {
    const {userId, userType} = req.userData;
    // CORREÇÃO 1: O Flutter manda teacherCode (camelCase), ajuste aqui para bater
    const {name, teacherCode, studentCode} = req.body; 
    
    try {
       // CORREÇÃO 2: Adicionado 'await' para esperar o banco responder
       // Se não esperar, o código quebra ou responde falso positivo
       const result = await classModel.createClass(name, teacherCode, studentCode, userId);
       
       if (result) {
        return res.status(200).json({message:"Turma criada com sucesso"});
       } else {
        return res.status(500).json({message:"Erro ao criar turma"});
       }
    } catch (error) {
       console.error(error); // Log para você ver o erro no Render
       return res.status(500).json({message:"Erro crítico no servidor"}); 
    }
}

async function enterClass(req, res) {
    const {userId, userType} = req.userData;
    const {name, code} = req.body;
    try {
       // CORREÇÃO 3: Adicionado 'await'
       const result = await classModel.enterClass(name, code, userId);
       
       if (result) {
        return res.status(200).json({message:`Entrou em: ${name}`})
       } else {
        return res.status(500).json({message:"Erro ao entrar em turma"})
       }
    } catch (error) {
       console.error(error);
       res.status(500).json({message:"Erro crítico"}); 
    }
}

async function getSchoolClass(req, res) {
    const {userId, userType} = req.userData;

    try {
       // CORREÇÃO 4: Adicionado 'await'
       const yourClasses = await classModel.getSchoolClass(userId, userType);
       if (yourClasses) {
        return res.status(200).json({message:yourClasses}); // Nota: O Flutter espera uma lista direta ou map? Cuidado com o 'message'
       } else {
        return res.status(500).json({message:"Erro ao retornar suas turmas"});
       }
    } catch (error) {
       console.error(error);
       res.status(500).json({message:"Erro crítico"}); 
    }
}

module.exports = {
    createClass,
    enterClass,
    getSchoolClass
}