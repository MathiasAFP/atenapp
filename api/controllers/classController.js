const classModel = require("../models/classModel");
require('dotenv').config();

async function createClass(req, res) {
    const {id, userType} = req.userData;
    const {name, teacherCode, studentCode} = req.body;
    try {
      console.log("Body:", req.body);
      console.log("User:", req.userData);

      const classCreated = await classModel.createClass(name, teacherCode, studentCode, id);

      return res.status(200).json({ message: "Turma criada com sucesso" });
      } 
   catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Erro crítico", error: error.message });
      }

    
}

async function enterClass(req, res) {
   console.log("dsfdfsdfsdfsdf")
    const {id, userType} = req.userData;
    const {name, code} = req.body;
    try {
      const enterClass = await classModel.enterClass(name, code, id);
      console.log(enterClass);
       if (enterClass) {
        return res.status(200).json({message:`Entrou em: ${name}`})
       } else {
        return res.status(500).json({message:"Erro ao entrar em turma"})
       }
    } catch (error) {
       res.status(500).json({message:"Erro crítico"}); 
    }
}

async function getSchoolClass(req, res) {
    const {id, userType} = req.userData;

    try {
       const yourClasses = await classModel.getSchoolClass(id, userType);
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