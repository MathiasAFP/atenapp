const classModel = require("../models/classModel");
require('dotenv').config();

async function createClass(req, res) {
    const {userId, userType} = req.userData;
    const {name, teacherCode, studentCode} = req.body;
    try {
       if (await classModel.createClass(name,teacherCode,studentCode,userId)) {
        return res.status(200).json({message:"Turma criada com sucesso"});
       } else {
        return res.status(500).json({message:"Erro ao criar turma"});
       }
    } catch (error) {
       return res.status(500).json({message:"Erro crítico"}); 
    }
    
}

async function enterClass(req, res) {
    const {userId, userType} = req.userData;
    const {name, code} = req.body;
    try {
       if (await classModel.enterClass(name, code, userId)) {
        return res.status(200).json({message:`Entrou em: ${name}`})
       } else {
        return res.status(500).json({message:"Erro ao entrar em turma"})
       }
    } catch (error) {
       res.status(500).json({message:"Erro crítico"}); 
    }
}

async function getSchoolClass(req, res) {
    const {userId, userType} = req.userData;

    try {
       const yourClasses = await classModel.getSchoolClass(userId, userType);
       if (yourClasses) {
        return res.status(200).json({message:yourClasses});
       } else {
        return res.status(500).json({message:"Erro ao retornar suas turmas"});
       }
    } catch (error) {
       res.status(500).json({message:"Erro crítico"}); 
    }
    
}

module.exports = {
    createClass,
    enterClass,
    getSchoolClass
}