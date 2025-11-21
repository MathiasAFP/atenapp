const classModel = require("../models/classModel");
require('dotenv').config();

async function createClass(req, res) {
    const {userId, userType} = req.userData;
    const {name, teachercode, studentcode} = req.body;
    try {
       if (classModel.createClass(name,teachercode,studentcode,userId)) {
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
       
    } catch (error) {
       res.status(500).json({message:"Erro crítico"}); 
    }
}

async function getSchoolClass(req, res) {
    const {userId, userType} = req.userData;

    try {
       
    } catch (error) {
       res.status(500).json({message:"Erro crítico"}); 
    }
    
}

module.exports = {
    createClass,
    enterClass,
    getSchoolClass
}