const questionModel = require("../models/questionModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


//fazer filtro pra se o subtopico n for compatível com o tópico dar erro!
async function getQuestionController(req, res) {
    const {subject, topic, subTopic, difficulty, searchType, howMany} = req.body;
    try {
        if (searchType == "all") {
            const questions = await questionModel.getQuestionByAllModel(subject, topic, subTopic, difficulty, howMany);
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
        let points;
        if (context == "league") {
            for (let i = 0; i < accuracy.length; i++) {
                points += accuracy[i];
            }
            //usuário recebe os pontos aqui
        }
    } catch (error) {
        
    }
}

//passar isso pro leagueController
async function leagueUpgrade(req, res) {
    const {userId, userType} = req.userData;
    const leagues = ["Iron", "Bronze", "Silver", "Gold"];
    try {
        const userLeague = await questionModel.verifyUserLeague(userId);
        const nextLeague = leagues.indexOf(userLeague) + 1;
        if (nextLeague >= leagues.length) {
            return res.status(500).json({message:"Você está na maior liga possível!"})
        }
        const newLeague = await questionModel.existLeagues(nextLeague);
        if (!newLeague) {
            await questionModel.createNewLeague(nextLeague);
            await insertUserNewLeague(userId, nextLeague);
        }
    } catch (error) {
        
    }
    
}

module.exports = {getQuestionController};