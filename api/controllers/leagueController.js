const questionModel = require("../models/questionModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

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