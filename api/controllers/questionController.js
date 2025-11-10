const questionModel = require("../models/questionModel");
const leagueModel = require("../models/leagueModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


async function getQuestionController(req, res) {
    const {subTopic, difficulty, howMany} = req.body;
    try {
        if (searchType == "all") {
            const questions = await questionModel.getQuestionByAllModel(subTopic, difficulty, howMany);
            if (questions.length > 0) {
                res.status(200).json({message:questions});
            }
            else{
                res.status(500).json({message:"Nenhuma questão encontrada"});
            }
        }
        
    } catch (error) {
        res.status(500).json({message:"Invalid search type"});
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