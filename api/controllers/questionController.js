const questionModel = require("../models/questionModel");
const leagueModel = require("../models/leagueModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


// Em questionController.js

async function getQuestionController(req, res) {
    // Agora recebemos o NOME do subtópico e o NÚMERO da dificuldade
    const {subTopic, difficulty, howMany} = req.body; 

    // Mapa para converter o NÚMERO (do Flutter) para a STRING (do DB)
    const difficultyMap = {
        1: 'Fácil',
        2: 'Médio',
        3: 'Difícil'
    };
    const difficultyString = difficultyMap[difficulty]; // Converte 1 -> "Fácil"

    // Validação caso a dificuldade não exista
    if (!difficultyString) {
        return res.status(400).json({ message: "Dificuldade inválida." });
    }

    try {
        // Removemos o 'if (searchType == "all")' que estava quebrado
        // Passamos o NOME do subtópico e a STRING da dificuldade para o Model
        const questions = await questionModel.getQuestionByAllModel(subTopic, difficultyString, howMany);
        
        if (questions.length > 0) {
            res.status(200).json({message: questions});
        } else {
            // 404 (Not Found) é melhor que 500 (Server Error)
            res.status(404).json({message: "Nenhuma questão encontrada"});
        }
        
    } catch (error) {
        console.error("Erro no getQuestionController:", error);
        res.status(500).json({message: "Erro interno ao buscar questões"});
    }
}

async function addPointsContextConnection(req, res) {
    const {context, accuracy} = req.body;
    const {userId, userType} = req.userData;
    try {
        if (context == "league") {
            let points;
            for (let i = 0; i < accuracy.length; i++) {
                points += accuracy[i];
            }
            const leagueId = await leagueModel.verifyUserLeagueAndPoints(userId);
            const newPoints = leagueId[1] + points;
            await questionModel.addPoints(userId, leagueId, newPoints);
        }
    } catch (error) {
        
    }
}

async function getQuestionInfoController(req, res) {
  
  try { 
    const repeatedQuestionsObject = await questionModel.getQuestionInfoModel(); 
    
    const questions = {};

    for (const row of repeatedQuestionsObject) {
      
      const subject = row.subject;  
      const topic = row.topic;     
      const subtopic = row.subtopic; 

      if (!questions[subject]) {
        questions[subject] = {}; 
      }
      
      if (!questions[subject][topic]) {
        questions[subject][topic] = [];
      }
      
      questions[subject][topic].push(subtopic);
    }
    
    res.status(200).json({message: questions});

  } catch (error) {
    console.error("Erro no getQuestionInfoController:", error);
    res.status(500).json({ message: "Erro interno no servidor." });
  }
}

module.exports = {getQuestionController, getQuestionInfoController, addPointsContextConnection};