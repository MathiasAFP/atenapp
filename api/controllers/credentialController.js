const credentialModel = require("../models/credentialModel");//arquivo que contem as funções do model
const bcrypt = require('bcrypt');//biblioteca de criptografia
const jwt = require('jsonwebtoken');//biblioteca para tokens
require('dotenv').config();

async function credentialControllerSignup(req, res) { //nome padronizado com nome do arquivo mais sua função
    const {name, email, password, school_name, your_code} = req.body;//armazenar os valores da requisição
    
    try{//assincronismo
      const whichSchool = await credentialModel.whichSchool(school_name);//verificar qual é a escola
      const school_id = whichSchool.id;//salvar o id da escola
      const teacher_code = whichSchool.teachercode;//salvar o código de professor da escola
      const student_code = whichSchool.studentcode;//salvar o código de estudante da escola

      if (teacher_code == your_code) {//verificar se é professor
        await credentialModel.teacherSignup(name, email, password);
        const teacher = await credentialModel.searchTeacher(name);
        await credentialModel.doSchoolTeacherRelation(school_id, teacher.id);
      }

      if (student_code == your_code) {//verificar se é aluno
        await credentialModel.studentSignup(name, email, password)
        const student = await credentialModel.searchStudent(name);
        await credentialModel.doSchoolStudentRelation(school_id, teacher.id);
      }
    }

    catch{
        res.status(500).json({message: "UserSignUpControllerError"});
    }
};

module.exports = {credentialControllerSignup};